public with sharing class MeterReadings {
    
    //public MetersReadings__c metersReadingsList;
    public List<CustomUser__c> listRate;

    public List<CustomUser__c> users {get;set;}

    public Decimal finalValue;
    public List<MetersReadings__c> metersReadingsList;
    Id idUrl = ApexPages.currentPage().getParameters().get('id');

    public MeterReadings() {
        
        listRate = [SELECT Id,rate__c FROM CustomUser__c];
        users = [SELECT Id,Name,City__c,rate__c,State__c,Email__c,
                 (SELECT Id,Name,State__c FROM Meters_Readings__r) FROM CustomUser__c WHERE Id =: idUrl];
        
        metersReadingsList = [SELECT Id,Name,State__c,Previous__c,Current__c,Custom_User__c
                              FROM MetersReadings__c WHERE Custom_User__r.id =: idUrl];
    }

    public Decimal calculatePayment(Decimal currentKW, Decimal previousKW){
        
        for(CustomUser__c u : listRate){
            system.debug(u.rate__c);
            finalValue = (currentKW - previousKW) * u.Rate__c;
            system.System.debug(currentKW + ' '+ previousKW + ' ' + u.rate__c);
        }
        return finalValue;
    }

    
    // public void createPaymentForMeterReadings(Decimal finalPayment){
        	
    //     Payment__c payment = new Payment__c();
    //     for(MetersReadings__c m : metersReadingsList){
    //         payment.Name = m.Name;
    //         payment.Meters_Readings__c = m.id;
    //         payment.FinalPayment__c = finalPayment;
    //     }
    //     insert payment;
    // }
}