public class LwcHandlerAug11 {

    @AuraEnabled
    public static List<RecordsWrapper> fetchRecords(){        
        List<Account> accList = [Select Id,Name from Account limit 5];
        List<Contact> conList = [Select Id,Name from Contact limit 5];
        
        List<RecordsWrapper> wrapList = new List<RecordsWrapper>();
        for(Account acc : accList){
            wrapList.add(new RecordsWrapper(acc.Id, acc.Name));
        }
        for(Contact con : conList){
            wrapList.add(new RecordsWrapper(con.Id, con.Name));
        }
        for(RecordsWrapper item : wrapList){
            system.debug('item = '+item);
        }
        
        return wrapList;
    }
    
    public class RecordsWrapper {
        @AuraEnabled public Id recordId {get; set;}
        @AuraEnabled public String name {get; set;}
 
        public RecordsWrapper(Id rId, String n) {
            recordId = rId;
            name = n;
        }
    }
    
    
    /*
    Develop a Lightning component to display any 10 accounts and any 10 contacts (or any other 2 objects either related or unrelated ). 
    Display both accounts and contacts in a Single table with 2 different columns for each object. 
    There should be only one aura iteration which should run over a single list returned by an Apex Method.
    */
}