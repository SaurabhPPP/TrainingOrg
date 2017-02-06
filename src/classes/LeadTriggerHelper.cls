/*
   Created date :- 1/14/2017
*/
public with sharing class LeadTriggerHelper {
	
	public static Boolean  SKIP_LEAD_TRIGGER = false;
    //Method for clone the account record
	public static void cloneLead(List<Lead> newLead){
		
		List<Lead> listCloneLead = new List<Lead>();
		for(Lead le : newLead){
			Lead le1 = le.clone();
			listCloneLead.add(le1);
		}
		
		if(!listCloneLead.isEmpty()){
			SKIP_LEAD_TRIGGER = true;
			insert listCloneLead;
            List<Lead> l = [Select id from lead];
			SKIP_LEAD_TRIGGER = false;
		}
		
	}

}