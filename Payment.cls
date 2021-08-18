public class Payment {
    
    public List<MetersReadings__c> listOfMeterReadings{get;set;}
    public MetersReadings__c meterReadings {get;set;}
    Id idUrl = ApexPages.currentPage().getParameters().get('id');

   
    public Payment() {
        listOfMeterReadings = [SELECT Id,Name,Previous__c,Current__c,Payment__c,State__c,Custom_User__c 
        FROM MetersReadings__c WHERE Custom_User__r.id =: idUrl LIMIT 5];

    } 
    public PageReference userDetailsPage(){
        PageReference page = new PageReference('/UserDetailsPage');
        page.getParameters().put('id', idUrl);
        page.setRedirect(true);
        
        return page;
    }
}