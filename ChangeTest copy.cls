@isTest
public with sharing class ChangeTest {

    @testSetup static void setup(){

		CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.City__c = 'test';
        user.State__c = 'test';
        user.debt__c = false;
        user.Payment__c = 168;
        user.rate__c = 1.68;
		Insert user;
		 
	}
    
    @isTest
    public static void changeAdressTest(){
        CustomUser__c user = [SELECT Name,City__c,State__c,debt__c FROM CustomUser__c];

        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        ChangeAddressController changeAddress = new ChangeAddressController();
        changeAddress.save();   
		
        PageReference prf = changeAddress.save();
        System.assertEquals(null,prf);
      
    }

    @isTest
    public static void changePaymentTest(){
        CustomUser__c user = [SELECT Name,City__c,State__c,Payment__c FROM CustomUser__c];

        
        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        ChangePayment changePayment = new ChangePayment();
        changePayment.updatePayment();

        PageReference prf = changePayment.updatePayment();
        System.assertEquals(null, prf);
    
    }
    
    @isTest
    public static void changeRateTest(){
       

        CustomUser__c user = [SELECT Name,City__c,State__c,rate__c FROM CustomUser__c];

        ApexPages.currentPage().getParameters().put('id', String.valueOf(user.Id));

        ChangeRate changeRate = new ChangeRate();
        changeRate.changeRate();

        PageReference prf = changeRate.changeRate();
        System.assertEquals(null, prf);

    }
}