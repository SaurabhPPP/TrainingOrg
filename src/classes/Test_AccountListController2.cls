@isTest()
public class Test_AccountListController2 {
    
    
    public static testMethod void testListPageController2() {
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            //creating Accounts
            List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
            //creating Contacts
            List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
            
            // call the constructor
            ApexPages.currentPage().getParameters().put('accountId',listAcc[0].id);    
            AccountListPageController2 controller = new AccountListPageController2(new ApexPages.StandardController(listAcc[0]));
            
            controller.BuildQuery();
            controller.Search ='Test';
            controller.searchList();
            ApexPages.currentPage().getParameters().put('AlphaFilter','A');   
            controller.BuildQuery();
            
            PageReference prefaccount = controller.goToAccount();
            PageReference prefcontact = controller.manageContact();
            
            Test.startTest();
            AccountListPageController2.deleteAccount(listAcc[0].ID);
            Test.stopTest();
            
            List<Account> lacc = [Select id from Account where Id =:listAcc[0].id];
            
            // Verify that the success page displays
            System.assert(lacc.isEmpty());
        }
    }
    
}