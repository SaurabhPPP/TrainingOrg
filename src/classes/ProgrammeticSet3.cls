/*
created date : 1/8/2016
*/
public with sharing class ProgrammeticSet3 {
	
	//1 & 3. Method which will accept Integer parameter and print Fibonacci series upto that
	//number
	
	public static Integer[] printFibnacci(Integer num){
		Integer[] fibnaccinum = new list<Integer>();
		Integer prev = 0;
		Integer curr = 1;
		System.debug('Fibnacci number upto '+num +' = ');
		for(Integer i=0;i<num;i++){
			fibnaccinum.add(prev + curr);
			prev = i==0?0:fibnaccinum[i-1];
			curr = fibnaccinum[i];
			System.debug(curr +'\n');
		}
		
		
		return fibnaccinum;
		
	}
    
    //2. Method to reverse the string
    public static String reverseOfString(String text){
	 	Integer sizeofString = 0;
	 	if(String.isEmpty(text))
	 	return text;
	 	String reverseString = '';
	 	String[] stringCharArray = text.split('');
	 	for(Integer i = stringCharArray.size(); i>0 ;i--){
	 		reverseString =reverseString+stringCharArray[i-1];
	 	}
	 	System.debug('reverse String  is '+reverseString );
	 	
	 	return reverseString;
	 	
	 }
	 
	// 4. Method which will accept String as Parameter and performs following operations :
	//String : ‘Welcome to @pex Programming’
	public static void stringOperation(String s){
		//a. Replace the occurrences of ‘@’ with A and print it
		
		String replace = s.replace('@','A');
		System.debug('Replaced the occurrences of \'@\' with A and print it '+replace);
		
		//b. Print the substring ‘Apex Programming’
		System.debug(replace.subStringAfter('Welcome to'));
		
		//c. Split the String using space and print the result
		List<String> splitString = s.split(' ');
		System.debug('Print after splitting with space '+splitString);
		
		//d. Remove the spaces in the String and Print the result
		String removeSpace = s.replace(' ','');
		System.debug('removeSpace '+removeSpace);
		
		//e. Convert the string to the upper case and print the result
		System.debug('Upper Case '+s.toUpperCase());
		
		//f. Convert the string to the lower case and print the result
		System.debug('Upper Case '+s.toLowerCase());
		
		//5. Accept a string as a parameter and count the occurrence of every character in it
		Integer sizeofString = 0;
		String[] stringCharArray = s.split('');
		for(String tex : stringCharArray){
	 		sizeofString++;
	 	}
	 	System.debug('Size is '+sizeofString );
		
	}
	
	
	
	//OOPS Concepts (Set 3)
	
	
	
	//1. Write a static method in a class and call it from another (nonstatic) class(OppsConceptClass)
	public static String staticMethodCalledFromNonStatic(){
		return 'This is a Static Method Call Return Statement';
	}
	
	
	//2. Write a void method having non static declaration to debug/ print ‘Hello World’
	public void printHelloWorld(){
		System.debug('Hellow World');
		
	}
	
	//3. Declare the variables non static and identify the result
	//this variable example is in Class :-OppsConceptClass
	public String nonStaticVariable ;
	
	//4. Implement an abstract method :-  See SOQAbstractClass 
    //5. Override the abstract method created above:- See OppsCoceptClass
    //6. State the basic difference between an interface and an abstract class (common for
    //every group) :- see SOQAbstractClass and CalculatorInterface
    
	
	
	
	
/*	      //Advanced concepts / Collections/SOQL Queries/DML Operations (Set 3)*/
	
	//1. Query on All Contact records & add all to the List and print that list.
	public   void showAllContact(){
        List<Contact> listContact = [Select Id ,Name from Contact];
        if(listContact.isEmpty())
            return ;
        //traditional for loop
        for(Integer i =0; i<listContact.size(); i++){         
            //print account
            System.debug('Contact :- '+listContact[i]);
        }     
    }
    
    //2. Write a Method which find all the associated contact records of the Account and Print it
    public void showAssociatedContactofAccount(){
    	Map<Id ,List<Contact>> mapAccountToContacts = new Map<Id,List<Contact>>();
    	
    	for(Contact contact : [Select Id ,Name ,AccountId From Contact where AccountId !=null]){
			
			if(mapAccountToContacts.containsKey(contact.AccountId)){
				mapAccountToContacts.get(contact.AccountId).add(contact);
			}else{
				mapAccountToContacts.put(contact.AccountId ,new List<Contact>{contact});
			}
		}	
		//printing
		System.debug('Account to Contacts '+mapAccountToContacts);
    }
    
    
    //3. Create a Account , Contact, Lead , Opportunity record through DML operations.
    public void createRecordsInSf(){
    	
    	//creating Account
    	Account acc = new Account(Name='PuneTraining');
    	Insert acc;
    	
    	//Creating Contact
    	Contact contact = new Contact();
    	contact.Email ='test@gmtrail.com';	
    	contact.AccountId = acc.Id;
    	contact.FirstName = 'test';
    	insert contact;
    	
    	//Creating Lead
    	Lead lead = new Lead();
    	lead.FirstName = 'Lead1';
    	lead.company = 'Company';
    	insert lead;
    	
    	//Opportunity
    	Opportunity opp = new Opportunity();
    	opp.AccountId = acc.id;
    	opp.Name = 'Opportunity Name';
    	opp.CloseDate = System.Today();
    	opp.StageName = 'Open';
    	insert opp; 
    }
    
    
    //4. Write a SQOL Query to show Parent Child relationship and print the result.
	//(for example : Account is parent and Contact is child. Then Query on Account)
	
	public void parentChildQuery(){
		Map<Id ,List<Contact>> mapAccountToContacts = new Map<Id,List<Contact>>();
    	
    	for(Account acc :[Select Id ,(Select Id from Contacts) from Account]){
    	  	if(!acc.contacts.isEmpty())
    	  	mapAccountToContacts.put(acc.id , acc.contacts);
    	}
    	
    	System.debug('Printing parent Child '+mapAccountToContacts);
	}	
   
 /*5. Write a SOQL query to retrieve/print the User records where Active = true. Prepare the
     Map having User Id as key and User record as value
     (Hint : Map<Id,User>) 	
 */
 	public Map<Id ,User> retrieveUserMap(){
   		Map<Id,User> mapUserIdToUser = new Map<Id,User>([Select Id, Name ,Profile.Name From User where IsActive = true]);
   		System.debug('Active User Map'+ mapUserIdToUser);
   		return mapUserIdToUser;
   }
 
   
 /*   6. Prepare the Following Map Structures :
	  a. AccountName as key and AccountId as Value
	  b. AccountId as key Entire Account object as Value
 */
 	public void mapAccountObject(){
		//a. AccountName as key and AccountId as Value
		Map<String ,Id> mapAccountNameAccountId = new Map<String ,Id>();
		
		//b. AccountId as key Entire Account object as Value
		Map<Id, Account> mapAccountIdWithAccount = new Map<Id,Account>();
		
		for(Account acc :[Select Id ,Name from Account ]){
			mapAccountNameAccountId.put(acc.Name ,acc.Id);
			mapAccountIdWithAccount.put(acc.id ,acc);
		}
		
		System.debug('mapAccountNameAccountId '+mapAccountNameAccountId);
		System.debug('mapAccountIdWithAccount '+mapAccountIdWithAccount);
	}
   
   
   //7. Demonstrate the usage of Database.query and Database.search methods
    public   void demonstrateDatabaseQueryAndSearch(){
        
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
    public  void demonstrateBasicDMLAndDatabaseDML(){
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
   
	
}