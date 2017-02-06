/*
   Account Trigger 
   Created Date :- 1/14/2016
*/
trigger Account_Trigger on Account (after insert, after update, before insert, 
before update) {
	
	//skipping trigger as per value 
	if(AccountTriggerHelper.SKIP_ACCOUNT_TRIGGER)
	return;
	
	if(trigger.isInsert && trigger.isAfter){
		AccountTriggerHelper.cloneAccount(Trigger.New);
		
		//Method call to create new Task After Account Created Successfully
		AccountTriggerHelper.createTaskOnAccountInsert(Trigger.New);
	}

}