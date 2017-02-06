@isTest()
public class Test_AccountDetailPageController {
	
	 public static testMethod void testDetailPageController() {
       
        //creating Accounts
		List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
		//creating Contacts
		List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
		
	  // call the constructor
	    ApexPages.currentPage().getParameters().put('Id',listAcc[0].Id);     
        AccountDetailPageController controller = new AccountDetailPageController(new ApexPages.StandardController(listAcc[0]));
        controller.BuildQuery();
        
        Test.startTest();
        AccountDetailPageController.deleteContact(listCon[0].ID);
        Test.stopTest();
        
        List<Contact> lcontact = [Select id from Contact where Id =:listCon[0].id];
        
        // Verify that the success page displays
        System.assert(lcontact.isEmpty());
        
    }
    
}