@isTest
public with sharing class TestRegistration {
    @testSetup static void setup(){

		CustomUser__c customusercObj = new CustomUser__c (
			Name = 'test value', 
			Token__c = 'test value', 
			Email__c = 'testEmail@gmail.com', 
			City__c = 'test value', 
			rate__c = 1.1, 
			State__c = 'test value', 
			debt__c = TRUE, 
			Payment__c = 1.1, 
			RateWater__c = 1.1, 
			RateElectricity__c = 1.1, 
			secretKey__c = 'test value'
		);
		insert customusercObj;
		 Metersreadings__c metersreadingscObj = new Metersreadings__c (
			Name = 'test value', 
			Previous__c = 1.1, 
			Current__c = 1.1, 
			State__c = 'test value', 
			Payment__c = 1.1,
			Custom_User__c = customusercObj.id
		);
		insert metersreadingscObj;
		 
	}
    @IsTest
    public static void registrationTest(){
     
       List<CustomUser__c> user = [SELECT Name,Token__c,Email__c,City__c,rate__c,State__c,debt__c,Payment__c,RateWater__c,RateElectricity__c,secretKey__c 
	   							   FROM CustomUser__c];       
       
       RegistrationController registration = new RegistrationController();
      
       registration.managerPage();
       registration.save();
       registration.loginPage();

       

    
    }
}
