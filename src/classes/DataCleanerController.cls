global class DataCleanerController {

public list<String> selectedfields { get; set; }

public String noOfRecord { get; set; }
public Boolean objectSelceted{get{

if(selectedObject==null)
return false;
else
return true;
}set;}

global Static Map<String, Schema.SObjectType> SchemaMap = Schema.getGlobalDescribe();
global String selectedObject{get; set;}
global List<ConditionWrapper> conditions{get; set;}
private Map<Integer ,ConditionWrapper> mapCondtion = new Map<Integer ,ConditionWrapper>();
public Map<String,String> MapConditionString = new Map<String,String>{'equal' => '=','contains'=> 'like','startwith' => 'startLike', 'ends' => 'endLike'};

global  class ConditionWrapper
{
public  Integer uId{get; set;}
public String fieldName{get; set;}
public String condition{get; set;}
public String value{get;set;}
global ConditionWrapper(Integer num){
  this.uId = num;
}

}

global  class SobjectWrapper
{
String name;
String id;

global  SobjectWrapper( Object n, Object i)
{
name= (String)n;
id=  (String)i;
}

}


public  List<SelectOption> getallObj()
{
 List<Schema.SobjectType> aso = schemaMap.Values();
 List<System.SelectOption> allso = new List<System.SelectOption>();
 for(Schema.SObjectType  f : aso)
 {
 DescribeSObjectResult df = f.getDescribe();
 if( df.fields== null || df.fields.getMap() == null || !df.isQueryable())
 continue;
 System.SelectOption so = new System.SelectOption( df.getName(),df.getLabel());
 allso.add(so);
 
 }
allso = selectOptionSortByLabel(allso);
return allso;
}


public List<SelectOption> getallFields(){
   List<SelectOption> listfields = new List<SelectOption>();
   if(selectedObject!=null){
      for(Schema.SObjectField sfield : schemaMap.get(selectedObject).getDescribe().fields.getMap().values()){
          schema.describefieldresult dfield = sfield.getDescribe();
          listfields.add(new SelectOption(dfield.getname() ,dfield.getLabel()));
      }
   }
   
   return listfields;
}


public List<SelectOption> getlistConditon(){
 List<SelectOption> listS = new List<SelectOption>();
 for(String conditions : MapConditionString.keySet()){
  listS.add(new SelectOption(conditions ,MapConditionString.get(conditions)));  
 }

 return listS ;
}

public pageReference addFilter(){
  
  ConditionWrapper cw;
  if(conditions== null || conditions.isEmpty()){
    cw = new ConditionWrapper(1);
    conditions = new List<ConditionWrapper>{cw};
  }else{
    cw = new ConditionWrapper(conditions.size()+1);
    conditions.add(cw);  
  }
   mapCondtion.put(cw.uId ,cw);
   return null;
}

 public void removeCondition() {
 
     Integer tobedel = Integer.valueOf(ApexPages.currentPage().getParameters().get('removeId'));
     if(mapCondtion.containsKey(tobedel))
     mapCondtion.remove(tobedel);
     
     conditions = mapCondtion.values();  
    }



@RemoteAction
global static String getAllRecord(string objname)
{

string query = 'select name, id from '+objname;
string query1 = 'select  id from '+objname;
list<SObject> allsobj = new list<SObject>();
try{
 allsobj  = database.Query(query);
}
catch(Exception e)
{
 allsobj = database.Query(query1);
}
list<SobjectWrapper> allsobjw = new list<SobjectWrapper>();
for(SObject s : allsobj)
{
allsobjw.add( new SobjectWrapper(s.get('name'), s.get('id')));
}
String  jsonallrecord = JSON.serialize(allsobjw);
system.debug(jsonallrecord);
return '{\"Records\":'+jsonallrecord+',\"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + allsobj.size() + '\"}';

}

//Method to Sort List of String as per label
public list<selectOption> selectOptionSortByLabel(list<selectOption>
                                                            selectOptionsToSort) {
        if(selectOptionsToSort == null || selectOptionsToSort.size() <= 1){
            return selectOptionsToSort;
        }
        List<SelectOption> lessSelectOption = new List<SelectOption>();
        List<SelectOption> greaterSelectOption = new List<SelectOption>();
        integer pivot = selectOptionsToSort.size() / 2;
        
        //save the pivot and remove it from the selectOption list
        SelectOption pivotValue = selectOptionsToSort[pivot];
        selectOptionsToSort.remove(pivot);
        for(selectOption SO : selectOptionsToSort){
            if(SO.getLabel() <= pivotValue.getLabel()){
                lessSelectOption.add(SO);
            }else if(SO.getLabel() > pivotValue.getLabel()){
                greaterSelectOption.add(SO);   
            }
        }
        list<selectOption> sortedSelectOptions = new list<selectOption>(); 
        sortedSelectOptions.addAll(selectOptionSortByLabel(lessSelectOption));
        sortedSelectOptions.add(pivotValue);
        sortedSelectOptions.addAll(selectOptionSortByLabel(greaterSelectOption));
        return SortedSelectOptions;
    }
}