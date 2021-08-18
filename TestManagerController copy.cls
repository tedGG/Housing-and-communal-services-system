@isTest
public with sharing class TestManagerController {
    
     @testSetup static void setup() {
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.State__c = 'test';
        user.rate__c = 1.43;
        user.Token__c = 'testtoken';
        user.debt__c = true;
        user.Payment__c = 159;
         
        insert user;
    }
    
    @isTest
    public static void testManagerController() {
        
 		ManagerController controller = new ManagerController();
        List<CustomUser__c> stateUser = [SELECT Id,Name,Rate__c,Token__c,State__c,Payment__c FROM CustomUser__c WHERE Name = 'test'];     	
        System.assert(stateUser!=null);  
        
        controller.loginPage();
        
    }
}