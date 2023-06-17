public class LwcHandler {

    @AuraEnabled
    public static List<Contact> getContacts(Id accountId){
        List<Contact> conlist = [Select Id,Name from Contact where AccountId =: accountId];
        return conlist;
    }
    
    @AuraEnabled
    public static List<Contact> getContactsList(String str){
        String searchStr = '%'+str+'%';
        List<Contact> conlist = [Select Id,Name from Contact where name like :searchStr LIMIT 5];
        return conlist;
    }
}