public class UpdateAccountBatch implements Database.Batchable<sObject>{
    string tempStr;
    
    public UpdateAccountBatch (){
        //Do nothing;
    }
    
    public UpdateAccountBatch (String strToRemove){
        this.tempStr=strToRemove;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        String query ='';
        
        if (string.isNotBlank(tempStr)){
            query = 'SELECT Id, Name FROM Account Where Name = \''+ tempStr +'\'';
        }else{
            query = 'SELECT Id, Name FROM Account order by CreatedDate Desc limit 2';
        }
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Account> accList) {
        
        // process each batch of records default size is 200
        for(Account acc : accList) {
            // Update the Account Name 
            acc.Name = acc.Name + '_SPCTest';
        }
        try {
            // Update the Account Record
            update accList;
            
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}