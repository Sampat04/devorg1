public with sharing class CreateContactRecord {

    @AuraEnabled
    public static void createRecord (Contact contact){
        
        try{
 //           System.debug('CreateCandidateRecord::createRecord::candidate'+contact);
            
            if(contact != null){
                system.debug('1st = '+contact);
                insert contact;
                system.debug('2nd = '+contact);
            }
            
        } catch (Exception ex){
            
            system.debug('errorrrrrrr');
            
        }
        
    }    
}