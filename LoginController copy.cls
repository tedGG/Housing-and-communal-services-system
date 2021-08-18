public class LoginController {

    public String username {get;set;}
    public String password {get;set;}

    public List<CustomUser__c> users {get;set;}    
    public Set<Id> userIds;

    public static String secretKey = '1234567890abcdef1234567890abcdef';
    public  Blob key = Crypto.generateAesKey(256);

    public LoginController(){ 
        userIds = new Map<Id,CustomUser__c>([SELECT Id FROM CustomUser__c]).keySet();
        users = [SELECT Id,Name,Password__c,Token__c,IsManager__c,secretKey__c,vector__c FROM CustomUser__c]; 
    }
    
    public PageReference loginUser(){
        
        PageReference page;
 		
        for(CustomUser__c user : users){
            final Id constId = user.id;
            if(username == user.Name && password == user.Password__c && user.IsManager__c == false ){
               	page = new PageReference('/UserDetailsPage');
                page.getParameters().put('id', user.id);
                page.getParameters().put('token', user.Token__c);
                page.setRedirect(true);
            }
            else if(username == user.Name && password == user.Password__c && user.IsManager__c == true){
                page = new PageReference('/ManagerPage');
                page.getParameters().put('id', user.id);
                page.getParameters().put('token', user.Token__c);
                page.setRedirect(true);
                
            }else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'login or password is incorect.'));
            }

            String tokennn = user.Token__c;
            Blob keySecret = Blob.valueOf(secretKey);
            

            system.debug(user.secretKey__c);
            //system.debug(decrypt(tokennn,keySecret));
 
          }
          
        return page;
    }
    
    // public static String decrypt(String encryptedData,Blob key){

    //     Blob dest = EncodingUtil.base64Decode(encryptedData);
    //     Blob decrypted = Crypto.decryptWithManagedIv('AES256', key, dest);
    //     String decryptedText = decrypted.toString();

    //     return decryptedText;

    //   }

      public PageReference RegistrationPage(){

        PageReference pageRef = new PageReference('/RegistrationPage');
        pageRef.setRedirect(true);
        return pageRef;
    }
 
}