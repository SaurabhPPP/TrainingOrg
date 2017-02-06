public class ManageAccountController {
    public Account acc{get; set;}
    public list<Attachment> listAttachment{get; set;}
    public Blob attachmentdata {get; set;}
    public String pageController{get; set;}

    public ManageAccountController(ApexPages.StandardController controller) {
    pageController = 'detail';
    Id accountid = apexpages.currentpage().getparameters().get('id');
    List<Account> listAcc = [select Id , Name,Phone,Email_Address__c,Rating,Type,BillingCity from Account Where Id = :accountid ];
    if(listAcc.isEmpty()|| listAcc.size()<1){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'No Correct Account Id in parameter'));
    pageController = 'noAccount';
    }
    acc =  listAcc.isEmpty() ? new Account() :listAcc[0];
    listAttachment = [Select id, Name ,ParentId from Attachment where ParentId =:accountid];
    }
    
    @RemoteAction
    public static void deleteAttachment(String attachmentId){
    
     Delete [Select Id from Attachment where id = :attachmentId];
     
    }
    
    public PageReference openWizard(){
      PageReference openwizardpg= new pagereference('/apex/ManageAccountWizard?id='+acc.Id);
      //demoPage.setRedirect(true);
      return openwizardpg;
     //return null;
    }
    
    public PageReference nextpage(){
    
    pageController = 'upload';
    return null;
    
    }
    public PageReference saveAccountWithAttachment(){
     PageReference pgref = null;
     try{
     update acc;
     Attachment newAttachment = new Attachment();
     newAttachment.body = attachmentdata;
     newAttachment.ParentId = acc.Id;
     newAttachment.Name = acc.Name+Date.today();
     insert newAttachment;
     pgref = new pagereference('/apex/ManageAccountAttachment?id='+acc.Id);
     } catch(Exception e){
       
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
       
     }
      return pgref;
    }
}