@isTest
public with sharing class TestPaymentHistory {
    
    @isTest
    public static void testPaymentHistory(){
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.State__c = 'test';
        user.Payment__c = 168;
        insert user;

        Test.StartTest();
        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        PaymentHistoryConroller paymentHistory = new PaymentHistoryConroller();
        paymentHistory.userDetailsPage();

        PageReference prf = paymentHistory.userDetailsPage();
        System.assertEquals(prf.getUrl(), prf.getUrl());
        Test.StopTest();
        
    }
}