/*
   Created date :- 1/14/2017
*/
trigger EFT_Trigger on EFT_Transaction_Status__c (before update,before insert,after update,after insert) {

	if(trigger.isAfter){
		if(trigger.isInsert ){
			
			//calling method to create case on unVerified Transaction 
			EFT_Trigger_Helper.createCaseOnUnVerifiedTransaction(trigger.new);
		}
	}
}