/*
  test class for EFT_Trigger_Helper
*/
@isTest()
public class Test_EFT_Trigger_Helper {

 @isTest public static void testcreateCaseOnUnVerifiedTransaction(){
 	
 	//creating Accounts
	List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
	//creating Contacts
	List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
	
	List<SalesHeader__c> salesHeaderlist = (List<SalesHeader__c>)TestDataFactory.getListRecord('SalesHeader__c',2);
											salesHeaderlist[0].Bill_to_Company__c = listAcc[0].id;
											salesHeaderlist[0].Bill_to_Customer__c = listcon[0].id;
											salesHeaderlist[0].Name = 'TestOne';
     										salesHeaderlist[0].Status__c ='Open';
											salesHeaderlist[1].Bill_to_Company__c = listAcc[1].id;
											salesHeaderlist[1].Bill_to_Customer__c = listcon[1].id;
											salesHeaderlist[1].Name = 'TestTwo';
     										salesHeaderlist[1].Status__c ='Open';
     
											
											
 	Test.startTest();
 	insert salesHeaderlist;
 	
 	System.assert(salesHeaderlist[0].id != null);
 	
 	List<EFT_Transaction_Status__c> listEFT = (List<EFT_Transaction_Status__c>)TestDataFactory.getListRecord('EFT_Transaction_Status__c',2);
 									listEFT[0].Name ='EFT1';
 									listEFT[0].SalesHeader__c =salesHeaderlist[0].id;
 									listEFT[0].Method_Name__c = 'Credit Card Address Verify';
 									listEFT[0].Transaction_Status__c= 'Declined';
									listEFT[0].Transaction_Date__c = Date.Today();
									listEFT[1].Name ='EFT2';
 									listEFT[1].SalesHeader__c =salesHeaderlist[1].id;
 									listEFT[1].Method_Name__c = 'Credit Card Address Verify';
 									listEFT[1].Transaction_Status__c=  'Declined';
									listEFT[1].Transaction_Date__c = Date.Today();
	insert listEFT;
	
	List<Case> listCase = [select id from Case];
	System.assertEquals(4, listCase.size());								
 }
}