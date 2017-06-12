/*
* Schedular for BatchNotifyClosedOnOpportunity 
*/
public with sharing class ScheduleBatchDeleteDubLead implements Schedulable {

   public void execute(SchedulableContext sc) {
      BatchDeleteDuplicateLead  delDubLead = new BatchDeleteDuplicateLead(); 
      database.executebatch(delDubLead);
      
      ScheduleBatchDeleteDubLead mySchdule = new ScheduleBatchDeleteDubLead();
      DateTime currentTime = DateTime.Now().addHours(3);
      
	  String cronstring = currentTime.second()+' '+currentTime.minute()+' '+currentTime.hour()+' * * ?';
	  //calling next Schedular after 3 hrs .
	  String jobID = system.schedule('nextSchdular'+currentTime, cronstring, mySchdule);
      
   }

}