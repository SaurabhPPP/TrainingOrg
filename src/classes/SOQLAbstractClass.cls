public abstract class SOQLAbstractClass {

    // Implement an abstract method
    //  Query on Account object/ records and show/print each account record using
    //  a. Traditional for loop
	//b. Advanced for loop
	//c. While loop
    public abstract void showAccountRecords();
    
    
    //this is not and abstract method 
    //Query on all Lead records & add ID of record to the set and print that set.
    public Set<Id> showLeadRecordId(){
        Set<Id> setLead = new Set<Id>();
        Map<Id, Lead> maplead = new map<Id, Lead>([Select Id from Lead]);
        if(!maplead.isEmpty())
            setLead = maplead.keySet();
        System.debug('set of lead ID '+setLead);
        return setLead;
    }
    //3. Create a Account Record with Name =”Eternus”. Create associated contacts.
	//Create a Custom field called Contact Count on Account . Query on Contact
	//where Account.Name =”Eternus” and count the associated contacts. Update
	//the custom field on Accounts with that count.
    public abstract void updateAccount(String AccountName);

    //4. Find all the Lead records having Status as Won & update the stage with New value
    public abstract void updateLeadStatus();
    
    //5. Write a SQOL Query to show Child Parent relationship and print the result.
    //public abstract List<Account> printChildParentAccount();
    public abstract List<Contact> queryOnChildParent();

    //6. Write a SOQL query to retrieve/print the Account records where Created Date = Today
    public abstract List<Account> queryOnAccount();
    
       
    //7. Demonstrate the usage of Database.query and Database.search methods
    public abstract void demonstrateDatabaseQueryAndSearch();
    
    //8. State the difference between Database methods for DML and basic DML statements
    public abstract void demonstrateBasicDMLAndDatabaseDML();
    
    
}