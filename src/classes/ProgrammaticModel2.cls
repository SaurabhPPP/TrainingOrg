/*	Created date :- 1/11/2016
 * 
 */
 
public class ProgrammaticModel2 {

    /*1. Query on all Contact records and add them to the List. Print that contents of this list
     */
    public void printContactList(){
        List<contact> listcontact = [Select id ,name from contact];
        System.debug('All Contact are'+listcontact);
    }
    
    /*2. Write a SOQL query to retrieve/print all active Users. Prepare a Map having User Id as key and User
		record as value.
		(Hint : Map<Id,User>)
     */
    public void printUserMap(){
        
        Map<Id, User> userIDMap = new Map<Id,User>([Select id ,Name from user where IsActive = true]);
        System.debug('User Map'+userIDMap);
    }
    
    /*3. Prepare the following map structures :
 		a. Account Name as key and AccountId as value.
 		b. Account Id as key and entire Account object as value
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
    
    /*4. Create a multi-select picklist on Account object called as 'Enrollment Year' with values - 2010, 2011,
	 *	2012, 2013, 2014, 2015 and 2016. Get all account records where in selected 'Enrollment Year' is:
 	 *	a. 2010
 	 *  b. 2013 and 2014
     */
    public void displayAccountBasedOnEnrollment(){
        
        List<Account> listAccount2010Enrollment = [Select id ,Name from Account where Enrollment_Year__c ='2010'];
        System.debug(listAccount2010Enrollment);
        
        List<Account> listAccount1314 = [Select id ,Enrollment_year__c from account where Enrollment_year__c = '2013;2014'];
        System.debug(listAccount1314);
        
    }
    
    
    public void soqlExample(){
        
        /*5. Write a SOQL query to find all Account records where 'Billing State' is not 'Maharashtra' and
		'Kerala'. Order the results by Billing State in descending order with null values at the end. Display first
		10,000 records only. NOTE: do not use AND operator. 
	    */
        
        List<Account> listAccount = [Select Id ,Name From Account where BillingState not IN ('Maharashtra','Kerala') Order by BillingState desc NULLS LAST Limit 10000 ];
        System.debug('listAccount'+listAccount);
      
        /* 6. Write a SOQL query to display 100 opportunity records with amount greater than 10,000 order by
			created date. Skip first 50 records and include records from recycle bin. 
 		*/
        List<Opportunity> listOpportunity = [Select Id ,Name From Opportunity where Amount>10000 Order By CreatedDate Limit 100 OFFSET 50 ALL ROWS ];
        System.debug('listOpportunity' +listOpportunity);        
    }
   
    
    //Aggregate Functions
    public static void aggregateSOQLExample(){
        /*1. Write a SOQL query to retrieve sum of all closed Opportunity amount for current fiscal year. Store
			*this information in a map with key as year and value as sum of amount. Iterate this map to display
			statistics
		*/
        Map<String,Double> FiscalDateToSumOfAmount = new Map<String,Double>();
          for(AggregateResult agg : [Select CALENDAR_YEAR(CloseDate) closeddate , Sum(amount) sumofamt from Opportunity  where CloseDate = THIS_FISCAL_YEAR Group By CALENDAR_YEAR(CloseDate)]){       	
           FiscalDateToSumOfAmount.put(String.Valueof(agg.get('closeddate')),Double.valueOf(agg.get('sumofamt')));
          }
         //iterating the map as per requirement 
          for(String ite_Date : FiscalDateToSumOfAmount.keySet()){
            System.debug('CloseDate :'+ite_Date +'====>'+FiscalDateToSumOfAmount.get(ite_Date));
          }
               
        /*2. Find total number of distinct Lead records on basis of 'Lead Source' having greater than 10 leads.
		Print this information
		*/
        List<AggregateResult> aggregateDistinctlead = [Select LeadSource,COUNT_DISTINCT(Id) from Lead Group By LeadSource Having COUNT_DISTINCT(Id)> 10];
        System.debug('aggregateDistinctlead'+aggregateDistinctlead);
        
        /* 33. Write a SOQL query to find total number of Lead records by status by Lead Source. Store this
			information in map and display the same.
			(Hint: map<string,map<string,integer>>)
        */
        Map<String ,Map<String,Integer>>  mapLeadSourceToMapStatusToLeadCount = new Map<String ,Map<String,Integer>>();
        for(AggregateResult agg : [Select LeadSource ,Status ,COUNT(Id) noofLeads from Lead Group By LeadSource, Status Having leadSource != '']){
         	
            String temp_leadSource  = String.Valueof(agg.get('LeadSource'));
            String temp_leadStatus =  String.valueOf(agg.get('Status'));
            Integer temp_leadCount =  Integer.valueOf(agg.get('noofLeads'));
            if(mapLeadSourceToMapStatusToLeadCount.containsKey(temp_leadSource)){
                mapLeadSourceToMapStatusToLeadCount.get(temp_leadSource).put(temp_leadStatus ,temp_leadCount);
            }
            else{
                mapLeadSourceToMapStatusToLeadCount.put(temp_leadSource , new Map<String ,Integer>{temp_leadStatus => temp_leadCount});
            }
        }
        System.debug('mapLeadSourceToMapStatusToLeadCount '+mapLeadSourceToMapStatusToLeadCount);       
    }
    
    
  /*  Relationship query:
		 Child to Parent
		
		
		*/
	  public void relationShipSOQLQuery(){
	  	
	  	//1. Write a SOQL query onContact to retrieve all active contacts belonging to 'media' Industry. Also display the name of the account to which it is associated to.
	  	List<Contact> listContactwithParent =  [Select Id , Account.Name ,AccountId from Contact where Account.Industry = 'Media'];
	  	System.debug('listContactwithParent'+listContactwithParent);
	  	
	  	//2. Write SOQL query on 'C'(created above) to retrieve all records of 'C' with name 'John' along with parent details.
	  	List<C__c> listJunctionChildWithParent = [Select Id , Name ,A_Master__r.Name ,Bs__r.Name From C__c where Name ='John'];
	  	System.Debug('listJunctionChildWithParent'+listJunctionChildWithParent);
	  	
	  	
	  	//Parent to Child
		
	  	//1. Write a SOQL query on Account and find all associated contact records of the Account which contains the word 'John'. Print all Account and Contact records retrieved above.
	  	List<Account> listAccountWithContact = [Select Id ,Name ,(Select Id ,Name From Contacts where Name like '%John%') from Account];
	  	
	  	System.debug('listAccountWithContact' +listAccountWithContact);
	  	
	  	//2. Write a SOQL query to find all Account records which have at least an opportunity record which is 'Closed Won'.
	  	List<AggregateResult> listAccountHavingOpportunityClosed = [Select Count(ID) ,AccountId from Opportunity Where StageName = 'Closed Won' Group By AccountId  Having Count(Id) >0 ];
	  	For(AggregateResult agg : listAccountHavingOpportunityClosed){
	  		System.debug('AccountId= '+agg.get('AccountId'));
	  	}
	  	
	  	//3. Write a SOQL query on 'A' and retrieve all parents with all their child records where in child name is 'John'.
	  	List<A__c> listAwithAllCHavingJohnAsName = [Select Id ,Name ,(Select Id ,Name From Cs__r where Name ='John') From A__c];
	  	System.debug('listAwithAllCHavingJohnAsName '+listAwithAllCHavingJohnAsName);
	  	}	


 /*    SOSL
		
		2. Describe SOSL limits.
*/
	    public void SOSLExample(){
	    
	    //1. Find the word 'test' in all name fields returning Contact, Account, Lead and User.
	    List<List<Sobject>> soslResult = [Find 'test' IN ALL Fields Returning Account(ID ,Name) ,Contact(FirstName) ,Lead(Name), User(Name)];
	    
	    //2. Describe SOSL limits.
	    //The search engine looks for matches to the search term across a maximum of 2,000 records (this limit starts with API version 28.0).
        //SOSL applies different limits for a given object or situation. If the search is for a single object, the full record limit is applied. If the search is global across multiple objects, each object has individual limits that total 2,000 records.
	    	
	    }


     /*DML Operations:
		1. Create a custom object called as 'Logs'. Create a long text area field called as 'Error'. 
		Create 100 Lead records using DML operations having a unique name. 
		For all records which were not inserted into Lead object, 
		insert a record in Log object along with the reason why a record was not inserted. Also, 
		execute assignment rules to auto allocate Lead records to correct owner.
     */
     
     public static void createLogOnLeadCreationError(){
     	
     	List<Lead> listLeadTobeInserted = new List<Lead>();
     	//creating 100 lead with Unique Name 
     	for(Integer i = 0 ;i<100; i++){
     		Lead l = new Lead();
     		l.LeadSource ='Other';
     		l.Country ='US';
            l.FirstName = 'TrainingName'+i;
            l.LastName = 'USA';
            l.Company = 'SFTraining'+i;
            l.Status = 'Open-Not Contacted';
            listLeadTobeInserted.add(l);
     	}
     	
         Database.SaveResult[] saveResults = Database.insert(listLeadToBeInserted, False);
         	
         //Creating logs for error Leads 
         List<Logs__c> listLogsTobeInserted = new List<Logs__c>();
         for(Database.SaveResult sr : saveResults){
             
             if(!sr.isSuccess()){
                Logs__c lg = new Logs__c();
                 for(Database.Error er : sr.getErrors()){
                     lg.Error__c	=   lg.Error__c + ' '+ er.getStatusCode() + ': ' + er.getMessage()+'\n';
                 }
                listLogsTobeInserted.add(lg);
             }
         }
     	
         Insert listLogsTobeInserted;
      }
      
      /*2. Delete all inactive Account records created in last 90 days.
		3. Create a custom text field on the Asset object named 'Line Item Id' and mark it as an external id.
	  */
	  
	  public static void deleteInActiveAccount(){
	  	
	  	Delete  [Select Id  from Account where createdDate = LAST_N_DAYS:90 and Active__c ='No'];  	
	  
	  }	
      		
}