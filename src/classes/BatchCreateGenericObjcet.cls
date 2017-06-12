/*
* B. Removal of duplicate Leads 
1. During the Campaigning, It might happen that representative creates duplicate leads in an org. 
2. So admin want to build a process which will run every 3 hours/day & remove the duplicate leads from 
the org. 
3. The criteria to find the duplicate records should be configurable. 

Ex. If there are two leads in a system with same Email address then keep the first lead entry & remove all 
the other leads. 
So the field like Email, Name which will be deciding the uniqueness should be configurable. 
*
*/
/*
C. Generic Record Creation Engine 
1. The third party system will create events in a system to create any sobject's records.   
2. There will be a field will hold the JSON of the record & the object name. 

JSON : { 
Name : Training Org 
} 
Object Name : Account 
3. so create a process which will execute per minute & process the Event's records creating the 
respective sObject. 
*/
public  class BatchCreateGenericObjcet implements Database.Batchable<sObject>{
    
    //Start Method , we use QueryLocator here
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id ,IsCreated__c,Object_Name__c,FieldCreatorJson__c from GenericSobjectCreator__c where IsCreated__c = false');
    }
    
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        
        //Doing TypeCasting
        List<GenericSobjectCreator__c> listGsc = (List<GenericSobjectCreator__c>) scope;
        
        //sobject record need to be created
        List<sObject> listNewSobject = new List<sObject>();
        
        //finding all new record creating request
        For(GenericSobjectCreator__c gsc : listGsc){ 
            //Json Prarser map
            Map<String ,Object> MapfieldTypeToValue  = new Map<String,Object>();
            //creating Dynamic Sobject 
            sObject dobject = Schema.getGlobalDescribe().get(gsc.Object_Name__c).newSObject() ;
            
            if(dobject == null)  continue;
               
            //deserializing JSON
            MapfieldTypeToValue =  (Map<String, Object>)JSON.deserializeUntyped(gsc.FieldCreatorJson__c);
            
            //iterate through Json
            for(String field : MapfieldTypeToValue.keySet()){
                dobject.put(field , MapfieldTypeToValue.get(field));
            }
            
            listNewSobject.add(dobject);
            gsc.isCreated__c = true;
        }
        
        
        //Creating new records
        If(listNewSobject != null && !listNewSobject.IsEmpty())	{
            AccountTriggerHelper.SKIP_ACCOUNT_TRIGGER = true;
            DataBase.Insert(listNewSobject,false);
            AccountTriggerHelper.SKIP_ACCOUNT_TRIGGER = false;
            Update  listGsc;
        }      
    }
    
    
    public void finish(Database.BatchableContext BC){        
    }
    
}