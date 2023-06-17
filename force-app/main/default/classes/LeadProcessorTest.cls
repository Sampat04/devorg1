@isTest
public class LeadProcessorTest {
    @testSetup 
    static void setup() {
        
        List<Lead> leadlist = new List<lead>();
        
        for (Integer i=0;i<200;i++) {
            leadlist.add(new lead(lastname='Lead '+i,Company='New York'));
        }
        insert leadlist;
        
    }
    
    static testmethod void test() {      
        
        Test.startTest();
        LeadProcessor ull = new LeadProcessor();
        Id batchId = Database.executeBatch(ull);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from lead where LeadSource = 'Dreamforce']);
        
        
    }
    
}