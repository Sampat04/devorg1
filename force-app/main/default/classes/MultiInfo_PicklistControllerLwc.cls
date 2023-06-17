public with sharing class MultiInfo_PicklistControllerLwc {
    
    @AuraEnabled(cacheable=true)
    public static List<SObject> getObjs(String sObjName) {
        String query = 'SELECT Id, Name FROM '+ sObjName +' ORDER BY Name';
        List<SObject> objs = Database.query(query);
        System.debug('in method objs='+objs);
        return objs;
    }

    @AuraEnabled(cacheable=true)
    public static String getSObjectLabel(String sObjName) {
        String label = Schema.getGlobalDescribe().get(sObjName).getDescribe().getLabel();
        System.debug('in method labels='+label);
        return label;
    }
}