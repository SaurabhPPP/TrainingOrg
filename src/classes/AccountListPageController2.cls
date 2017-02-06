public class AccountListPageController2 {

        public List<Account> listAccount{get; set;}
        private List<Account> lastlistAccount;
        public String Search{get; set;}
        private ApexPages.StandardSetController ssc;
        private String accountId;
        public list<String> AlphaList {get; set;}
        public String AlphaFilter {get; set;}
        public String SearchName {get; set;}
        public String SearchBillingAddress {get; set;} 
        private String SaveSearchName;
        private String SaveSearchBillingAddress;
        private String QueryAccount;
        
        public AccountListPageController2(ApexPages.StandardController controller) {
            
            listAccount = [Select Id ,Name,Phone,Email_Address__c ,website from Account ];
            lastlistAccount = listAccount ;
            accountId = ApexPages.currentPage().getParameters().get('Id');
            
            AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
            
        }
        
        public void searchList(){
               lastlistAccount= (lastlistAccount== null || lastlistAccount.isEmpty())? new List<Account>(listAccount):lastlistAccount;
               list<Account> newAccount = new List<Account>();
               if(Search ==''||Search == null ||Search.length()<3){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please input at least 3 characters to perform Search'));
               }
               else{   
                       For(Account acc : lastlistAccount){
                               if(acc.Name != null && acc.Name.containsIgnoreCase(Search))
                                newAccount.add(acc); 
                       }
                       listAccount = newAccount;
               }
               
        }
    
       public void BuildQuery() {
         String QueryWhere = '';
         AlphaFilter = ApexPages.currentPage().getParameters().get('AlphaFilter');
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
        QueryAccount = 'Select Id, Name,Phone,WebSite,Email_Address__c from Account' ; 
        QueryWhere = '';
        if (AlphaFilter != 'All') {
            QueryWhere  = BuildWhere(QueryWhere  , '' + String.escapeSingleQuotes(SortField) + ' LIKE \'' + String.escapeSingleQuotes(AlphaFilter) + '%\'' );
        }
        QueryAccount = QueryWhere == ''?QueryAccount : QueryAccount + QueryWhere;
        QueryAccount += ' ORDER BY ' + String.escapeSingleQuotes(SortField) + ' ' + String.escapeSingleQuotes(SortDirection) + ' LIMIT 10000';
        listAccount = Database.query(QueryAccount);
        lastlistAccount  = listAccount ;
        system.debug('QueryAccount:' + QueryAccount);
    }
    
    /***
    * BuildWhere - build soql string for where criteria 
    ***/
    public String BuildWhere(String QW, String Cond) {
        if (QW == '') {
            return ' WHERE ' + Cond;
        } else {
            return QW + ' AND ' + Cond;
        }
    }
    
    /***
    * SortDirection - return sort direction. Default ascending(asc)
    ***/
    public String SortDirection {
        get { if (SortDirection == null) {  SortDirection = 'asc'; } return SortDirection;  }
        set;
    }
    
    /***
    * SortField - return sort by field. Default to Name
    ***/
    public String SortField {
        get { if (SortField == null) {SortField = 'Name'; } return SortField;  }
        set; 
    }
    
    
    //Remoting method 
    @RemoteAction
    public static String deleteAccount(String accId){
       String result = '';
       try{
            delete [Select id from account where id = :accId];
            result = 'the Account has been deleted';
         }catch(Exception e){
            result = 'Error :'+e.getMessage();
         }
        return result;
    } 
    
    public pageReference goToAccount(){
        PageReference pg = new PageReference('/apex/AccountDetailPage');  
        String accid = ApexPages.currentPage().getParameters().get('accountId');
        System.debug('accid'+accid);
        if(accid != null || accid !='')
         pg = new PageReference('/apex/AccountDetailPage?id='+accid+'&showrelated=false');       
        return pg;   
    }  
    
    public pageReference manageContact(){
        PageReference pg = new PageReference('/apex/AccountDetailPage');  
        String accid = ApexPages.currentPage().getParameters().get('accountId');
        System.debug('accid'+accid);
        if(accid != null || accid !='')
         pg = new PageReference('/apex/AccountDetailPage?id='+accid+'&showdetail=false');       
        return pg;   
    }  
}