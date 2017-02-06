/*
 Data Factory for Test Class
*/
@isTest
public  class TestDataFactory {

	 
	//Create generic record
	public static List<sObject> getListRecord(String SobjectName,Integer noOfRecord){
		
		List<sObject> listSobject = new List<sObject>();
		Schema.SObjectType t = Schema.getGlobalDescribe().get(SobjectName);
		
		for(Integer i=0; i<noOfRecord ;i++){
			SObject s = t.newSObject();
			listSobject.add(s);
		}
		
		return listSobject; 
	} 
	
	//create Account 
	public static List<Account> createAccountsWithOpps(Integer numAccts) {
	        List<Account> accts = new List<Account>();
	        
	        for(Integer i=0;i<numAccts;i++) {
	            Account a = new Account(Name='TestAccount' + i);
	            a.OwnerId = UserInfo.getUserId();
	            accts.add(a);
	        }
	        insert accts;
	        return accts;
	}
	
	//create Opportunity 
	public static List<Opportunity> createOpportunityList(List<Account> accts, Integer numOppsPerAcct){        
	        List<Opportunity> opps = new List<Opportunity>();
	        Integer asize = accts.isEmpty()?0 :accts.size();
	        for (Integer j=0;j<asize;j++) {
	            Account acct = accts[j];
	            // For each account just inserted, add opportunities
	            for (Integer k=0;k<numOppsPerAcct;k++) {
	                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
	                                       StageName='Prospecting',
	                                       CloseDate=System.today().addMonths(1),
	                                       AccountId=acct.Id));
	            }
	        }
	        // Insert all opportunities for all accounts.
	        insert opps;
	        
	        return opps;
	    }
	    
	//Create Contacts
	public static List<Contact> createContactList(List<Account> accts ,Integer numOfContact){
		
		List<Contact> contacts = new List<Contact>();
	        Integer asize = accts.isEmpty()?1 :accts.size();
	        for (Integer j=0;j<asize;j++) {
	            Account acct = accts.isEmpty() ? new Account() :accts[j];
	            // For each account just inserted, add opportunities
	            for (Integer k=0;k<numOfContact;k++) {
	                contacts.add(new Contact(FirstName = 'Contact'+k,
										   LastName = 'Name'+k,
	                                       AccountId=acct.Id,
	                                       Email = 'xyzmail@mail'+k+j+'.com',
										   Phone = '987654321'+k+j));
	            }
	        }
	        // Insert all Contacts for all accounts.
	        insert contacts;
	        
	        return contacts;
		
	 } 
	//Create Case
	public static List<Case> createCaseList(List<Account> accts ,list<Contact> contacts ,Integer numOfCase){
		
		    List<Case> cases = new List<Case>();
	        Integer asize = accts.isEmpty()?1 :accts.size();
	        for (Integer j=0;j<asize;j++) {
	            Account acct = accts.isEmpty() ? new Account() :accts[j];
	            Contact con = contacts.isEmpty() && contacts.size()<=j ?new Contact() :contacts[j];
	            // For each account just inserted, add opportunities
	            for (Integer k=0;k<numOfCase;k++) {
	                cases.add( new Case( ContactId = con.id,
									    AccountId = acct.Id,
									    Status = 'Working',
									    Origin = 'Phone'));
	            }
	        }
	        // Insert all Contacts for all accounts.
	        insert cases;
	        
	        return cases;
		
	 } 
	 
	 //Create User 
	 public static User createUser(){
	 	
	 	//Profile
        List<Profile> profiles = [Select Id from Profile where Name != 'Salesforce Administrator' limit 1];
    	
    	//Assert
    	system.assert(profiles.size()>0);
    	
    	//Insert User
        User user1 = new User();
             user1.ProfileId = profiles[0].Id;
             user1.UserName = Math.random() + '@test.com';
             user1.LastName='user1';
             user1.Alias = 'acqman';
             user1.Phone = '4545454544';
             user1.IsActive = true;
       
        insert user1;
        return user1;
	 }
	 
}