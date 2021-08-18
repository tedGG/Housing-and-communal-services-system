@isTest
public with sharing class ChangeTest {
    
    @isTest
    public static void changeAdressTest(){
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.State__c = 'test';
        user.debt__c = true;
        insert user;

        Test.StartTest();
        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        ChangeAddressController changeAddress = new ChangeAddressController();
    
        changeAddress.save();   

        PageReference prf = changeAddress.save();
        System.assertEquals(null, prf); //assertion
        Test.StopTest();
    }

    @isTest
    public static void changePaymentTest(){
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.State__c = 'test';
        user.Payment__c = 168;
        insert user;

        Test.StartTest();
        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        ChangePayment changePayment = new ChangePayment();
        changePayment.updatePayment();

        PageReference prf = changePayment.updatePayment();
        System.assertEquals(null, prf); //assertion
        Test.StopTest();
    }
    
    @isTest
    public static void changeRateTest(){
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.State__c = 'test';
        user.rate__c = 1.68;
        insert user;

        Test.StartTest();
        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        ChangeRate changeRate = new ChangeRate();
        changeRate.changeRate();

        PageReference prf = changeRate.changeRate();
        System.assertEquals(null, prf); //assertion
        Test.StopTest();
    }
}
