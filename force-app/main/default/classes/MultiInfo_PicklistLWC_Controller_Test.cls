@isTest
private class MultiInfo_PicklistLWC_Controller_Test {
    
	@isTest static void testLabel() {
        String label = MultiInfo_PicklistControllerLwc.getSObjectLabel('Account');
        System.assertEquals('Account',label);
    }
    @isTest static void testObjs() {
        Account accounts = new Account(Name='abcd');
        insert accounts;
        Test.startTest();
        MultiInfo_PicklistControllerLwc.getObjs('Account');
        Test.stopTest();
        Account acc = [select Name from Account LIMIT 1];
        system.assertEquals('abcd', acc.Name);
    }
}