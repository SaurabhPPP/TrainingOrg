/*
  	Test Class for AccountTriggerHelper
*/

@isTest
public with sharing class AccountTriggerHelperTest {
	
	
	static testMethod void testcloneAccount(){
		Account acc = new Account();
		acc.Name ='TestAccount';
		acc.OwnerId = UserInfo.getUserId();
		test.startTest();
		insert acc;
		test.stopTest();
	}
	    
}