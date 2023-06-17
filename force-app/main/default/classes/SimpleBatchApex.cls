public with sharing class SimpleBatchApex implements Database.Batchable<Id>
{
    public Iterable<Id> start(Database.BatchableContext BC)
    {
        return new List<Id>{'0Q07F000000kldgSAA','0067F000007tvruQAA'};
    }
 
    public void execute(Database.BatchableContext info, List<Id> idList)
    {	
		Id id = idList[0];
        Schema.sObjectType objType = id.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        System.debug(objDescribe.getName());
    }
 
    public void finish(Database.BatchableContext info) { }
    
    /*
    public class psfWrapper{
        Account acc{ get; set;}
        List<Contact> conlist{ get; set;}
        List<Doctor__c> doclist{ get; set;}
        
        public psfWrapper() {

        }
        
        public psfWrapper(Account a,List<Contact> clist,List<Doctor__c> dlist) {
            acc = a;
            conlist = clist;
            doclist = dlist;
        }
	}*/
}
 
// Process the String's one by one each with its own governor context
//Id jobId = Database.executeBatch(new SimpleBatchApe(), 1);