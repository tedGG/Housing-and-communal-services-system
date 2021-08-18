public with sharing class RegistrationController {


    public CustomUser__c user { get; private set; }
    
    String name {get;set;}
    String password {get;set;}
    public Id recordId{get;set;}

    
    public static String secretKey = '1234567890abcdef1234567890abcdef';

    public String ROLE = 'Default user';
    public Decimal RATEGAS;
    public Decimal RATEWATER;
    public Decimal RATEELECTRICITY;

    //public static Blob cryptoKey = Blob.valueOf('380db410e8b11fa9');
    String payload = '';

    public RegistrationController() {
        user = new CustomUser__c();
        
        Id id = ApexPages.currentPage().getParameters().get('id');
        user = (id == null) ? new CustomUser__c() : 
            [SELECT Name, Password__c, PasswordConfirm__c,Email__c,Phone_number__c,
            City__c,State__c,Role__c,Rate__c,IsManager__c,PaymentForElectricity__c,PaymentForWater__c,
            RateElectricity__c,RateWater__c,secretKey__c,vector__c FROM CustomUser__c WHERE Id = :id];  
           
            //decrypt();
    }

    public PageReference save() {
        recordId = Apexpages.CurrentPage().getParameters().get('id');
        payload = user.Name + user.Password__c;

        
        user.Token__c = encrypt(payload);
        system.debug(encrypt(payload));
        
        user.secretKey__c = secretKey;

        user.Role__c = ROLE;
        user.Rate__c = defineRateForGas(user.City__c);
        user.RateWater__c = defineRateForWater(user.City__c);
        user.RateElectricity__c = defineRateForElectricity(user.City__c);
        
        insert user;

        PageReference page;

        if(user.IsManager__c){
            page = new PageReference('/ManagerPage');
            page.getParameters().put('id', user.id);
            page.setRedirect(true);
        }else{
            page = new PageReference('/UserDetailsPage');
            page.getParameters().put('id', user.id);
            page.setRedirect(true);
        } 
        return page;
    
    }
    public Decimal defineRateForGas(String city){
        switch on city {
            when 'Lviv' {		
                RATEGAS = 2.16;
            }
            when 'Kyiv' {		
                RATEGAS = 2.50;
            }
            when 'Dnipro' {
                RATEGAS = 2.34;
            }
            when 'Kharkiv' {		 
                RATEGAS = 2.23;
            }
        }
        return RATEGAS;
    }

    public Decimal defineRateForWater(String city){
        switch on city {
            when 'Lviv' {		
                RATEWATER = 8.68;
            }
            when 'Kyiv' {		
                RATEWATER = 8.78;
            }
            when 'Dnipro' {
                RATEWATER = 8.55;
            }
            when 'Kharkiv' {		 
                RATEWATER = 8.61;
            }
        }
        return RATEWATER;
    }
    public Decimal defineRateForElectricity(String city){
        switch on city {
            when 'Lviv' {		
                RATEELECTRICITY = 1.68;
            }
            when 'Kyiv' {		
                RATEELECTRICITY = 2.78;
            }
            when 'Dnipro' {
                RATEELECTRICITY = 1.55;
            }
            when 'Kharkiv' {		 
                RATEELECTRICITY = 2.61;
            }
        }
        return RATEELECTRICITY;
    }
    
    public PageReference managerPage(){

        PageReference page = new PageReference('/ManagerPage');
        page.getParameters().put('id', user.id);
        page.setRedirect(true);
        return page;
    }
     
    public PageReference loginPage(){

        PageReference page = new PageReference('/LoginPage');
        page.setRedirect(true);
        return page;
    }

    public static String encrypt(String valueToEncrypt){
        
        Blob key = Blob.valueOf(secretKey); 
        
        Blob source = Blob.valueOf(valueToEncrypt);
        Blob encrypted = Crypto.encryptWithManagedIV('AES256', key, source);
        String encrypted64 = EncodingUtil.base64Encode(encrypted); 
        return encrypted64;
      }
    
     
}