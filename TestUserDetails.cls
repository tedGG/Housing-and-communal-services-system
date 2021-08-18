@isTest
public with sharing class TestUserDetails {
  
    @isTest
    public static void testUserDetails(){

        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.Rate__c = 1.68;
        user.State__c = 'test';
        user.Email__c = 'nazar055@gmail.com';
        user.debt__c = false;
        user.RateElectricity__c = 1.44;
        user.RateWater__c = 1.54;

        insert user;

        Decimal currentValue = 350;
        Decimal previousValue = 300;
        Decimal calculateValue = currentValue - previousValue * 1.68;

        
        Test.StartTest(); 
        UserDetailsController userDetails = new UserDetailsController();


        PageReference pageRef = Page.UserDetailsPage; 
        pageRef.getParameters().put('id',user.Id);
        Test.setCurrentPage(pageRef);

        userDetails.putMeterReadings();
    
        Test.StopTest();
    }

    @isTest
    public static void testCreateMeterReadingsForGas(){
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.Rate__c = 1.68;
        user.State__c = 'test';
        user.Email__c = 'nazar055@gmail.com';
        user.debt__c = false;
        user.RateElectricity__c = 1.44;
        user.RateWater__c = 1.54;

        insert user;
        MetersReadings__c meterReadings = new MetersReadings__c();
        meterReadings.Name = 'test';
        insert meterReadings;

        UserDetailsController userDetails = new UserDetailsController();

        PageReference pageRef = Page.UserDetailsPage; 
        pageRef.getParameters().put('id',user.Id);
        Test.setCurrentPage(pageRef);

        userDetails.createMeterReadingsForGas(200,300,178);

    }
}
