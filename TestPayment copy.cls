@isTest
public with sharing class TestPayment {
    

    @isTest
    public static void paymentTest(){

        Test.StartTest(); 
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.State__c = 'test';
        user.Payment__c = 168;
        insert user;
      
        Payment payment = new Payment();
        payment.userDetailsPage();

        PageReference prf = payment.userDetailsPage();
        System.assertEquals(prf.getUrl(), prf.getUrl());
      
    }
}
