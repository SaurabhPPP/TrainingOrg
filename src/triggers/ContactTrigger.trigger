trigger ContactTrigger on Contact (before insert,before update,after insert,after update) {
    
    
    //debug of Trigger Context Variable 
    if(trigger.isAfter){
        System.debug('After Trigger Context All Event ');
        System.debug('New Map '+ trigger.newMap);
        System.debug('New List' + trigger.New);
        System.debug('Old Map' + trigger.oldMap);
        System.debug('Old List'+ trigger.old);
        
    }
    if(trigger.isBefore){
        System.debug('Before Trigger Context All Event');
        System.debug('New Map '+ trigger.newMap);
        System.debug('New List' + trigger.New);
        System.debug('Old Map' + trigger.oldMap);
        System.debug('Old List'+ trigger.old);
    }
    
    if(trigger.isbefore){
        
        ContactTriggerHelper.associateAccountwithContact(trigger.new, trigger.oldmap);
        ContactTriggerHelper.checkForDuplicateContact(trigger.new);
    }
    
    if(trigger.isAfter){
        
    }

}