/*
* B. Removal of duplicate Leads 
1. During the Campaigning, It might happen that representative creates duplicate leads in an org. 
2. So admin want to build a process which will run every 3 hours/day & remove the duplicate leads from 
the org. 
3. The criteria to find the duplicate records should be configurable. 

Ex. If there are two leads in a system with same Email address then keep the first lead entry & remove all 
the other leads. 
So the field like Email, Name which will be deciding the uniqueness should be configurable. 
*
*/

public  class BatchDeleteDuplicateLead implements Database.Batchable<sObject>,Database.Stateful{

   //default Query String can be customize using label
   public DateTime queryDate = Datetime.Now().addHours(-4); 
   public Set<String> setDubAttribute = new Set<String>();
   public String dubDecidingField = Label.LeadDublicateField ;
   public String query = 'Select Id ,'+dubDecidingField +' From Lead Where '+dubDecidingField+' != null And CreatedDate > :queryDate';
   //variabl to keep Duplicate Email
   public Set<String> setDupEmail = new Set<String>();
   
   //Default constructor
   public BatchDeleteDuplicateLead(){
   	
   }
   
   //paramaetrized constructor
   public BatchDeleteDuplicateLead(String Query){
   	 this.query = Query;
   }
    //Start Method , we use QueryLocator here
   public Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }
   
   
   public void execute(Database.BatchableContext BC, List<sObject> scope){
   
	   List<Lead> listLeadtoBeDeleted = new List<Lead>();
	   //finding all emails within leads
	   for(sObject lead : scope){
	   	setDupEmail.add(String.valueOf(lead.get(dubDecidingField)));   	
	   }
	   
	   //fetching all leads with provided set of String(duplicate criteria parameter)
	   String dubFinderQuery = 'Select Id ,'+dubDecidingField+' From Lead Where '+dubDecidingField+' IN :setDupEmail';
	   List<Lead> allOrgLeads = Database.query(dubFinderQuery);
	   for (Lead le : allOrgLeads) {
	   	   
	   	   If(setDubAttribute.contains(String.valueOf(le.get(dubDecidingField)))){
	   	   	listLeadtoBeDeleted.add(le);
	   	   }else{
	   	   	setDubAttribute.add(String.valueOf(le.get(dubDecidingField)));
	   	   }
	   	   
   		}
   		
   	  //deleting duplicate lead
   	  If(listLeadtoBeDeleted != null && !listLeadtoBeDeleted.IsEmpty())	{
   	  	Delete listLeadtoBeDeleted;
   	  }	 
   }
   
   
	public void finish(Database.BatchableContext BC){
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	   
        mail.setToAddresses(new List<String>{'saurabh0801229024@gmail.com'});
	 
		mail.setSenderDisplayName('Duplicate Lead Deleted ');
		mail.setSubject('Duplicate Lead Deleted ');
		String body = 'Deleted Lead Are from below emails :---';
		for(String opName : setDubAttribute){
			body = body + '\n' + opName + '';
		}
		mail.setPlainTextBody(body );
        if(!Test.isRunningTest()){  Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail} );}
       
    
	}

}