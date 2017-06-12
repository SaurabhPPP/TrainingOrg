/*
 *  Test Class for ManageAccountController
 */
@isTest()
public class Test_ManageAccountController {

    public static testMethod void testManageAccountC() {
       
        
        ManageAccountController controllertemp = new ManageAccountController(new ApexPages.StandardController(new Account()));
        //creating Accounts
		List<Account> listAcc = TestDataFactory.createAccountsWithOpps(5);
		//creating Contacts
		List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
		
        User testUser = TestDataFactory.createUser();
	  // call the constructor
	    ApexPages.currentPage().getParameters().put('id',listAcc[0].id);  
        System.runAs(testUser){
        ManageAccountController controller = new ManageAccountController(new ApexPages.StandardController(listAcc[0]));
        
         controller.attachmentdata = Blob.valueOf('test');
         controller.saveAccountWithAttachment();
         controller.openWizard();
         List<Attachment> att = [Select id from Attachment];
         //assertion for Attachment created or not 
         System.assertEquals(att.size() ,1);
        
         Test.startTest();
          ManageAccountController.deleteAttachment(att[0].id);
         Test.stopTest();
        
        }  
           
        
    }
}