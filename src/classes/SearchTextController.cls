public class SearchTextController {

    public String searchText{get; set;}
    public Map<String,List<Sobject>> serachResultmap{get; set;}
   
    public void searchInputText(){
      List<List<Sobject>> serachResult= new List<List<Sobject>>();
      searchText = '*'+searchText+'*';
      String searchquery='FIND\'*'+searchText+'*\'IN NAME FIELDS RETURNING Account(id,name),Contact(FIRSTNAME,LASTNAME,ID), Lead(NAME,ID),Opportunity(Name,Id)'; 
      //List<List<SObject>>searchList=search.query(searchquery);
      serachResult= [FIND :searchText IN NAME FIELDS RETURNING Account(Id,Name),Contact(FIRSTNAME,LASTNAME,Id,Name), Lead(Name,Id),Opportunity(Name,Id)];
      serachResultmap = new Map<String,List<Sobject>>();
      for(Integer i =0; i<serachResult.size(); i++){
          //finding type of Sobject
          if(serachResult[i] != null && !serachResult[i].isEmpty()){
          String type = serachResult[i][0].getSObjectType().getDescribe().getLabel();
          serachResultmap.put(type,serachResult[i]);
          }

      }
      searchText = searchText.remove('*') ;
      
    }
}