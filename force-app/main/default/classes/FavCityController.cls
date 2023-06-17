public class FavCityController {
    
    @AuraEnabled        
    public static List<country__c> getPickListValuesIntoList(){
        List<country__c> CountriesList = [select id,name from country__c order by name];
        
        system.debug('countries : '+CountriesList);
        return CountriesList;
    }
    
    @AuraEnabled 
    public static List<state__c> getStateValuesintoList(List<String> CountriesListinFunction){
        
        system.debug('entered 2nd function');
        
        List<country__c> countriesid = [select id from country__c where name in : CountriesListinFunction];      
        List<state__c> StatesList = [select id,Country__c,name,population__c,area__c,CountryName__c
                                                      from state__c where Country__c in : countriesid
                                                     order by Country__c];
        
        system.debug('stateslist = '+StatesList);
        
        return StatesList;
    }
    
    @AuraEnabled 
    public static void CreateRecord(List<String> CitiesListinFunction){
        
        system.debug('entered create record');
        String user_name = UserInfo.getName();
        system.debug('name = '+user_name);
        String Fav_cities = '';
           system.debug('reacehed1'); 
        
        integer length = CitiesListinFunction.size();
        integer counter=0;
        
        String[] splitCity = new String[50];
        for(String a : CitiesListinFunction)
        {
            splitCity = a.split('\\(');
            
            if(counter!=length-1) Fav_cities = Fav_cities + splitCity[0]+';';           
            else Fav_cities = Fav_cities + splitCity[0];
                
            counter++;
        }
            system.debug('reacehed2'); 
        Person__c p = new Person__c();
        system.debug('reacehed3'); 
        p.name = user_name;
        system.debug('reacehed4'); 
        p.FavouriteCities__c = Fav_cities;
        system.debug('reacehed5'); 
        Insert p;
        system.debug('reacehed6'); 
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @AuraEnabled
    public static DataTableResponse getAccRecords(String strObjectName, String strFieldSetName){                
       	
        
        system.debug('entered getaccrecords');
        //Get the fields from FieldSet
        Schema.SObjectType SObjectTypeObj = Schema.getGlobalDescribe().get(strObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();            
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(strFieldSetName);
        
        //To hold the table hearders 
        List<DataTableColumns> lstDataColumns = new List<DataTableColumns>();
        
        //Field to be queried - fetched from fieldset
        List<String> lstFieldsToQuery = new List<String>();
        
        //The final wrapper response to return to component
        DataTableResponse response = new DataTableResponse();
        
        for( Schema.FieldSetMember eachFieldSetMember : fieldSetObj.getFields() ){
            String dataType = String.valueOf(eachFieldSetMember.getType()).toLowerCase();
            //This way we can set the type of a column
            //We do not get the exact type from schema object which matches to lightning:datatable component structure
            if(dataType == 'datetime'){
                dataType = 'date';
            }
            //Create a wrapper instance and store label, fieldname and type.
            DataTableColumns datacolumns = new DataTableColumns( String.valueOf(eachFieldSetMember.getLabel()) , 
                                                                String.valueOf(eachFieldSetMember.getFieldPath()), 
                                                                String.valueOf(eachFieldSetMember.getType()).toLowerCase() );
			lstDataColumns.add(datacolumns);
            lstFieldsToQuery.add(String.valueOf(eachFieldSetMember.getFieldPath()));
        }
        
        //Form an SOQL to fetch the data - Set the wrapper instance and return as response
        if(! lstDataColumns.isEmpty()){            
            response.lstDataTableColumns = lstDataColumns;
            String query = 'SELECT Id, ' + String.join(lstFieldsToQuery, ',') + ' FROM State__c';
            System.debug(query);
            response.lstDataTableData = Database.query(query);
        }
        
        return response;
    }
    
    //Wrapper class to hold Columns with headers
    public class DataTableColumns {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled       
        public String fieldName {get;set;}
        @AuraEnabled
        public String type {get;set;}
        @AuraEnabled
        public boolean editable {get;set;}
        
        //Create and set three variables label, fieldname and type as required by the lightning:datatable
        public DataTableColumns(String label, String fieldName, String type){
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;         
            this.editable = true;
        }
    }
    
    //Wrapper calss to hold response - This response is used in the lightning:datatable component
    public class DataTableResponse {
        @AuraEnabled
        public List<DataTableColumns> lstDataTableColumns {get;set;}
        @AuraEnabled
        public List<sObject> lstDataTableData {get;set;}                
        
        public DataTableResponse(){
            lstDataTableColumns = new List<DataTableColumns>();
            lstDataTableData = new List<sObject>();
        }
    }
    
    

}