@IsTest
public with sharing class TestLogin {

    @testSetup static void setup() {
        CustomUser__c user = new CustomUser__c();
        user.Name = 'test';
        user.Password__c = 'test';
        user.IsManager__c = true;
     
        insert user;
    }

    @IsTest
    public static void LoginTest(){
   
        CustomUser__c user = [SELECT Name,Password__c,IsManager__c FROM CustomUser__c];
        ApexPages.StandardController sc = new ApexPages.StandardController(user);
		LoginController login = new LoginController();
        
        PageReference pageRef = Page.LoginPage; 
        pageRef.getParameters().put('id',user.Id);
        Test.setCurrentPage(pageRef);

        login.loginUser();
        login.RegistrationPage();
       
        
        login.username = 'test';
        login.password = 'test';

    }
    
    
}