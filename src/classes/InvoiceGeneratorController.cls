public class InvoiceGeneratorController {
public Invoice__c invoice{get; set;}
    private ApexPages.StandardController sc;

    public InvoiceGeneratorController(ApexPages.StandardController controller) {
      sc = controller;
      invoice = (Invoice__c)controller.getRecord();
      
      String invoiceId =ApexPages.currentPage().getParameters().get('Id');
      if(invoiceId != null && invoiceId != ''){
      invoice = [Select Id ,Name,Bill_To_Customer__c,Company__c,Discount__c,Labor_Charge_Hour__c,No_of_Hours_worked__c,Service_Fee__c,Tax_Percentage__c,Company__r.BillingCity,
   Company__r.BillingStreet,Company__r.BillingState,Company__r.BillingPostalCode,Company__r.BillingCountry From Invoice__c where Id =:invoiceId];
      }
    }
    
    public PageReference saveIt(){
      PageReference pgref = null;
      invoice = (Invoice__c)sc.getRecord();
     if(invoice != null){
       
       try{
           insert invoice ;
           pgref = new PageReference('/apex/InvoicePdf?Id='+invoice.id);
           pgref.setRedirect(true);
       
       }catch(Exception e){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
       }
      
     }
     return pgref;
    }

}