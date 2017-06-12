trigger callBatchApex on Account (after insert) {	
	list<account> accList = new list<account>();
	for(Account acc : trigger.new){
		if(acc.annualrevenue<200000)
			accList.add(acc);
		if(accList.size()>0)
			database.executeBatch(new BatchApexDemo(),200);
			
	}    
}