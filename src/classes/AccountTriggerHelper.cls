/*
  Trigger Helper Class for Account Trigger 
  Created date  1/14/2016
*/
public with sharing class AccountTriggerHelper {
	
	public static Boolean  SKIP_ACCOUNT_TRIGGER = false;
    //Method for clone the account record
	public static void cloneAccount(List<Account> newAccount){
		
		List<Account> listCloneAccount = new List<Account>();
		for(Account acc : newAccount){
			Account acc1 = acc.clone();
			listCloneAccount.add(acc1);
		}
		
		if(!listCloneAccount.isEmpty()){
			SKIP_ACCOUNT_TRIGGER = true;
			insert listCloneAccount;
			SKIP_ACCOUNT_TRIGGER = false;
		}
		
	}
	
	//4. Method for Task Creation Trigger
	//Create a task upon successful creation of a new Account.
	//The task subject should be set as –Meeting with <specific Account’s name>.
	//Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
	public static void createTaskOnAccountInsert(List<Account> newAccount){
			//list of task to be inserted
			List<Task> listTaskOnAccountToBeInserted = new List<Task>();
			For(Account acc :newAccount){
				Task t = new Task();
				t.OwnerId = acc.OwnerId;
				t.Subject = 'Meeting with '+acc.Name;
				t.Status = 'Open';
				t.Priority = 'Normal';
				t.WhatId = acc.Id;
				listTaskOnAccountToBeInserted.add(t);
			}
			
			If(!listTaskOnAccountToBeInserted.isEmpty())
			insert listTaskOnAccountToBeInserted;
	}
}