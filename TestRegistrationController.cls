@isTest
private class TestRegistrationController{

	@testSetup static void setup(){

		Customuser__c customusercObj = new Customuser__c (
			Name = 'test value', 
			Password__c = 'test value', 
			PasswordConfirm__c = 'test value', 
			Email__c = 'testEmail@gmail.com', 
			Phone_number__c = '1234567890', 
			City__c = 'test value', 
			Role__c = 'test value', 
			rate__c = 1.1, 
			State__c = 'test value', 
			IsManager__c = TRUE, 
			RateWater__c = 1.1, 
			RateElectricity__c = 1.1, 
			PaymentForWater__c = 1.1, 
			PaymentForElectricity__c = 1.1, 
			secretKey__c = 'test value', 
			vector__c = 'test value'
		);
		insert customusercObj;
		 
	}

	@isTest static void testMethod1() {
		// code_block	
	}

	@isTest static void testMethod2() {
		// code_block	
	}
}