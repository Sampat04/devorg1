public with sharing class inlineEditCtrl {
  
    @AuraEnabled        
    public static List<country__c> fetchCountries(){
        List<country__c> CountriesList = [select id,name from country__c order by name];
        return CountriesList;
    }
    
    @AuraEnabled
    public static List < State__c > fetchStates(List<String> CountriesListinFunction) {
        
        List < State__c > returnList = new List < State__c > ();
        List < State__c > lstOfStates = [select id, Name, CountryName__c, Population__c, Area__c from State__c 
                                          where CountryName__c in : CountriesListinFunction order by CountryName__c];
        
        for (State__c sta: lstOfStates) {
            returnList.add(sta);
        }
        return returnList;
    }
    
  // method for update records after inline editing  
    @AuraEnabled
    public static List < State__c > saveState(List<State__c> lstOfStates) {
        update lstOfStates;
        return lstOfStates;
    }
    
}