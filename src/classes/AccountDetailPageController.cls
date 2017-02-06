public with sharing class AccountDetailPageController {
        
        public List<Contact> listcontacts{get; set;}
        private ApexPages.StandardSetController ssc;
        private String accountId;
        public list<String> AlphaList {get; set;}
        public String AlphaFilter {get; set;}
        public String SearchName {get; set;}
        public String SearchBillingAddress {get; set;} 
        private String SaveSearchName;
        private String SaveSearchBillingAddress;
        private String QueryContact;
        public boolean showdetail{get; set;}
        public boolean showrelated{get;set;}
        
        public AccountDetailPageController(ApexPages.StandardController controller) {
              //List<Account> listAccount = [Select Id ,Name,Phone,Email_Address__c from Account ];
            accountId = ApexPages.currentPage().getParameters().get('Id');
            showdetail = ApexPages.currentPage().getParameters().get('showdetail') != null && ApexPages.currentPage().getParameters().get('showdetail') != ''?false: true;
            showrelated= ApexPages.currentPage().getParameters().get('showrelated') != null && ApexPages.currentPage().getParameters().get('showrelated') != ''?false: true;
            
            listcontacts = new List<contact>();
            
            AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'};
            
            if(accountId != null || accountId != ''){
                    listcontacts = [Select Id, Name,Phone,Title,Email from Contact where AccountId = :accountId];
             }
        }
        
       public void BuildQuery() {
         String QueryWhere = '';
         AlphaFilter = ApexPages.currentPage().getParameters().get('AlphaFilter');
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
        QueryContact = 'Select Id, Name,Phone,Title,Email from Contact where AccountId = :accountId'; 
        
        if (AlphaFilter != 'All') {
            QueryContact = BuildWhere(QueryContact , '' + String.escapeSingleQuotes(SortField) + ' LIKE \'' + String.escapeSingleQuotes(AlphaFilter) + '%\'' );
        }
        QueryContact  += ' ORDER BY ' + String.escapeSingleQuotes(SortField) + ' ' + String.escapeSingleQuotes(SortDirection) + ' LIMIT 10000';
        listcontacts = Database.query(QueryContact);
        system.debug('QueryContact :' + QueryContact );
    }
    
    /***
    * BuildWhere - build soql string for where criteria 
    ***/
    public String BuildWhere(String QW, String Cond) {
        if (QW == '') {
            return ' AND' + Cond;
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
    public static String deleteContact(String contactId){
       String result = '';
       try{
            delete [Select id from contact where id = :contactId];
            result = 'the Contact has been deleted';
         }catch(Exception e){
            result = 'Error :'+e.getMessage();
         }
        return result;
    }   
    
    
}