/*
   Created date :- 1/14/2017
*/
public with sharing class EFT_Trigger_Helper {
	
	
	//4. On Insert of a EFT_Transaction_Status__c, if
	//EFT_Transaction_Status__c.Method_Name__c = “Credit Card Address Verify”
	//EFT_Transaction_Status__c.Transaction_Status__c= “Declined”
	//SalesHeader__c.Status__c = “Open” 
	
	public static void createCaseOnUnVerifiedTransaction(List<EFT_Transaction_Status__c> newEFT){
		
		//set of EFT ID which not verified 
		Set<Id> setEFTID = new Set<Id>();
		
		List<Case> listCaseToBeInserted = new List<Case>();
		
	for(EFT_Transaction_Status__c EFT : newEFT){
			
			If(EFT.Method_Name__c == 'Credit Card Address Verify'
 				&& EFT.Transaction_Status__c== 'Declined'
				&& EFT.SalesHeaderStatus__c == 'Open'){
					setEFTID.add(EFT.Id);
			 }
		}
		
	 If(!setEFTID.isEmpty())	{
	 	
	 	for(EFT_Transaction_Status__c EFT : [Select Id ,OwnerId,Transaction_Status__c,Transaction_Date__c,SalesHeader__r.Bill_To_Company__c,
	 	    SalesHeader__r.Bill_To_Company__r.Name ,SalesHeader__r.Bill_To_Customer__c,SalesHeader__r.Name, SalesHeader__c 
	 	    From EFT_Transaction_Status__c 
	 	    Where ID  IN :setEFTID ]){
	 	    	
	 	    	Case c = new Case();
	 	    	c.AccountId = EFT.SalesHeader__r.Bill_To_Company__c;
                c.ContactId = EFT.SalesHeader__r.Bill_To_Customer__c;
                c.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Assignment').getRecordTypeId();
                c.Origin ='Internal';
                c.OwnerId = EFT.OwnerId;
                c.Reason = 'Address Did Not Verify';
                c.Priority ='High';
                c.Status = 'New';
                c.Type ='Address Did Not Verify';
                c.Subject =  EFT.SalesHeader__r.Bill_To_Company__r.Name+' '+c.Type;
                c.Open_Sales_Order__c = EFT.SalesHeader__c;
                c.Transaction_Status__c = EFT.Transaction_Status__c;
                c.Sales_Order_Number__c = EFT.SalesHeader__r.Name;
                c.Order_Date__c = EFT.Transaction_Date__c;
                //adding to list
	 	    	listCaseToBeInserted.add(c);
	 	    }
         }
	 If(!listCaseToBeInserted.isEmpty())	
         insert listCaseToBeInserted;
	}

}