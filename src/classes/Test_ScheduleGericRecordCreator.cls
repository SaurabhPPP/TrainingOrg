/*
 test class for BatchCreateGenericObjcet and  ScheduleGericRecordCretor class
*/
@isTest()
public with sharing class Test_ScheduleGericRecordCreator {
	
	@isTest public static void testBatchCreateGenericObject(){
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            //creating  Generic sobjects records 
            List<GenericSobjectCreator__c> listGeneicTestData = ( List<GenericSobjectCreator__c>)TestDataFactory.getListRecord('GenericSobjectCreator__c',2);
            listGeneicTestData[0].Name = 'test1';
            listGeneicTestData[0].FieldCreatorJson__c = '{ "Name" : "ParthTesting" }';
            listGeneicTestData[0].IsCreated__c = false;
            listGeneicTestData[0].Object_Name__c ='Account';
            listGeneicTestData[1].Name ='Test2';
            listGeneicTestData[1].FieldCreatorJson__c = '{"FirstName" : "testone" ,"LastName" : "kumar", "Company" : "Shriram" , "Status" : "Open"}';
            listGeneicTestData[1].Object_Name__c = 'Lead';
            
            Test.StartTest();
                Insert listGeneicTestData;
				ScheduleGericRecordCretor genricSchdulare = new ScheduleGericRecordCretor();      
				String sch = '0 0 23 * * ?';
				system.schedule('Test check', sch, genricSchdulare);
				//creating instance of batch
				BatchCreateGenericObjcet bg = new  BatchCreateGenericObjcet();
				database.executeBatch(bg,200);
			Test.stopTest();
			List<Account> listacc = [Select id from Account];
			List<Lead> listLeads = [Select id from Lead];
            System.assertEquals(2, listLeads.size());
            System.assertEquals(1, listacc.size());
        }
    }

}