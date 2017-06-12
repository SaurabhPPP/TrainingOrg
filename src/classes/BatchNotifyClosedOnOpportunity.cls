/*
	*A. Collection of Closed Won Opportunities
	1. The Primary contact associated with an account needs to know which all are the closed won
	opportunities for his account per day.
	2. Create a process which will run every day in the midnight & collect all the Closed won opportunities of
	that account in a day & send an email to Primary Contact.
	3. The email body should contain the Opportunity Name & it's respective amount with the aggregated
	amount in the end.
	https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm
	
	*
*/
global  class BatchNotifyClosedOnOpportunity implements Database.Batchable<sObject>,Database.Stateful {

   global final String query = 'Select Id ,Name,(Select id ,Email from Contacts), (Select id ,Name ,StageName from Opportunities where StageName =\'Closed Won\') From Account';
   global Map<Id , List<String>> mapAccountIdWithContactEmails = new Map<Id ,List<String>>();
   global Map<Id , Map<String , Double>> mapAccountIdWithClosedWonOppInfo = new Map<ID ,Map<String,Double>>();
   global Map<Id ,Id> mapOppIdWithAccountId = new Map<Id ,Id>();
   
    //Start Method , we use QueryLocator here
   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<sObject> scope){
   
	   List<Account> accts = (List<Account>)scope;
	   
	   //iterating over accounts 
	   for (Account acc : accts) {
	   	
		   if (acc.Opportunities != null && !acc.Opportunities.isEmpty()
		         && acc.Contacts != null && !acc.Contacts.isEmpty() ){
		         	List<String> listemails = new list<string>();
		   			for(Contact contact : acc.Contacts){
		   				listemails.add(contact.email);
		   			}
		   			//mapAccountIdWithContactEmails.put(acc.Id , mapAccountIdWithContactEmails.ContainsKey(acc.Id)? (List<String>)mapAccountIdWithContactEmails.get(acc.Id).add(contact.Email) : new List<String>{contact.Email});		   				
		   			mapAccountIdWithContactEmails.put(acc.Id ,listemails);		   				
		   			for(Opportunity opp : acc.Opportunities){
		   				mapOppIdWithAccountId.put(opp.Id ,acc.Id );
		   			}		   		
	   		}
   		}
   		
   	 //finding out all opportunities which closed Yesterday 
   	 For(OpportunityHistory oh : [Select  OpportunityId, Amount , Opportunity.Name  from OpportunityHistory Where Stagename = 'Closed Won' and createdDate = YESTERDAY and OpportunityId In :mapOppIdWithAccountId.keySet() ORDER By CreatedDate ASC]){
   	 	
   	 	If(mapAccountIdWithClosedWonOppInfo.containsKey(mapOppIdWithAccountId.get(oh.OpportunityId))){
   	 		mapAccountIdWithClosedWonOppInfo.get(mapOppIdWithAccountId.get(oh.OpportunityId)).put(oh.Opportunity.Name , oh.amount);	
   	 	}else{
   	 		 
   	 		 mapAccountIdWithClosedWonOppInfo.put(mapOppIdWithAccountId.get(oh.OpportunityId) , new Map<String, Double>{ oh.Opportunity.Name => oh.amount});
   	 	}
   	 }	
    
     mapOppIdWithAccountId = null;
     
   }
   
   
	global void finish(Database.BatchableContext BC){
    
    ////sending mass email to associated contacts whose account's opportunites got closed won last day 
    Messaging.SingleEmailMessage[] listemail = new List<Messaging.SingleEmailMessage>();
    
    for(Id accid :mapAccountIdWithClosedWonOppInfo.keySet() ){
    	
	    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	   
		mail.setToAddresses((List<String>)mapAccountIdWithContactEmails.get(accid));
	 
		mail.setSenderDisplayName('Account\'s Closed Won Opportunity');
		mail.setSubject('Closed Won Opportunity Info');
		String body = 'Hi All \n Below Are the Closed Won Opportunties Information Of '+System.today().addDays(-1)+ '\n' + 'OpportunityName == Amount';
		Map<String ,Double> oppinfo = mapAccountIdWithClosedWonOppInfo.get(accid);
		System.debug('Map info'+oppinfo);
		Double total = 0;
		for(String opName : oppinfo.keySet()){
			body = body + '\n' + opName + '=='+oppinfo.get(opName);
			total += oppinfo.get(opName);
		}
		body = body +'\n'+'Total Sum Amount is '+total;
		mail.setPlainTextBody(body );
		listemail.add(mail);
    }
        If(!Test.isRunningTest()) {Messaging.sendEmail( listemail );}   
	
	   
   }

}