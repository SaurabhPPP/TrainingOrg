public class MultiLanguageController {
   
    public Employee__c employee {get;set;}
    public boolean showMessage{get; set;}
    public Student__c  student{get; set;}
    private ApexPages.StandardController  sc;
    public String selectedLanguage{get{
    selectedLanguage= selectedLanguage== null || selectedLanguage==''?'en':selectedLanguage;
    return selectedLanguage;
    
    }set;}
    
    /*
Chinese (Simplified): zh_CN
Chinese (Traditional): zh_TW
Danish: da
Dutch: nl_NL
English: en_US
Finnish: fi
French: fr
German: de
Italian: it
Japanese: ja
Korean: ko
Norwegian: no
Portuguese (Brazil): pt_BR
Russian: ru
Spanish: es
Spanish (Mexico): es_MX
Swedish: sv
Thai: th
*/
    public List<selectOption> listLanguage{
    get {
       List<selectOption> options = new List<selectOption>();
       options.add(new SelectOption('en','English'));
       options.add(new SelectOption('fr','French'));
       options.add(new SelectOption('es','Spanish'));
       options.add(new SelectOption('hi','Hindi')); 
       return options;
      }
      set;
     }

    public MultiLanguageController(ApexPages.StandardController controller) {
       sc = controller;
       showMessage = false;
    }
    
    public void submit(){
        showMessage = true;
     try{
        if(sc != null && student == null)
        student = (Student__c)sc.getRecord(); 
        
        if(student!= null)
         insert student;  
         
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,  Label.Success_Message+' '+student.Student_Name__c));
       }catch(Exception e){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
       }
     
    }
    
    public  void reset(){
      student = null ; 
    }
}