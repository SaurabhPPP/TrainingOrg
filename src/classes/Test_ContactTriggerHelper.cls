/*
Test Class for ContactTriggerHelper :- 90% coverage 
*/


@isTest
public with sharing class Test_ContactTriggerHelper {
    
    
    static testMethod void testcheckForDuplicateContact(){
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            
            Account acc = new Account();
            acc.Name ='TestAccount';
            acc.OwnerId = UserInfo.getUserId();
            test.startTest();
            insert acc;
            
            //creating first Contact records 
            List<Contact> listContact = new List<Contact>();
            Contact NewContact = new Contact (
                FirstName = 'xyzFirst',
                LastName = 'XyZLast',
                //line changed - waveoc 
                AccountId = acc.Id, 
                Email = 'xyzmail@mail.com',
                Phone = '987654321'
            );
            listContact.add(newContact);
            
            //creating duplicate contact 
            Contact duplicateContact = new Contact (
                FirstName = 'xyzFirst1',
                LastName = 'XyZLast1',
                //line changed - waveoc
                AccountId = acc.Id,
                Email = 'xyzmail@mail.com',
                Phone = '987654321'
            );
            listContact.add(duplicateContact);
            
            try{
                //inserting two contact similar 
                insert listContact;
            }catch(DMLException e){
                System.assert(e.getMessage().containsIgnoreCase('A Contact with the same email address or phone number being  inserted in system'));
                
            }
            
            //inserting first contact 
            insert newContact;
            System.assert(newContact.id != null);
            
            try{
                //inserting second contact duplicate one 
                insert duplicateContact;
            }catch(DMLException e){
                System.assert(e.getMessage().containsIgnoreCase('A Contact with the same email address or phone number being  inserted in system'));
                
            }
            
        }
    }
    
    
    static testMethod void testassociateAccountwithContact(){
        
        //creating a testing user 
        User testUser = TestDataFactory.createUser(); 
        System.runAs(testUser){
            Account acc = new Account();
            acc.Name ='TestAccount';
            acc.OwnerId = UserInfo.getUserId();
            test.startTest();
            insert acc;
            
            //creating a Contact records 
            List<Contact> listContact = new List<Contact>();
            Contact NewContact = new Contact (
                FirstName = 'xyzFirst',
                LastName = 'XyZLast',
                //line changed - waveoc 
                AccountId = acc.Id, 
                Email = 'xyzmail@mail.com',
                Phone = '987654321'
            );
            
            insert newContact;
            System.assert(newContact.id != null);
            
            acc.site = 'test1.com';
            acc.website ='test1.com';
            update acc;
            
            newContact.Email = 'xyzmail@test1.com';
            update newContact;
            
            //Assertinon 
            System.assertEquals(newContact.AccountId , acc.ID);	
            
        }
        
    }
}