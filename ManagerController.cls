public class ManagerController {

    public List<CustomUser__c> users {get;set;}
    Id idUrl = ApexPages.currentPage().getParameters().get('id');
    public List<CustomUser__c> rate {get;set;}

    public List<MetersReadings__c> userPayment {get;set;}

    public List<CustomUser__c> managerRegion {get;set;}

    public ManagerController() {
        //String managerRegion = 'Lvivska';
        managerRegion = [SELECT State__c FROM CustomUser__c WHERE Id =: idUrl];


        for(CustomUser__c user : managerRegion){

        String managerR = user.State__c;

            users = [SELECT Id,Name,City__c,State__c,debt__c,IsManager__c 
            FROM CustomUser__c WHERE IsManager__c = false AND State__c = :managerR];

            rate = [SELECT Id,State__c,rate__c FROM CustomUser__c WHERE State__c = :managerR];

            userPayment = [SELECT Id,Name,Payment__c,State__c FROM MetersReadings__c WHERE State__c =:managerR];
 
        }    
    }

    public PageReference loginPage(){

        PageReference page = new PageReference('/LoginPage');
        page.setRedirect(true);
        return page;
    }
   
}
