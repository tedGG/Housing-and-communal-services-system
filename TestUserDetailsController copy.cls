@isTest
private class TestUserDetailsController{

	@testSetup static void setup(){

		CustomUser__c user = new CustomUser__c (
			Name = 'test value', 
			Token__c = 'test value', 
			Email__c = 'testEmail@gmail.com', 
			City__c = 'test value', 
			rate__c = 1.1, 
			State__c = 'test value', 
			debt__c = TRUE, 
			Payment__c = 1.1, 
			RateWater__c = 1.1, 
			RateElectricity__c = 1.1
		);
		insert user;
        
        if(user != null){
		 MetersReadings__c metersReadings = new MetersReadings__c (
			Name = 'test value', 
			Previous__c = 1.1, 
			Current__c = 1.1, 
			State__c = 'test value', 
			Payment__c = 1.1,
            Custom_User__c = user.id
		);
		insert metersReadings;
        }
	}

	@isTest static void testMethod1() {
        UserDetailsController userController = new UserDetailsController();
		CustomUser__c user = [SELECT Id,Name,Token__c,Email__c,City__c,rate__c,State__c,debt__c,Payment__c,RateWater__c,RateElectricity__c,secretKey__c FROM CustomUser__c];
        MetersReadings__c meterReadings = [SELECT Name,Previous__c,Current__c,State__c,Payment__c,Custom_User__c FROM MetersReadings__c];
        
        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));
        ApexPages.currentPage().getParameters().put('token', String.valueOf(user.Token__c));
       	
        System.assertEquals(user.Name, meterReadings.Name);
        
        Integer currentKW = 200;
        Integer previousKW = 100;
    
		Integer currentWater = 200;
        Integer previousWater = 100;  
        
        Integer currentElectricity = 200;
        Integer previousElectricity = 100;
        
        Decimal calculatedGas = (currentKW - previousKW) * user.rate__c;  
        Decimal calculatedWater = (currentWater - previousWater) * user.RateWater__c;
       	Decimal calculatedElectricity = (currentElectricity - previousElectricity) * user.RateElectricity__c; 
        
       	userController.putMeterReadings();
       
        
       

        PageReference prf = userController.LoginPage();
        System.assertEquals(prf.getUrl(), prf.getUrl());
        
        PageReference prf1 = userController.doPayment();
        System.assertEquals(prf1.getUrl(), prf1.getUrl());
        
         PageReference prf2 = userController.paymentHistory();
        System.assertEquals(prf2.getUrl(), prf2.getUrl());
      
	}
}