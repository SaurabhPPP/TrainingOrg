public with sharing class Case_TriggerHelper {

    public static boolean SKIP_CASE_Trigger = false;
    
    // method to clone the case records
     public static void cloneCase(List<Case> newCase) {
        list<Case> lstCloneCase = new list<Case>();
        for(Case loopcase : newCase) {
            Case case1 = loopcase.clone();
            lstCloneCase.add(case1);
        }
        
        if(!lstCloneCase.isEmpty()) {
            SKIP_CASE_Trigger = true;
            insert lstCloneCase;
            SKIP_CASE_Trigger = false;   
        }
     }
}