global class BatchApexDemo implements database.Batchable<sObject> {
	public string soqlquery;
	
	public void BatchApexDemo() {
		soqlquery = 'select id,name from account limit 1';
	}
	global database.QueryLocator start(database.BatchableContext bc) {
		return database.getQueryLocator(soqlquery);
	}
	global void execute(database.BatchableContext bc,list<sObject> scope) {
		system.debug('**In Execute method **');
	}
	global void finish(database.BatchableContext bc) {
		
	}
}