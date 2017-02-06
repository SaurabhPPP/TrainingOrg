//Controller class for DependentPicklist
public class DependentPicklistController{
    
    public String selectedIso {get;set;}
    public List<selectOption> listCity{get; set;}

    public List<selectOption> isoCodes {
     get {
       List<selectOption> options = new List<selectOption>();
       options.add(new SelectOption('None','None'));
       for (Country__c country : Country__c.getAll().values())
         options.add(new SelectOption(country.Name,country.Name));
       return options;

     }
     set;
   }
   
   
   public PageReference findListCity(){
      
       listCity = new List<selectOption>(); 
       Map<String ,City__c> mapCity = City__c.getAll();
       for (String city : mapCity.keySet()){
         if(mapCity.get(city).Country__c != null && mapCity.get(city).Country__c.equalsIgnoreCase(selectedIso))
         listCity.add(new selectOption(city,city));  
      }
      
      return null;
   }

}