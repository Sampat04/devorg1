global class ContactBatch implements Database.Batchable<sObject>, Database.stateful 
{
    
    public String p1;
    public Integer p2;
    public String param3;
    
    public Integer n1;
    public Integer n2;
    public Boolean type;

    public ContactBatch    (String num, Integer x, Integer b){
        system.debug('const2');
    }
    
    public ContactBatch (String param1, Integer param2, String param3){
        p1=param1;
        p2=param2;
        this.param3=param3;
    }
    
    public ContactBatch (Integer num1, Integer num2, Boolean type){
        n1=num1;
        n2=num2;
        this.type=type;
    }
    
    
    public ContactBatch(List<String> stringList,Integer d){
        system.debug('const3');
    }
    
    public ContactBatch(Integer numRec){
        system.debug('const4');
    }
    public ContactBatch(){
        system.debug('parameterless constructor invoked');
        //system.debug('26 numRec : '+numRec);
    }
    
    global database.querylocator start(Database.BatchableContext BC){
        //system.debug('29 numRec : '+numRec);
        String query = 'SELECT Id,Random__c from Contact order by CreatedDate';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> conList){
        //Integer count = 0;
        for(Contact c : conlist){
            if(!String.isBlank(p1)){
                c.Description__c = p1 + ' -- ' + p2 + ' -- ' + param3;
            }
            else if(n1 != null){
                c.Description__c = n1 + ' -- ' + n2 + ' -- ' + type;
            }
        }
        update conList;
    }
    
    global void finish(Database.BatchableContext BC){
        
	}
}
/*
 global (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    }

    global void execute(Database.BatchableContext bc, List<P> records){
        // process each batch of records
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    */