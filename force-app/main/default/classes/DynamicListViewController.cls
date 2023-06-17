public with sharing class DynamicListViewController {
    public DynamicListViewController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<ListViewWrapper> fetchListViews(String strObjName, String strListViews, Boolean loadAllListViews) {
        List<ListViewWrapper> listviews = new List<ListViewWrapper>();
        if(String.isNotBlank(strObjName)) { 
            String strQuery = 'SELECT Name, DeveloperName FROM ListView WHERE SobjectType = \'' + strObjName + '\'';
            if(String.isNotBlank(strListViews)){
                String inClause = '(';
                for(String str : strListViews.split(',')) {
                    inClause += ',\'' + str + '\'';
                }
                inClause += ')';
                if(loadAllListViews)
                    strQuery += ' ORDER BY DeveloperName';
                else
                	strQuery += ' AND DeveloperName IN ' + inClause.replaceFirst(',', '') + ' ORDER BY DeveloperName';
            }
            Boolean isDistributor = false;
            List<User> lstUser = [SELECT AccountId FROM User WHERE Id =: UserInfo.getUserId()];
            if(lstUser[0].AccountId != null) {
                List<Account> lstAcc = [SELECT Type FROM Account WHERE Id =: lstUser[0].AccountId AND Type = 'Distributor Partner'];    
                isDistributor = lstAcc.isEmpty() ? false : true;
            }
            for(ListView view : Database.query(strQuery)) {
                if(strObjName.equalsIgnoreCase('Partner_Business_Plan__c') && !isDistributor 
                   && !view.DeveloperName.equalsIgnoreCase('Reseller_Business_Plans'))
                    listviews.add(new ListViewWrapper(view.Name, view.DeveloperName));
                else if(!strObjName.equalsIgnoreCase('Partner_Business_Plan__c') 
                        || (isDistributor && strObjName.equalsIgnoreCase('Partner_Business_Plan__c')))
                    listviews.add(new ListViewWrapper(view.Name, view.DeveloperName));
            }
        }   
        return listviews;
    }
    /* End */
    
    /* Start class - ListViewWrapper */
    public class ListViewWrapper {
        @AuraEnabled public String label	{get;set;}
        @AuraEnabled public String value	{get;set;}
        public ListViewWrapper(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }
    /* End class - ListViewWrapper */
}