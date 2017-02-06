/*
 *  Show the demo of Inheritance //public String calculator
 *  Override the abstract method 
 *  State the basic difference between an interface and an abstract class (common for
 *  every group)
 * 
 */ 
public class OppsConceptClass extends SOQLAbstractClass implements CalculatorInterface {
    
     
    //override from  CalculatorInterface for more detail go to calculatorInterface
     public String calculator(String Operation ,Integer inp1 , Integer inp2){
        
        String result = '';
        if(Operation==null || Operation == '')
            result = 'No Operation Selected';
        else if(Operation.equalsIgnoreCase('SUM'))
            result = Operation+' of '+inp1+' and '+inp2+' = '+ String.valueOf(inp1+inp2);
        else if(Operation.equalsIgnoreCase('SUB'))
            result = Operation+' of '+inp1+' and '+inp2+' = '+ String.valueOf(inp1-inp2);
        else if(Operation.equalsIgnoreCase('MUL'))
            result = Operation+' of '+inp1+' and '+inp2+' = '+ String.valueOf(inp1*inp2);
        else if(Operation.equalsIgnoreCase('DIV'))
            result = Operation+' of '+inp1+' and '+inp2+' = '+ String.valueOf(inp1/inp2);
        System.debug(result);
        return result;
        
    }
    
     // Implement an abstract method
    //  Query on Account object/ records and show/print each account record using
    //  a. Traditional for loop
	//b. Advanced for loop
	//c. While loop
    public override  void showAccountRecords(){
        List<Account> listAccount = [Select Id ,Name from Account];
        if(listAccount.isEmpty())
            return ;
        //traditional for loop
        for(Integer i =0; i<listAccount.size(); i++){
            
            //print account
            System.debug('Account :- '+listAccount[i]);
        }
        
        //Advanced for loop
        for(Account acc :listAccount){
            //print account
            System.debug('Account :- '+acc); 
        }
        
        //While Loop
        While(!listAccount.isEmpty()){
            //print account
            System.debug('Account :- '+listAccount[0]); 
            listAccount.remove(0);
        }
    }
    
    
    
    //3. Create a Account Record with Name =”Eternus”. Create associated contacts.
	//Create a Custom field called Contact Count on Account . Query on Contact
	//where Account.Name =”Eternus” and count the associated contacts. Update
	//the custom field on Accounts with that count.
    public override  void updateAccount(String AccountName){
        // Query on contacts
        List<Contact> listContact = [Select id ,AccountId from Contact where Account.Name = :AccountName];
        if(listContact.isEmpty())
            return;
        Account acc = new Account(Id =listContact[0].AccountId , Count__c = listContact.size());
        update acc;
    }

    //4. Find all the Lead records having Status as Won & update the stage with New value
    public override  void updateLeadStatus(){
        List<Lead> listLeadTobeUpdated = new List<Lead>();
       
        for(Lead l : [Select id from Lead where Status = 'Won']){
             l.Status = 'New';
             listLeadTobeUpdated.add(l);
        }
        Database.update(listLeadTobeUpdated, false);
    }
    
    //5. Write a SQOL Query to show Child Parent relationship and print the result.
    public override List<Contact> queryOnChildParent(){
      //soql query on Child(Contact) fetching Parent Data as well
      List<Contact> listContact = [Select id ,Name ,AccountID,Account.Id , Account.Name , Account.Owner.Name From Contact];
      if(listContact.isEmpty())
          return null;
        System.debug('Parent Child Relation Ship Result ' +listContact);
        return listContact;
    }
    
    //6. Write a SOQL query to retrieve/print the Account records where Created Date = Today
    public override  List<Account> queryOnAccount(){
        
        List<Account> listTodayCreatedAcc =  [Select Id ,Name From Account Where CreatedDate =:System.today()];
        System.debug('Today Created Acccounts ' + listTodayCreatedAcc);
        return listTodayCreatedAcc;
    }
    
    //7. Demonstrate the usage of Database.query and Database.search methods
    public override  void demonstrateDatabaseQueryAndSearch(){
        
        String Name = 'Eternus';
        //Database.query is used for dynamic SOQL 
        String Query = 'Select Id , Name From Account where Name != :Name';
        List<Account> listAccount = Database.query(Query);
        System.debug('Database Query Result :-'+listAccount);
        
        //System.search is used to dynamic global find any string value , Note:- Database.search is no any functionality in SF 
        String SOSL_search_string  = 'FIND '+Name+' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead';
        List<List<Sobject>> searchResults = Search.query(SOSL_search_string);
        System.debug('System searchResults = '+searchResults);
        
    }
    
    //8. State the difference between Database methods for DML and basic DML statements
    public override void demonstrateBasicDMLAndDatabaseDML(){
        list<Account> listAccountToUpdate = new List<Account>();
            for(Account acc : [Select Id ,Count__c from Account]){
                if(acc.Count__c != null || acc.Count__c ==0)
                    acc.count__c = 0;
                listAccountToUpdate.add(acc);
            }
        //basic DML, if one fail all other records will fail
        try{
        update listAccountToUpdate;
        }catch(DMLException de){
            system.debug(de.getMessage());
        }
        
        //Database.DML  , if one fail , except those records which fails other will updated correctly 
        List<Database.SaveResult> saveresults =  Database.update(listAccountToUpdate, false);
        
        //by using Database DML , we can find out those record which having the errors 
        for(Database.SaveResult saveR : saveresults){
            if(!saveR.isSuccess()){
                for(Database.Error err : saveR.getErrors())
                   System.debug('error : '+err.getMessage()); 
             }
        }
        
    }
    
    //calling a static method from ProgrammeticSet3
    public void callingstaticMethod(){
    	
    	ProgrammeticSet3.staticMethodCalledFromNonStatic();
    }

   //using a non static varible from ProgrammeticSet3
   public void usingNonStaticVar(){
   	ProgrammeticSet3 ps3 =new ProgrammeticSet3();
   	ps3.nonStaticVariable ='this is non static variable';
   	System.debug(ps3.nonStaticVariable);
   	
   }
}