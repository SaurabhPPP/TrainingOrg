/*
  Lead Manipulator Service (Using Soap)
*/
global  with sharing class LeadManipulatorService {

   //Inner Class for Soap Respose 
	global class SoapResponse{
		webService Boolean isSuccess;
		webService String  lead ;
		webService String  Status;
		
		//creating constructor for Response Wrapper 
		global SoapResponse(){
			this.isSuccess = false;
			this.lead = null;
			this.Status = 'No Information Provided';
		}
		
	 }
	
	//Inner Wrapper Class for Soap Input 
	global class LeadInfo{
		webService String  firstName ;
		webService String  lastName;
		webService String  email;
		webService String  Phone;		
	 }
    
    //Create a new Lead in Salesforce basis the First Name, Last Name, Email and Phone values. 
    //The service should return a response specifying the following :
    webService static SoapResponse createNewLeadThorughSoap(LeadInfo linfo){
    	
    	//creating response object
    	SoapResponse res = new SoapResponse();
    	if(linfo!= null){
    		//Creating Lead based on info provided through Soap 
    		Lead soapLead = new Lead();
    		soapLead.FirstName = linfo.firstName;
            soapLead.LastName = linfo.lastName;
            soapLead.Email = linfo.email;
            soapLead.Phone = linfo.Phone;
            try{
            	insert soapLead;
            	res.isSuccess = true;
            	res.lead = soapLead.id;
            	res.Status = 'Success';
            	
            }catch(Exception e){
            	res.Status = e.getMessage();
            }
    	}
    	
    	return res;
     }
     
    
     //Delete the Lead record in Salesforce basis the FirstName, LastName, 
     //Email and Phone exact match combination. The above attributes will be posted to the SOAP Service as input 
     //params and the service should return a response specifying the following:
     
     webService static SoapResponse deleteLeadThroughSoap(Leadinfo linfo){
     	
     	String query = 'Select Id ,Name From Lead ';
    	//creating response object
    	SoapResponse res = new SoapResponse();
    	If(linfo != null){
    		query = query + 'Where '+
    		       +'FirstName = '+linfo.firstName+ ' And '+
    		       +'LastName = '+linfo.lastName+' And '+
    		       +'Email = '+linfo.email+' And '+
    		       +'Phone = '+linfo.Phone+' Limit 1';
    	
    	    List<Lead> leadToDelete = Database.query(query);
    	    //checking if query has some matched lead 
    	    If(leadToDelete != null && !leadToDelete.isEmpty()){
    	    	try{
    	    		String LeadName = leadToDelete[0].Name;
    	    		delete leadToDelete;
    	    		res.isSuccess = true;
    	    		res.lead = leadName;
    	    		res.Status = 'Success';
    	    	}catch(Exception e){
    	    		res.Status = e.getMessage();
    	    	}
    	    	
    	    }
    	 }
    	return res; 	
     }
     
     //Update the Email and Phone fields of Lead record in Salesforce basis 
     //the First Name and Last Name exact match combination. The following attributes will be posted 
     //to the Soap Service – First Name, Last Name, New Email and New Phone.
     // The service should return a response specifying the following:
     
     webService static SoapResponse updateLeadThroughSoap(Leadinfo linfo){
     	
     	String query = 'Select Id ,Name From Lead ';
    	//creating response object
    	SoapResponse res = new SoapResponse();
    	
    	If(linfo != null){
    		query = query + 'Where '+
    		       +'FirstName = '+linfo.firstName+ ' And '+
    		       +'LastName = '+linfo.lastName+' Limit 1';
    	
    	    List<Lead> leadToUpdate = Database.query(query);
    	    //checking if query has some matched lead 
    	    If(leadToUpdate != null && !leadToUpdate.isEmpty()){
    	    	try{
    	    		leadToUpdate[0].Email = linfo.email;
            		leadToUpdate[0].Phone = linfo.Phone;
    	    		update leadToUpdate;
    	    		res.isSuccess = true;
    	    		res.lead = leadToUpdate[0].Id;
    	    		res.Status = 'Success';
    	    	}catch(Exception e){
    	    		res.Status = e.getMessage();
    	    	}	
    	    }
    	 }
    	return res; 	
     }
     
}