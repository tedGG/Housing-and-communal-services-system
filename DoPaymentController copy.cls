public class DoPaymentController {

    public Decimal finalSum;
    public Id idUrl = ApexPages.currentPage().getParameters().get('id');
    public String selectedTypePayment {get;set;}

    List<selectOption> options = new List<selectoption>();
    public List<MetersReadings__c> meterReadings {get;set;}
  

    public DoPaymentController() { 
        meterReadings = [SELECT Id,Name,Previous__c,Current__c,Payment__c,State__c
                        FROM MetersReadings__c
                        WHERE Id =: idUrl];
    }

    public List<selectOption> getListOptions(){

        List<SelectOption> paymentOptions = new List<SelectOption>();
        paymentOptions.add(new SelectOption('Monthly','Mothly payment'));
        paymentOptions.add(new SelectOption('Partial','Partial payment'));
        
        return paymentOptions;

    }

    public PageReference doPayment(){
        PaymentHistory__c paymentHistory = new PaymentHistory__c();
        
        for(MetersReadings__c meterReadings : meterReadings){ 
                if(selectedTypePayment == 'Partial'){
                    finalSum = meterReadings.Payment__c / 2;
                    paymentHistory.Current__c = meterReadings.Current__c;
                    paymentHistory.Previous__c = meterReadings.Previous__c;
                    paymentHistory.Region__c = meterReadings.State__c;
                    paymentHistory.Meters_Readings__c = meterReadings.id;
                    paymentHistory.Name = meterReadings.Name;
                    paymentHistory.Payment__c = finalSum;    
                }else{
                    paymentHistory.Meters_Readings__c = meterReadings.id;
                    paymentHistory.Current__c = meterReadings.Current__c;
                    paymentHistory.Previous__c = meterReadings.Previous__c;
                    paymentHistory.Region__c = meterReadings.State__c;
                    paymentHistory.Name = meterReadings.Name;
                    paymentHistory.Payment__c= meterReadings.Payment__c;
                }
            
        }
        insert paymentHistory;
       return null;
    }

}
