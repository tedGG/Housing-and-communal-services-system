public class Payment {
    
    public List<CustomUser__c> users {get;set;}
    public List<MetersReadings__c> listOfMeterReadings{get;set;}
   

    Id idUrl = ApexPages.currentPage().getParameters().get('id');
    String UrlToken = ApexPages.currentPage().getParameters().get('token');

   
    public Payment() {
        listOfMeterReadings = [SELECT Id,Name,Previous__c,Current__c,Payment__c,State__c,Custom_User__c 
        FROM MetersReadings__c WHERE Custom_User__r.id =: idUrl LIMIT 5];

        users = [SELECT Id,Name,Password__c,Token__c,IsManager__c FROM CustomUser__c WHERE Token__c =: UrlToken]; 
    
        for(CustomUser__c us : users){
            if(us.id != idUrl){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You do not have access'));
            }
        }
    } 

    public PageReference userDetailsPage(){
        PageReference page = new PageReference('/UserDetailsPage');
        for(CustomUser__c user : users){
            page.getParameters().put('id', user.id);
            page.getParameters().put('token', user.Token__c);
            page.setRedirect(true);
        }
        return page;
    }
}