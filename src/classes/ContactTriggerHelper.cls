/*  created date 1/8/2017
*   description :- trigger helper to be used for Account Object
*/
public  class ContactTriggerHelper {
    
    //method to associate contact with correct account using website address and email domain
    public static void associateAccountwithContact(List<Contact> newlist , Map<Id,Contact> oldmap){
        //list of contact to be updated 
        set<String> listdomain = new Set<String>();
        //map account with account domain
        Map<String ,Id> mapAccountDomainwithAccount  = new Map<String,Id>();
        for(Contact contact : newlist){
            
            if(contact.Email != null 
              && (oldmap == null 
                  || !oldmap.containskey(contact.id) 
                  || contact.email != oldmap.get(contact.id).email)){
                    
                    listdomain.add(Contact.Email.subStringAfter('@'));
                  }
            }
        
        for(Account acc :[Select id ,site,Website from Account where Site IN :listdomain OR Website IN :listdomain ]){
            
            mapAccountDomainwithAccount.put(acc.website == null?acc.site : (acc.website != acc.site? acc.website : acc.site), acc.Id);
        }
        
        //Associating contact with respective account
        for(Contact contact : newlist){
            String domain = contact.email != null?contact.Email.subStringAfter('@') :'';
            if(contact.email != null 
               && listdomain.contains(domain)){
                            
                    contact.AccountId = mapAccountDomainwithAccount.containsKey(domain)? mapAccountDomainwithAccount.get(domain) :contact.AccountId;
               }
         }
     }
     
     
     
     
     /*
        Created date :- 1/14/2016
        ECS-11_Programmatic Model - 3 Set 1
        4. Contact Duplicate Check Trigger
        Create a new Trigger on Contact that will check for duplicates before allowing a new record
        into the database.
        Validate against the email address and phone number fields.
        An error be thrown with the error message – “A Contact with the same email address or
        phone number already exists in system.”
        Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
    */
    
    public static void checkForDuplicateContact(List<Contact> newContactlist){
        
        Map<String ,Contact> mapPhonewithContactId = new Map<String, Contact>();
        Map<String ,Contact> mapEmailwithContactId = new Map<String, Contact>();
        String ErroMessage = 'A Contact with the same email address or phone number being  inserted in system';
        for(Contact c : newContactlist){
            
            //below code will stop inserting two duplicate contact together with same email and contact 
            if(c.Phone!=null){
                 if(mapPhonewithContactId.containskey(c.Phone))
                    c.addError(ErroMessage);
                  else
                  mapPhonewithContactId.put(c.Phone , c);
            }
            if(c.Email!=null){
                if(mapEmailwithContactId.containskey(c.Email))
                    c.addError(ErroMessage);
                  else
                  mapEmailwithContactId.put(c.Email , c);
            }
        }
        
        //below code to check if already a contact with same email or phone availble 
        for(Contact contact :[Select Id ,Phone ,Email from Contact Where  (Phone In :mapPhonewithContactId.keySet() OR Email IN :mapEmailwithContactId.keySet()) And ID Not In :newContactlist ]){
            
            if(mapPhonewithContactId.Containskey(contact.Phone) || mapEmailwithContactId.containsKey(contact.Email))
            {
                Contact contactToshowError = mapPhonewithContactId.Containskey(contact.Phone)?mapPhonewithContactId.get(contact.Phone):mapEmailwithContactId.get(contact.Email);
                contactToshowError.addError(ErroMessage);
                 
            }
        }
    }
    
    
    
    
     //method to roll up Contact  Count on Account 
     public static void RollupContactOnAccount(List<Contact> newContacts ,Map<Id,Contact> oldMap){
     	List<Account> listAccountTobeUpdated = new List<Account>();
     	Set<Id> setAccountId = new Set<Id>();
     	for(Contact Contact : newContacts){
     		if(Contact.AccountId != null|| (oldMap != Null && oldMap.containsKey(Contact.id) && OldMap.get(Contact.id).Accountid != Contact.AccountId && Contact.AccountId == null))
     		setAccountId.add(Contact.AccountId != null?Contact.AccountId :OldMap.get(Contact.id).Accountid);
     	}
     	
     	//Aggregagte query on Contact 
        for(AggregateResult accountResult : [Select Count(Id) cnt, AccountId from Contact
                                                where  AccountId In :setAccountId Group By AccountId]) {
       
            // Add Account record for update
            listAccountTobeUpdated.add(
                new Account(
                    Id = String.valueOf(accountResult.get('AccountId')),
                    Total_Contact__c = Integer.valueOf(accountResult.get('cnt'))
                )
            ); 
         }
         
        if(!listAccountTobeUpdated.isEmpty()){
        	Database.update(listAccountTobeUpdated,false);
        } 
      }
}