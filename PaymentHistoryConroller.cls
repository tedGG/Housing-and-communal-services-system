public  class PaymentHistoryConroller {

    
    public List<PaymentHistory__c> paymentHistory {get;set;}
    
    public List<MetersReadings__c> meterReadings {get;set;}

    Id idUrl = ApexPages.currentPage().getParameters().get('id');
    public CustomUser__c user;
    List<String> nameUser;


    public PaymentHistoryConroller() {
        meterReadings = [SELECT Id,Name,Custom_User__c FROM MetersReadings__c WHERE Custom_User__r.Id =: idUrl];
        CustomUser__c user = [SELECT Name FROM CustomUser__c WHERE Id =: idUrl];
        
        String name = user.Name + '%';
        
        paymentHistory = [SELECT id,Name,Current__c,Previous__c,Payment__c,Region__c,Meters_Readings__c 
        FROM PaymentHistory__c WHERE Name LIKE : name];
    }
    
}