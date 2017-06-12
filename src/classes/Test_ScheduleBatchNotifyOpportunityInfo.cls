/*
 test class for BatchNotifyClosedOnOpportunity and  ScheduleBatchNotifyOpportunityInfo class
*/
@isTest()
public with sharing class Test_ScheduleBatchNotifyOpportunityInfo {


	@isTest public static void testBatchNotifyClosedOnOpportunity(){
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            //creating Accounts
            List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
            //creating Contacts
            List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
            //creating opportunity 
            List<Opportunity> listOpp = TestDataFactory.createOpportunityList(listAcc ,2);
            
            //updating Opportunity StageName
            listOpp[0].StageName = 'Closed Won';
            listOpp[0].Amount = 1000;
            listOpp[1].StageName = 'Closed Won';
            listOpp[1].Amount = 3200;
            
            Test.StartTest();
            update listOpp;
            
			ScheduleBatchNotifyOpportunityInfo notifyContacts = new ScheduleBatchNotifyOpportunityInfo();      
			String sch = '0 0 23 * * ?';
			system.schedule('Test check', sch, notifyContacts);
			//creating instance of batch
			BatchNotifyClosedOnOpportunity bg = new  BatchNotifyClosedOnOpportunity();
			database.executeBatch(bg,200);
			Test.stopTest();
        }
    }

}