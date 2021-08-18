@isTest
public with sharing class TestPayment {
    

    @isTest
    public static void paymentTest(){

    Test.StartTest(); 
       CustomUser__c user = new CustomUser__c();
       user.Name = 'test';
       user.Password__c = 'test';
       user.IsManager__c = true;
       insert user;
       
       MetersReadings__c meterReadings = new MetersReadings__c();
       meterReadings.Name = 'test';

        ApexPages.StandardController sc = new ApexPages.StandardController(meterReadings);

        Payment payment = new Payment();
        Id idUrl = ApexPages.currentPage().getParameters().get('id');


        PageReference page = Page.PaymentPage;
        page.getParameters().put('id', idUrl);
        Test.setCurrentPage(page);
        Test.StopTest();
    }
}
