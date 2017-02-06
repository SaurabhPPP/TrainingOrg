/*
  Created Date :- 1/14/2017
*/
trigger CaseTrigger on Case (after insert, after update, before insert, 
before update) {
    
    if(trigger.isInsert && trigger.isBefore){
        
        CaseTriggerHelper.updateCaseAccountField(trigger.New);
    }

}