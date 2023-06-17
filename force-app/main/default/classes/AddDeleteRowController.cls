public class AddDeleteRowController {
    @AuraEnabled
    public static void saveObject(List<Custom_Object__c> ListCustomObject){
        system.debug('list = '+ListCustomObject);
        Insert ListCustomObject; 
    }
}