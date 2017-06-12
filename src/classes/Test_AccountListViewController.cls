@isTest()
public class Test_AccountListViewController {
    
    
    public static testMethod void testListPageController2() {
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            //creating Accounts
            List<Account> listAcc = TestDataFactory.createAccountsWithOpps(5);
            //creating Contacts
            List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
            
            // call the constructor
            ApexPages.currentPage().getParameters().put('accountId',listAcc[0].id);    
            AccountListviewController controller = new AccountListviewController(new ApexPages.StandardSetController(listAcc));
            
            
            controller.Search ='Test';
            controller.searchList();
            Pagereference expected = new PageReference('/apex/AccountDetailPage?id='+listAcc[0].id);  
            Test.startTest();
            PageReference prefaccount = controller.goToAccount();
            Test.stopTest();
            
            System.assertEquals(controller.myaccounts.size(), 10);  
            //System.assertEquals(expected, Prefaccount);  
            
        }
        
        
        
    }
    
}