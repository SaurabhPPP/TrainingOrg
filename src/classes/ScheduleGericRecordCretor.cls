/*
* Schedular for BatchNotifyClosedOnOpportunity 
*/
public with sharing class ScheduleGericRecordCretor implements Schedulable {

   public void execute(SchedulableContext sc) {
      BatchCreateGenericObjcet  gericRecCreator = new BatchCreateGenericObjcet(); 
      database.executebatch(gericRecCreator);
      
       //deleteing all earlier ScheduleJob for this batch or schedular
       For(CronTrigger ct : [SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType FROM CronTrigger Where CronJobDetail.Name like 'CreateGeneric%']){
           System.abortJob(ct.ID);
       }
      ScheduleGericRecordCretor mySchdule = new ScheduleGericRecordCretor();
      DateTime currentTime = DateTime.Now().addMinutes(1);
      
	  String cronstring = currentTime.second()+' '+currentTime.minute()+' '+currentTime.hour()+' * * ?';
	  //calling next Schedular after 3 hrs .
	  String jobID = system.schedule('CreateGeneric'+currentTime, cronstring, mySchdule);
      
   }

}