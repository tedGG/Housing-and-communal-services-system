@IsTest
public with sharing class TestLogin {
    @IsTest
    public static void LoginTest(){
       Test.StartTest(); 
       CustomUser__c user = new CustomUser__c();
       user.Name = 'test';
       user.Password__c = 'test';
       user.IsManager__c = true;
       insert user;
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(user);
		LoginController login = new LoginController();
        
        PageReference pageRef = Page.LoginPage; 
        pageRef.getParameters().put('id',user.Id);
        Test.setCurrentPage(pageRef);

        login.loginUser();
        login.RegistrationPage();
       
        
        login.username = 'test';
        login.password = 'test';

        Test.StopTest();
    }
    @IsTest
    public static void registrationTest(){
     
       CustomUser__c user = new CustomUser__c();
       ApexPages.StandardController controller=new ApexPages.StandardController(user);
       
       
       RegistrationController registration = new RegistrationController();
      
       registration.managerPage();
       //registration.encode();

       registration.user.Name = 'test';
       registration.save();
       
       registration.user.Password__c = 'test';
       registration.save();

       registration.user.PasswordConfirm__c = 'test';
       registration.save();

       registration.user.Email__c = 'test';
       registration.save();

       registration.user.City__c = 'test';
       registration.save();

       registration.user.State__c = 'test';
       registration.save();
    
       registration.user.IsManager__c = true;
       registration.save();

    
    }
    
}