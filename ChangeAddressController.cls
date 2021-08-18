public without sharing class ChangeAddressController {
    public CustomUser__c user;
    public List<CustomUser__c> users {get;set;}


    Id idUrl = ApexPages.currentPage().getParameters().get('id');

    public AddressWrapper addressWrapper {get;set;}

    public ChangeAddressController(){
        users = [SELECT Id,Name,City__c,State__c,debt__c FROM CustomUser__c WHERE Id =: idUrl];
        addressWrapper = new AddressWrapper();
    }
    public class AddressWrapper {
        public String city { get; set; }
        public String state { get; set; }
    }

    public Boolean hasDebts(){
        Boolean hasDebt;
        for(CustomUser__c user : users){
            if(user.Payment__c > 500){
                hasDebt = true;
            }
        }
        return hasDebt;
    }
    
    public PageReference save(){
        PageReference page;
        
       
        for(CustomUser__c u : users){
            if(u.debt__c){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You have debt'));
           }else {
            CustomUser__c user = new CustomUser__c();
            user.id = idUrl;
            user.State__c = addressWrapper.state;
            user.City__c = addressWrapper.city;
            update user;
           }
        }
        
        return null;
    }
    
}
