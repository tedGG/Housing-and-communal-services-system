@isTest
private class TestDoPaymentController{

	@testSetup static void setup(){

		Metersreadings__c metersreadingscObj = new Metersreadings__c (
			Name = 'test value', 
			Previous__c = 1.1, 
			Current__c = 1.1, 
			State__c = 'test value', 
			Payment__c = 1.1
		);
		insert metersreadingscObj;
		 
	}

	@isTest static void testMethod1() {
		DoPaymentController payment = new DoPaymentController();
        
        MetersReadings__c metersReadings = [SELECT Name,Previous__c,Current__c,State__c,Payment__c FROM MetersReadings__c];
        payment.doPayment();

        
	}

	
}	 	