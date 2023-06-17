@isTest()
public class A8Test {
	@isTest()
    static void debugger()
    {
        Missing_Timecard__c t=new Missing_Timecard__c();
        t.Hrs_Missed__c=7;
        system.debug(t);
//        t.Name = 'qwe';
//        t.Date__c = system.today();
        
        insert t;
        
        assignment8 x = new assignment8();
        Database.executeBatch(x);
    }
    
}