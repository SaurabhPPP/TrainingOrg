trigger Case_Trigger on Case (before insert,before update,after insert,after update) {
    
    // skipping trigger as per value
	if(Case_TriggerHelper.SKIP_CASE_Trigger)
    return;
    
    if(trigger.isAfter && trigger.isInsert)
        Case_TriggerHelper.cloneCase(trigger.new);
}