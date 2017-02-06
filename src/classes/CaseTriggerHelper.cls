/*
  Created Date :- 1/14/2017
  Case Trigger Helper 
*/
public with sharing class CaseTriggerHelper {
	
	/* 5.Method for Updating Cases that come in from the Web, Email or Chtt
		Use Case – we would like to use the email address of the incoming case to see if we can associate the
		correct person account to populate the Account and Contact Fields.
		When a new case is created and the Case.Origin field is set to “Chat” or “Email” or “Web” take the
		Case.SuppliedEmail field and look up to find a match in the following account fields –
		Account.PersonEmail, Account.Email_Address__c
	*/
	public static void updateCaseAccountField(List<Case> newCase){
	
	          //Map of Email  to List Of Case
		    Map<String, List<Case>> MapEmailToListCase = new Map<String,List<Case>>();
		    
		    //Set of Case Orgin value
		    Set<String> setCaseOrigin = new Set<String>{'Chat','Email','Web'};
		    
			for(Case c : newCase){
				if(setCaseOrigin.contains(c.Origin)){
					if(!MapEmailToListCase.containskey(c.SuppliedEmail))
						MapEmailToListCase.put(c.SuppliedEmail , new List<Case>{c});
					else
					    MapEmailToListCase.get(c.SuppliedEmail).add(c);	
				}	
			 }
	       
	       for(Account acc : [Select Id, Email_Address__c from Account where Email_Address__c IN :MapEmailToListCase.keySet()]){
	       		if(MapEmailToListCase.containsKey(acc.Email_Address__c)){
	       			for(Case c :MapEmailToListCase.get(acc.Email_Address__c)){
	       					c.AccountId = acc.Id;
	       			}
	       		}
	       }	
	       
	        for(Contact con :[Select Id ,Email from Contact where Email IN :MapEmailToListCase.keySet()]){
	       	   if(MapEmailToListCase.containsKey(con.Email)){
	       			for(Case c :MapEmailToListCase.get(con.Email)){
	       					c.ContactId = con.Id;
	       			}
	       		}
	       }	   
	 }
}