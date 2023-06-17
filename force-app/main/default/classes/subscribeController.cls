public class subscribeController {
    
    @AuraEnabled        
    public static void createPotentialSubscriber(String firstname, String lastname, String email){
        
        Lead l = new lead();
        l.FirstName = firstname;
        l.LastName = lastname;
        l.Email = email;
        l.Company = 'Dummy'; //required field on lead
		//l.Random__c = RANDOM NUMBER GENERATED;
        
        upsert l;
        
    }
    
    @AuraEnabled
    public static void createSubscriber(String firstname, String lastname, String email, String OTP) {
        
        List<Lead> l = [select name,email,random__c from lead where email=:email];

        if(l[0].Random__c == OTP)
        {
            Contact c = new contact();
            c.FirstName = firstname;
            c.LastName = lastname;
            c.Email = email;
            c.isSubscriber__c = true;

            upsert c;
            
        }            
    }
    
    
    @AuraEnabled
    public static void unSubscribeMember(String email, String OTP) {
        
        List<Contact> c = [select name,email,random__c from contact where email=:email];
      
        if(c[0].Random__c == OTP)
        {
            
            c[0].isSubscriber__c = false;           
            update c[0];
            
        }            
    }
    
}