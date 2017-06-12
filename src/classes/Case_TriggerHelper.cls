public with sharing class Case_TriggerHelper {

    public static boolean SKIP_CASE_Trigger = false;
    
    // method to clone the case records
     public static void cloneCase(List<Case> newCase) {
        list<Case> lstCloneCase = new list<Case>();
        for(Case loopcase : newCase) {
            Case case1 = loopcase.clone();
            lstCloneCase.add(case1);
        }
        
        if(!lstCloneCase.isEmpty()) {
            SKIP_CASE_Trigger = true;
            insert lstCloneCase;
            SKIP_CASE_Trigger = false;   
        }
     }
     
     //method to roll up Case on Account 
     public static void RollupCaseOnAccount(List<Case> newCase ,Map<Id ,Case> oldMap){
     	List<Account> listAccountTobeUpdated = new List<Account>();
     	Set<Id> setAccountId = new Set<Id>();
     	for(Case c : newCase){
     		if(c.AccountId != null || (oldMap != Null && oldMap.containsKey(c.id) && OldMap.get(c.id).Accountid != c.AccountId && c.AccountId == null))
     		 setAccountId.add(c.AccountId != null?c.AccountId :OldMap.get(c.id).Accountid);
     	}
     	 
     	//Aggregagte query on Case 
        for(AggregateResult accountResult : [Select Count(Id) cnt, AccountId from Case
                                                where  AccountId In :setAccountId Group By AccountId]) {
       
            // Add Account record for update
            listAccountTobeUpdated.add(
                new Account(
                    Id = String.valueOf(accountResult.get('AccountId')),
                    Total_Case__c = Integer.valueOf(accountResult.get('cnt'))
                )
            ); 
         }
         
        if(!listAccountTobeUpdated.isEmpty()){
        	Database.update(listAccountTobeUpdated,false);
        } 
      }
     
}