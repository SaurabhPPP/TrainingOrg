/*
Test Class for Case_TriggerHelper  and CaseTriggerHelper
*/
@isTest()
public with sharing class Test_CaseTriggerHelper {
    
    
    @isTest() static void testCase_Trigger(){
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            //creating Accounts
            List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
            //creating Contacts
            List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
            List<Case> listCase = (List<Case>)TestDataFactory.getListRecord('Case',2);
            listCase[0].ContactId = listCon[0].id;
            listCase[0].AccountId = listAcc[0].Id;
            listCase[0].Status = 'Working';
            listCase[0].Origin = 'Phone';
            listCase[1].ContactId = listCon[1].id;
            listCase[1].AccountId = listAcc[1].Id;
            listCase[1].Status = 'Working';
            listCase[1].Origin = 'Phone';
            Test.startTest();
            insert listCase;
            Test.stopTest();
            List<Case> lcase = [Select id from Case];
            System.assertEquals(lcase.size() ,4);       
            
        }
    }
    
    
    @isTest() static void testUpdateCaseAccountField(){
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser();
        System.runAs(testUser){
            //creating Accounts
            List<Account> listAcc = TestDataFactory.createAccountsWithOpps(2);
            //creating Contacts
            List<Contact> listCon = TestDataFactory.createContactList(listAcc ,2);
            //updating Account
            listAcc[0].Email_Address__c = 'test@123.com';
            update listAcc;
            
            List<Case> listCase = (List<Case>)TestDataFactory.getListRecord('Case',2);
            listCase[0].ContactId = listCon[0].id;
            listCase[0].SuppliedEmail = listAcc[0].Email_Address__c;
            listCase[0].Origin = 'Email';
            listCase[0].Status = 'Working';
            listCase[1].SuppliedEmail = listCon[1].Email;
            listCase[1].AccountId = listAcc[1].Id;
            listCase[1].Status = 'Working';
            listCase[1].Origin = 'Web';
            Test.startTest();
            insert listCase;
            Test.stopTest();
            List<Case> lcase = [Select id,ContactId ,AccountId from Case where Id IN :listCase];
            System.assertEquals(lcase[0].AccountId ,listAcc[0].Id);
            System.assertEquals(lcase[1].ContactId ,listCon[1].Id);
        }
        
    }
    
}