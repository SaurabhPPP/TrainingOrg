/*
created date : 1/5/2016
*/
public  class ProgrammaticSet2 {
	
	//static variable , this can be utilize any where in static method of this class , and can be accesible without creating instance
	// of this class
	public static Set<long> notPrimeNorComposite = new set<long>{0,1,2};
	
	public static String checkPrime(long num){
		String result = 'Valid  Number not  Selected';
		if(num != null && !notPrimeNorComposite.contains(num) ){
			//taking squre root of number provided for prime check 
			long size = Math.roundToLong((Math.sqrt(Decimal.valueOf(num))));
			result = 'The Number '+num +' is Prime';
			for(long i = 2; i <= size ; i++){  
				 if(math.mod(num ,i)==0){
				 result = 'The Number '+num +' is Composite';
				 break;
				 }
			}
		 }else if(notPrimeNorComposite.contains(num)){
			 if(num == 2)
			 result = 'The number '+num+' is Prime';
			 
			 
			 else
			 result = 'The number '+num+' is Neither Prime Nor Composite';
			 
		 }
		
		System.debug(result);
		return result;
	 }
	 
	 
	 public static String checkPalindrome(String palindrom){
	 	String result = 'Not a Palindrome';
	 	if(palindrom != null && palindrom.length()>0 && palindrom.reverse().toLowerCase() == palindrom.toLowerCase())
	 	 result = 'This is a Palindrome';
	 	
	 	System.debug(result);
	 	return result;
	 	
	 }
	
	 
	 public static String[] replaceCharacter(String[] listString , String text){
	 	
	 	System.debug('befor ' +listString);
	 	if(listString.isEmpty() || text == null)
	 	return listString;
	 	List<String> listofString = new List<String>();
	 	for(String s : listString){
	 		s = s.remove(text);
	 		listofString.add(s);
	 	}
	 	
	 	System.debug('After '+listofString);
	 	return listofString;
	 	
	 }
	 
	 
	 public static Integer lengthOfString(String text){
	 	Integer sizeofString = 0;
	 	if(String.isEmpty(text))
	 	return sizeofString;
	 	
	 	String[] stringCharArray = text.split('');
	 	for(String s : stringCharArray){
	 		sizeofString++;
	 	}
	 	System.debug('Size is '+sizeofString );
	 	
	 	return sizeOfString;
	 	
	 }
	 
  //Print Unique number in array 
    public static Set<Integer> printDupicate(List<Integer> arr){
        //creating a map to hold duplicate counting
        Set<Integer> temparr = new Set<Integer>();
        Map<Integer, Integer> mapduplicate = new Map<Integer, Integer>();
        for(Integer i=0; i<arr.size(); i++){
            
            if(mapduplicate.containsKey(arr[i])){
                mapduplicate.put(arr[i], mapduplicate.get(arr[i])+1);
                temparr.remove(arr[i]);
            }
            else{
               mapduplicate.put(arr[i], 1);
               temparr.add(arr[i]);
            }  
        }
        System.debug('Unique occurrences in the array Is below\n'+temparr);
        return temparr;
    } 
    
    
    //Advanced Concept 
    //1. Query on Account object /records and if the account is person account print the ID of
    // that record. (Hint : You have to enable person account )
    //Presently Person account is not enabled for this dev Org , So no data will return , new field isPersonAccount__c in place of
    // isPersonAccount is used , isPersonAccount only available when person account enabled 
    public Set<Id> printPersonAccount(){
    	   Set<Id> personAccountId = new Set<Id>();   
    	   List<Account> listAccount = [Select id ,name ,isPersonAccount__c  from Account];
    	   if(listAccount.isEmpty())
    	   return null;
    	   
    	   //Traditional for loop
    	   for(Integer i=0;i <listAccount.size() ;i++){
    	   		if(listAccount[i].isPersonAccount__c){
    	   	    	personAccountId.add(listAccount[i].id);
    	   	    	System.debug('This is a Person Account' + listAccount[i].Id);
    	   	    } 
    	   }
    	   personAccountId.clear();
    	   //Advanced for loop
    	   for(Account a :listAccount){
    	   	    if(a.isPersonAccount__c){
    	   	    	personAccountId.add(a.id);
    	   	    	System.debug('This is a Person Account' + a.Id);
    	   	    }
    	   }
    	   
    	   return personAccountId;
    	   
    	}



	//2. Query on all Opportunity records where its Account != NULL and Status = Closed
	public void printOpportunity(){
		Map<Id, Opportunity> mapOpportunities = new Map<Id,Opportunity>([Select Id ,Name,AccountId from Opportunity where AccountId != Null and StageName ='Closed']);
		
		if(mapOpportunities.isEmpty())
		return;
		
		
        //a. Add all Opportunity Id’s to the List and print the result
        list<Id> listOppId = new List<Id>(mapOpportunities.keyset());
        System.debug('List of Opportunity Id'+ listOppId);
        
        //b.Add all Account Id’s to the set and print the result
        Set<Id> setAccountId = new Set<Id>();
        for(Opportunity opp : mapOpportunities.values()){
        	setAccountId.add(opp.AccountId);
        }
        System.debug('Set of Account Id'+ setAccountId);
        
        //c.Prepare the Map having Key as OpportunityId and Value as AccountId
        Map<Id,Id> mapOpportunityIdWithAccountId = new Map<Id, Id>();
        for(Opportunity opp :mapOpportunities.values()){
        	mapOpportunityIdWithAccountId.put(opp.id , opp.AccountId);
        }
        
        System.debug('mapOpportunityIdWithAccountId '+ mapOpportunityIdWithAccountId);
	}
	
	
	//3. Find all the Account Names starting with ‘a’. Print that count and update all those
 	//accounts with New Name as ‘Updated via update DML operation’
 	public void updateAccount(){
 		List<Account> listAccountToBeUpdated = new List<Account>();
 		
 		for(Account acc :[Select Id ,Name from Account where name like 'a%']){
 			acc.Name ='Updated via update DML operation'+acc.Name;
 			listAccountToBeUpdated.add(acc);  	
 		}
 		
 		//Printing count of account
 		System.debug(listAccountToBeUpdated.size());
 		
 		//Updating the account Name
 		update listAccountToBeUpdated;
 		
 	}
 	
 	
 	//4. Prepare the Map structure to show the Account (As key) and Its opportunities as
	//List(Value)
	//Hint : Query on Account and get the child opportunities or
	//Query on Opportunities and get the parent Account Id
	//Hint : Your map structure will be : Map<Id,List<Id>>
	public void printAccountToOpportunites(){
		Map<Id ,List<Opportunity>> mapAccountToOpportunities = new Map<Id,List<Opportunity>>();
		
		for(Opportunity opp : [Select Id ,Name ,AccountId From Opportunity where AccountId !=null]){
			
			if(mapAccountToOpportunities.containsKey(opp.AccountId)){
				mapAccountToOpportunities.get(opp.AccountId).add(opp);
			}else{
				mapAccountToOpportunities.put(opp.AccountId ,new List<Opportunity>{opp});
			}
		}
		
		//printing
		System.debug('Account to Opportunities '+mapAccountToOpportunities);
	} 
	
	
	//5. Write a SOQL Query on to retrieve/print 10 Campaign records and sort in ascending
	//as well as descending order.
	
	
	
	
	//6. Write a SOQL query to retrieve/print the Contact records where Last Modified Date = = Today
    public   List<Contact> queryOnAccount(){
        
        List<Contact> listTodayCreatedContact =  [Select Id ,Name From Contact Where CreatedDate =:System.today()];
        System.debug('Today Created Contacts ' + listTodayCreatedContact);
        return listTodayCreatedContact;
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