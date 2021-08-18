@isTest
private class TestUserDetailsController{

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
		 MetersReadings__c metersreadingscObj = new MetersReadings__c (
			Name = 'test value', 
			Previous__c = 1.1, 
			Current__c = 1.1, 
			State__c = 'test value', 
			Payment__c = 1.1,
			Custom_User__c = customusercObj.id
		);
		insert metersreadingscObj;
		 
	}

	@isTest static void testMethod1() {
		List<CustomUser__c> user = [SELECT Name,Token__c,Email__c,City__c,rate__c,State__c,debt__c,Payment__c,RateWater__c,RateElectricity__c,secretKey__c FROM CustomUser__c];
		UserDetailsController userDetails = new UserDetailsController();
		List<MetersReadings__c> meterReadings = [SELECT Name,Previous__c,Current__c,State__c,Payment__c,Custom_User__c FROM MetersReadings__c];
		Decimal current = 200;
		Decimal previous = 150;
		Decimal calculated = 320;
		
		
	}

	
}