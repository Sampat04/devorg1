// All test methods in this class can access all data.
@isTest(SeeAllData=true)
public class TestDataAccessClass {

    // This test accesses an existing account. 
    // It also creates and accesses a new test account.
    static testmethod void myTestMethod1() {
        // Query an existing account in the organization. 
        Account a = [SELECT Id, Name FROM Account WHERE Name='hdfc' LIMIT 1];
        System.assert(a != null);
        
        // Create a test account based on the queried account.
        Account testAccount = a.clone();
        testAccount.Name = 'Acme Test';
        insert testAccount;
        
        // Query the test account that was inserted.
        Account testAccount2 = [SELECT Id, Name FROM Account 
                                WHERE Name='Acme Test' LIMIT 1];
        System.assert(testAccount2 != null);
    }
       
    
    // Like the previous method, this test method can also access all data
    // because the containing class is annotated with @isTest(SeeAllData=true).
    @isTest static void myTestMethod2() {
        // Can access all data in the organization.
   }
  
}