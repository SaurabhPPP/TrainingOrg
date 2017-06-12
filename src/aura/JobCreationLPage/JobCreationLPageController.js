({
	createJob : function(component, event, helper) {
		
        component.set("v.job",{ 'sobjectType': 'Job__c',
                    'Job_Summary__c': '',
                    'Job_Description__c': '',
                    'Job_Type__c': '' });
	}
})