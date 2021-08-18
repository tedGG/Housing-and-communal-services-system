public without sharing class ChangePayment {

    public CustomUser__c user;
    public List<CustomUser__c> users {get;set;}

    public Id idUrl = ApexPages.currentPage().getParameters().get('id');

    public ChangePaymentWrapper changePaymentWrapper {get;set;}

    public ChangePayment(){
        users = [SELECT Id,Name,City__c,State__c,Payment__c FROM CustomUser__c WHERE Id =: idUrl];
        changePaymentWrapper = new ChangePaymentWrapper();
    }
    public class ChangePaymentWrapper {
        public Decimal payment { get; set; }
    }
    
    public PageReference updatePayment(){
        PageReference page;
         
        for(CustomUser__c us : users){
            CustomUser__c user = new CustomUser__c();
            us.id = user.Id;
            user.Payment__c = changePaymentWrapper.payment;
            update user;
        }
        
        
        return null;
    }
    
}
