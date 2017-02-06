public class OpportunityTriggerHelper {
    
//method to update approval Status on Opportunity 
    public static void updateApprovalStatus(List<Opportunity> newList ,Map<Id,Opportunity> oldmap){
        for(Opportunity opp : newList){
            if(oldmap == null || !oldmap.containsKey(opp.id) || oldmap.get(opp.id).Amount != opp.Amount){
                opp.Approval_Status__c = opp.Amount!=null?opp.Amount<=5000?'Not Applicable':opp.Approval_Status__c:null;
            }      
         }         
    }    


//method to initiate approval process
	public static void intiateApprovaltoManager(List<Opportunity> newList ,Map<Id,Opportunity> oldmap){
        for(Opportunity opp :newList){
            if(opp.Approval_Status__c != 'Approved'
               && opp.Amount > 5000
               &&(oldmap == null || !oldmap.containsKey(opp.id) || oldmap.get(opp.id).Amount != opp.Amount)){
                
                   // Create an approval request for the Opportunity
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitting request for approval Opportunity having Amount more than 5000');
                    req.setObjectId(opp.id);
                     // Submit the approval request for the Opportunity
                    Approval.ProcessResult result = Approval.process(req);
            }
        }
        
    }
}