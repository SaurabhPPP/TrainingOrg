/*
  Created Date : 1/14/2017
*/
trigger LeadTrigger on Lead (after insert, after update) {
	
	if(LeadTriggerHelper.SKIP_LEAD_TRIGGER)
	return;
	//Calling a Method On LeadTriggerHelper which will create the clone Lead record.
	if(trigger.isInsert && trigger.isAfter){
		LeadTriggerHelper.cloneLead(trigger.New);
	
	}
}