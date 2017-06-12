public class AccountListviewController {

    public String Search{get; set;}
    public String accountId{get; set;}
    private ApexPages.StandardSetController ssc;
    public List<Account> myaccounts{get; set;}
    public String filterId{get; set;}
    public AccountListviewController(ApexPages.StandardSetController controller) {
        //List<Account> listAccount = [Select Id ,Name,Phone,Email_Address__c from Account ];
        if(ssc == null)
        ssc = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Name,Phone,Email_Address__c  FROM Account LIMIT 10000]));
        
        ssc.setFilterId(filterId);
        myaccounts = (List<Account>)ssc.getRecords();
        
    }
    
    public void searchList(){
       list<Account> listAccount = new List<Account>(myaccounts);
       list<Account> newAccount = new List<Account>();
       if(Search ==''||Search == null ||Search.length()<3){
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please input at least 3 characters to perform Search'));
           newAccount  = listAccount;
       }
       else{   
       For(Account acc : listAccount){
       if(acc.Name != null && acc.Name.containsIgnoreCase(Search))
        newAccount.add(acc); 
       }
       }
       myaccounts = newAccount;
    }
    
    public void filterList(){
        ssc.setFilterId(filterId);
        myaccounts = (List<Account>)ssc.getRecords();
    }
    
    public pageReference goToAccount(){
        PageReference pg = new PageReference('/apex/AccountDetailPage');  
        String accid = ApexPages.currentPage().getParameters().get('accountId');
        System.debug('accid'+accid);
        if(accid != null || accid !='')
         pg = new PageReference('/apex/AccountDetailPage?id='+accid);     
  //test
  
        return pg;   
    }
}