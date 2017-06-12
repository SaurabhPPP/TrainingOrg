trigger Case_Trigger on Case (before insert,before update,after insert,after update,after delete ,after undelete) {
    
    // skipping trigger as per value
	if(Case_TriggerHelper.SKIP_CASE_Trigger)
    return;
    
    if(trigger.isAfter && trigger.isInsert)
        Case_TriggerHelper.cloneCase(trigger.new);
        
    if(trigger.isAfter){
	
	if(trigger.isInsert || trigger.isUpdate || trigger.isDelete || trigger.isUndelete){
		Case_TriggerHelper.RollupCaseOnAccount(trigger.new , trigger.oldmap);
	}
    
}
        
}