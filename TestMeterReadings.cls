@isTest
private class TestMeterReadings{

	@testSetup static void setup(){

		Customuser__c customusercObj = new Customuser__c (
			Name = 'test value', 
			Email__c = 'testEmail@gmail.com', 
			City__c = 'test value', 
			rate__c = 1.1, 
			State__c = 'test value'
		);
		insert customusercObj;
		 Metersreadings__c metersreadingscObj = new Metersreadings__c (
			Name = 'test value', 									
			Previous__c = 1.1, 
			Current__c = 1.1, 
			State__c = 'test value'
		);
		insert metersreadingscObj;
		 
	}

	@isTest static void testMethod1() {
		// code_block	
	}

	@isTest static void testMethod2() {
		// code_block	
	}
}