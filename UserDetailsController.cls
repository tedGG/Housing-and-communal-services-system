public without sharing class UserDetailsController {

    public List<CustomUser__c> users {get;set;}
    public String constId =  ApexPages.currentPage().getParameters().get('id');
    public CustomUser__c user{get;set;}

    public List<CustomUser__c> listRate;
    public List<MetersReadings__c> meterReadings{get;set;}
    public Integer currentKW {get;set;}
    public Integer previousKW {get;set;}
    public Decimal calculatedGas {get;set;}
    

    public Integer currentWater {get;set;}
    public Integer previousWater {get;set;}
    public Decimal calculatedWater {get;set;}

    public Integer currentElectricity {get;set;}
    public Integer previousElectricity {get;set;}
    public Decimal calculatedElectricity {get;set;}

    String UrlToken = ApexPages.currentPage().getParameters().get('token');
    Id idUrl = ApexPages.currentPage().getParameters().get('id');

    public UserDetailsController() {
        
        users = [SELECT Id,Name,City__c,rate__c,State__c,Email__c,debt__c,Payment__c,RateElectricity__c,
        RateWater__c,secretKey__c,Token__c FROM CustomUser__c WHERE Token__c =: UrlToken];

        for(CustomUser__c us : users){
            if(us.id != idUrl){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You do not have access'));
            }
        }

        meterReadings = [SELECT Id,Name,State__c,Previous__c,Payment__c,Current__c,Custom_User__c
        FROM MetersReadings__c WHERE Custom_User__r.id =: idUrl];
        
    }

    
    public PageReference putMeterReadings(){

        PageReference page;
        
        if(currentKW < previousKW){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Current Kw must be greater than previuos'));
        }else {
            for(CustomUser__c user : users){
                calculatedGas = (currentKW - previousKW) * user.rate__c;  
                calculatedWater = (currentWater - previousWater) * user.RateWater__c;
                calculatedElectricity = (currentElectricity - previousElectricity) * user.RateElectricity__c; 
                
                page = new PageReference('/UserDetailsPage');
                page.getParameters().put('id', user.id);
                page.getParameters().put('token', user.Token__c);
                page.setRedirect(true);
            }

            createMeterReadingsForGas(currentKW,previousKW,calculatedGas);
            createMeterReadginsForWater(currentWater,previousWater,calculatedWater);
            createMeterReadginsForElectricity(currentElectricity,previousElectricity,calculatedElectricity);
        } 
        
        


        return page;
    }

    public void createMeterReadginsForWater(Decimal currentValue,Decimal previousValue, Decimal calculated){
        PageReference page;
        MetersReadings__c meterReadings = new MetersReadings__c();

        for(CustomUser__c u : users){
            if(meterReadings.Name != u.Name){
            meterReadings.Name = u.Name + ' Meter readings water';
           	meterReadings.State__c = u.State__c;
            meterReadings.Current__c = currentValue;
            meterReadings.Previous__c = previousValue;
            meterReadings.Payment__c = calculated;
            meterReadings.Custom_User__c = u.Id;
            }
        }
        insert meterReadings; 
    }

    public void createMeterReadginsForElectricity(Decimal currentValue,Decimal previousValue, Decimal calculated){
        PageReference page;
        MetersReadings__c meterReadings = new MetersReadings__c();

        for(CustomUser__c u : users){
            if(meterReadings.Name != u.Name){
            meterReadings.Name = u.Name + ' Meter readings for electricity';
           	meterReadings.State__c = u.State__c;
            meterReadings.Current__c = currentValue;
            meterReadings.Previous__c = previousValue;
            meterReadings.Payment__c = calculated;
            meterReadings.Custom_User__c = u.Id;
            }
        }
        insert meterReadings; 
    }
    public void createMeterReadingsForGas(Decimal currentValue,Decimal previousValue, Decimal calculated){

        PageReference page;
        MetersReadings__c meterReadings = new MetersReadings__c();

        for(CustomUser__c u : users){
            if(meterReadings.Name != u.Name){
            meterReadings.Name = u.Name + ' Meter readings for gas';
           	meterReadings.State__c = u.State__c;
            meterReadings.Current__c = currentValue;
            meterReadings.Previous__c = previousValue;
            meterReadings.Payment__c = calculated;
            meterReadings.Custom_User__c = u.Id;
            }
        }
        insert meterReadings; 
    }

    public PageReference paymentHistory(){
        PageReference page = new PageReference('/PaymentHistory');

        for(CustomUser__c user : users){
            page.getParameters().put('id', user.id);
            page.getParameters().put('token', user.Token__c);
            page.setRedirect(true);
        }
        return page;
    }
    public PageReference doPayment(){
        PageReference page = new PageReference('/PaymentPage');
        
        for(CustomUser__c user : users){
            page.getParameters().put('id', user.id);
            page.getParameters().put('token', UrlToken);
            page.setRedirect(true);
        }
        return page;
    }
    public PageReference LoginPage(){
        PageReference pageRef = new PageReference('/LoginPage');
        pageRef.setRedirect(true);
        return pageRef;
    }
       
}
