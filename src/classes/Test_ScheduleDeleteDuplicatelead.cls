/*
     test class for BatchDeleteDuplicateLead and  ScheduleBatchDeleteDubLead class
    */
    @isTest()
public with sharing class Test_ScheduleDeleteDuplicatelead {
	
	@isTest public static void testBatchDeleteDuplicateLead(){
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            //creating Accounts
            List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
            //creating Contacts
            List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
            
            List<Lead> listLead = (List<Lead>)TestDataFactory.getListRecord('Lead',2);
            listLead[0].FirstName = 'testLead';
            listLead[0].LastName = 'one';
            listLead[0].Company = 'TestOne';
            listLead[0].Status ='Open - Not Contacted';
            listLead[0].Email = 'test@testing.com';
            listLead[1].FirstName = 'testLead1';
            listLead[1].LastName = 'twp';
            listLead[1].Company = 'TestOne';
            listLead[1].Status ='Open - Not Contacted';     
            listLead[1].Email = 'test@testing.com';
            
            Test.startTest();
            LeadTriggerHelper.SKIP_LEAD_TRIGGER = true;
            insert listLead;
            
            LeadTriggerHelper.SKIP_LEAD_TRIGGER = false;
             
            listLead = [Select id from Lead where Email ='test@testing.com'];
            System.assertEquals(2, listLead.size());
            
			ScheduleBatchDeleteDubLead duplicateleadDelete = new ScheduleBatchDeleteDubLead();      
			String sch = '0 0 23 * * ?';
			system.schedule('Test check', sch, duplicateleadDelete);
			//creating instance of batch
			BatchDeleteDuplicateLead bg = new  BatchDeleteDuplicateLead();
			database.executeBatch(bg,200);
			Test.stopTest();
		    listLead = [Select id from Lead where Email ='test@testing.com'];
            System.assertEquals(1, listLead.size());
        }
    }

}