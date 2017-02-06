@isTest()
public with sharing class Test_LeadTriggerHelper {



 @isTest public static void testCloneLead(){
 	
 	//creating Accounts
	List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
	//creating Contacts
	List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
	
	List<Lead> listLead = (List<Lead>)TestDataFactory.getListRecord('Lead',2);
											listLead[0].FirstName = 'testLead';
											listLead[0].LastName = 'one';
											listLead[0].Company = 'TestOne';
     										listLead[0].Status ='Open - Not Contacted';
											listLead[1].FirstName = 'testLead1';
											listLead[1].LastName = 'twp';
											listLead[1].Company = 'TestOne';
     										listLead[1].Status ='Open - Not Contacted';     
											
											
 	Test.startTest();
 	insert listLead;
 	
 	List<Lead> listLeads = [Select id from lead];
 	Test.stopTest();
 	System.assertEquals(4, listLeads.size());
}

}