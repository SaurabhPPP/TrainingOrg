/*
* Schedular for BatchNotifyClosedOnOpportunity 
*/
public with sharing class ScheduleBatchNotifyOpportunityInfo implements Schedulable {

   public void execute(SchedulableContext sc) {
      BatchNotifyClosedOnOpportunity  closedWonOppBatch = new BatchNotifyClosedOnOpportunity(); 
      database.executebatch(closedWonOppBatch);
   }

}