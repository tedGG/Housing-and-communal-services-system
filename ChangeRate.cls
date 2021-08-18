public without sharing class ChangeRate {
    public CustomUser__c user;
    public List<CustomUser__c> users {get;set;}


    Id idUrl = ApexPages.currentPage().getParameters().get('id');

    public RateWrapper rateWrapper {get;set;}

    public ChangeRate(){
        users = [SELECT Id,Name,City__c,State__c,rate__c FROM CustomUser__c WHERE Id =: idUrl];
        rateWrapper = new RateWrapper();
    }
    public class RateWrapper {
        public Decimal rate { get; set; }
    }

    public PageReference changeRate(){
        PageReference page;
        
            CustomUser__c user = new CustomUser__c();
            user.id = idUrl;
            user.rate__c = rateWrapper.rate;
            
            update user;
           
        
        return null;
    }
    
}
