trigger Trigger_Opportunity on Opportunity (before Update ,before Insert,after Update ,after Insert) {

    if(Trigger.isAfter){
     OpportunityTriggerHelper.intiateApprovaltoManager(Trigger.new , Trigger.oldMap);
    }
    
    if(Trigger.isBefore){
      OpportunityTriggerHelper.updateApprovalStatus(Trigger.new , Trigger.oldMap);
    }


}