public  class PaymentHistoryConroller {

    public List<PaymentHistory__c> paymentHistory {get;set;}
    public List<MetersReadings__c> meterReadings {get;set;}
    public List<CustomUser__c> users {get;set;}
    Id idUrl = ApexPages.currentPage().getParameters().get('id');

    public CustomUser__c user = [SELECT Name FROM CustomUser__c WHERE Id =: idUrl];  
    String UrlToken = ApexPages.currentPage().getParameters().get('token');

    public PaymentHistoryConroller() {
        meterReadings = [SELECT Id,Name,Custom_User__c FROM MetersReadings__c WHERE Custom_User__r.Id =: idUrl];
        
        users = [SELECT Id,Name,Password__c,Token__c,IsManager__c FROM CustomUser__c WHERE Token__c =: UrlToken]; 
        
        String name = user.Name + '%';
        
        paymentHistory = [SELECT id,Name,Current__c,Previous__c,Payment__c,Region__c,Meters_Readings__c 
        FROM PaymentHistory__c WHERE Name LIKE : name];

        for(CustomUser__c us : users){
            if(us.id != idUrl){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You do not have access'));
            }
        }
    }

    public PageReference userDetailsPage(){
        PageReference page = new PageReference('/UserDetailsPage');
        for(CustomUser__c user : users){
            page.getParameters().put('id', idUrl);
            page.getParameters().put('token',user.Token__c);
            page.setRedirect(true);
        }
        
        return page;
    }

    
}