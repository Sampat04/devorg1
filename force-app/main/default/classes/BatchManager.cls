//Class created as part of Persistent Hackathon (June 2023)
public class BatchManager {
    public static List<String> validDataTypes = new List<String>{'String','Integer','Date','Boolean'};

    @AuraEnabled
	public static void defaultRun(String className, Integer batchSize){
        Type classType = Type.forName(className);
        Database.Batchable<sobject> classInstance = (Database.Batchable<sobject>) classType.newInstance();
        Database.executeBatch(classInstance, batchSize);
	}   
    
    /*@AuraEnabled
    public static void customizedRun(String className, Integer batchSize, List<ParameterWrapper> paramWrapList){
        ApexClass apexClass = [SELECT Id, Name, Body FROM ApexClass where Name =: className];
        Type t = Type.forName(className);
        Database.batchable<sObject> instance = (Database.batchable<sObject>)t.newInstance();           
        Map<String, Object> variableMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(instance));
        variableMap = getParameterMap(paramWrapList, apexClass); //variableMap.put('numRec', 10);
        system.debug('19 : '+variableMap);
        instance = (Database.Batchable<sObject>)JSON.deserialize(JSON.serialize(variableMap), t);
        Database.executeBatch(instance, batchSize);
    }*/   
    
    @AuraEnabled
    public static void customizedRun(String wrapperString){
        
        wrapperString = Label.BatchManagerLabel;
        CustomizedRunReceieveWrapper inputWrapper = (CustomizedRunReceieveWrapper)JSON.deserialize(wrapperString, CustomizedRunReceieveWrapper.class);
        system.debug('30 : '+inputWrapper);
        
        String className = inputWrapper.batchName;
        ApexClass apexClass = [SELECT Id, Name, Body FROM ApexClass where Name =: className];
        Type t = Type.forName(className);
        Database.batchable<sObject> instance = (Database.batchable<sObject>)t.newInstance();           
        Map<String, Object> variableMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(instance));
        variableMap = getParameterMap(inputWrapper.paramDetails, apexClass); //variableMap.put('numRec', 10);
        instance = (Database.Batchable<sObject>)JSON.deserialize(JSON.serialize(variableMap), t);
        Database.executeBatch(instance, inputWrapper.batchSize);
    }
    
    //varName, dataType, value
    private static Map<String,Object> getParameterMap(List<ParameterReceiveWrapper> inputWrapList, ApexClass apexClass){
        system.debug('42 : '+inputWrapList);
        Map<String,Object> variableMap = new Map<String,Object>();
        List<String> dataTypeList = new List<String>();
        Map<String,Object> paramNameVsValueMap = new Map<String,Object>();
        for(ParameterReceiveWrapper wrap : inputWrapList){
            dataTypeList.add(wrap.paramType);
            paramNameVsValueMap.put(wrap.paramName, wrap.paramVal);
        }
        
        Boolean errorFound;
        String className = apexClass.Name;
        String modifiedBody = apexClass.Body.replaceFirst(className, '');
        String constructorBody;
        while(modifiedBody.contains(className)){
            errorFound = false;
            system.debug('while loop iteration');
            constructorBody = '';
            Integer compareIndex = 0;
            if(modifiedBody.substringBetween(className, '(') != null){
                String s1 = modifiedBody.substringBetween(className, '(').deleteWhitespace();
                if(String.isBlank(s1)){ //check nothing exists between class name end & opening bracket of parameter
                    String allParamsString = modifiedBody.substringBetween(className, ')').remove('(');
                    
                    if(!String.isBlank(allParamsString)){ //exclude parameterless constructor
                        constructorBody = modifiedBody.substringBetween('){', '}');
                        List<String> paramsList = allParamsString.split(',');
                        for(String param : paramsList){
                            if(!String.isBlank(param)){
                                ParamSendWrapper pwrap = new ParamSendWrapper();
                                List<String> paramUnit = param.trim().split(' ');
                                if(validDataTypes.contains(paramUnit[0])){
                                    system.debug('1 = '+dataTypeList[compareIndex]+ ' 2 = '+paramUnit[0]);
                                    if(dataTypeList[compareIndex] == paramUnit[0]){
                                        system.debug('56');
                                        compareIndex++;
                                    }
                                    else{
                                        system.debug('60');
                                        errorFound = true; 
                                        break;
                                    }
                                }
                                else{
                                    system.debug('66');
                                    errorFound = true; 
                                    break;
                                }
                            }
                        }
                        
                        if(errorFound == false){
                            system.debug('paramNameVsValueMap : '+paramNameVsValueMap);
                            List<String> statementLists = constructorBody.split(';');
                            for(String stmt : statementLists){
                                if(!String.isBlank(stmt)){
                                    List<String> statementUnitsList = stmt.trim().split('=');
                                    system.debug('801 : '+statementUnitsList[0]);
                                    system.debug('811 : '+statementUnitsList[1]);
                                    if(paramNameVsValueMap.containsKey(statementUnitsList[1])){
                                        system.debug('entered 100');
                                        if(statementUnitsList[0].contains('this.')){
                                            system.debug('103 : '+statementUnitsList[0].split('this.')[0]);
                                            system.debug('104 : '+statementUnitsList[0].split('this.')[1]);
                                            if(paramNameVsValueMap.get(statementUnitsList[1]) == 'true'){
                                                variableMap.put(statementUnitsList[0].split('this.')[1], true);
                                            }
                                            else if(paramNameVsValueMap.get(statementUnitsList[1]) == 'false'){
                                                variableMap.put(statementUnitsList[0].split('this.')[1], false);
                                            }
                                            else{
                                                variableMap.put(statementUnitsList[0].split('this.')[1], paramNameVsValueMap.get(statementUnitsList[1]));
                                            }
                                        }
                                        else{
                                            if(paramNameVsValueMap.get(statementUnitsList[1]) == 'true'){
                                               variableMap.put(statementUnitsList[0], true);
                                            }
                                            else if(paramNameVsValueMap.get(statementUnitsList[1]) == 'false'){
                                                variableMap.put(statementUnitsList[0], false);
                                            }
                                            else{
                                                variableMap.put(statementUnitsList[0], paramNameVsValueMap.get(statementUnitsList[1]));
                                            }
                                            
                                        }
                                        
                                    }
                                }
                                
                            }
                            break;
                        }
                        
                    }
                }
            }
            modifiedBody = modifiedBody.replaceFirst(className, '');
            modifiedBody = modifiedBody.replaceFirst('\\)\\{', '');
            system.debug('constructor invalid');
        }
        system.debug('variableMap = '+variableMap);
        return variableMap;
    }
        
    private static Map<String,Object> getParameters(ApexClass apexClass){
        String className = apexClass.Name;
        String modifiedBody = apexClass.body.replaceFirst(className, '');
        List<List<ParamSendWrapper>> paramsDetailsList = new List<List<ParamSendWrapper>>();
        Boolean defaultRunBatch = false;
        Boolean customizedRunBatch = false;
        
        if(!modifiedBody.contains(className)){
            defaultRunBatch = true;
        }
        while(modifiedBody.contains(className)){
            Boolean validConst = true;
            if(modifiedBody.substringBetween(className, '(') != null){
                String s1 = modifiedBody.substringBetween(className, '(').deleteWhitespace();
                if(String.isBlank(s1)){ //check nothing exists between class name end & opening bracket of parameter
                    String allParamsString = modifiedBody.substringBetween(className, ')').remove('(');
                    
                    if(!String.isBlank(allParamsString)){ //exclude parameterless constructor
                        List<String> paramsList = allParamsString.split(',');
                        List<ParamSendWrapper> pwrapList = new List<ParamSendWrapper>();
                        for(String param : paramsList){
                            if(!String.isBlank(param)){
                                ParamSendWrapper pwrap = new ParamSendWrapper();
                                List<String> paramUnit = param.trim().split(' ');
                                if(validDataTypes.contains(paramUnit[0])){
                                    pwrap.dataType = paramUnit[0];
                                    pwrap.varName = paramUnit[paramUnit.size() - 1];
                                }
                                else{
                                    validConst = false;
                                }
                                pwrapList.add(pwrap);
                            }
                        }
                        if(validConst){
                            paramsDetailsList.add(pwrapList);
                            customizedRunBatch = true;
                        }
                    }
                    else{
                        defaultRunBatch = true;
                    }
                }
            }
            modifiedBody = modifiedBody.replaceFirst(className, '');
        }
        return new Map<String, Object> {
			'paramsDetailsList' => paramsDetailsList,
			'defaultRunBatch' => defaultRunBatch,
            'customizedRunBatch' => customizedRunBatch
		};
        //return paramsDetailsList; //List<List<ParamSendWrapper>> 
    }
    
    
    @AuraEnabled
    public static Map<String,Object> init(){
        List<ApexClass> batchApexClassList = getBatchClasses();
        List<ClassSendWrapper> wrapperList = new List<ClassSendWrapper>();
        Set<Id> classIdSet = new Set<Id>();
        Set<Id> runningClassesIdSet = new Set<Id>();
        Boolean defaultRun = getUserDetails('default');
        Boolean customizedRun = getUserDetails('customized');
        
        for(ApexClass apexClass : batchApexClassList){
            classIdSet.add(apexClass.Id);
        }
        for(AsyncApexJob job : [Select Id,ApexClassId from AsyncApexJob where Status != 'Completed' AND ApexClassId IN: classIdSet]){
            runningClassesIdSet.add(job.ApexClassId);
        }

        for(ApexClass apexClass : batchApexClassList){
            ClassSendWrapper wrap = new ClassSendWrapper();
            wrap.batchId = apexClass.Id;
            wrap.name = apexClass.Name;
            wrap.description = getDescription(apexClass.Body);
            wrap.isBatchJobRunning = runningClassesIdSet.contains(apexClass.Id);
            
            Map<String,Object> getParametersOutput = getParameters(apexClass);
            wrap.defaultRunBatch = (Boolean) getParametersOutput.get('defaultRunBatch');
            wrap.customizedRunBatch = (Boolean) getParametersOutput.get('customizedRunBatch');
            wrap.parameters = (List<List<ParamSendWrapper>>) getParametersOutput.get('paramsDetailsList');
            wrapperList.add(wrap);
        }
        for(ClassSendWrapper wrap : wrapperList){
            system.debug('final : '+wrap);
            for(List<ParamSendWrapper> listParamWrap : wrap.parameters){
                system.debug('paramWrap : '+listParamWrap);
            }
        }
        return new Map<String, Object> {
			'wrapperList' => wrapperList,
			'defaultRunUser' => defaultRun,
            'customizedRunUser' => customizedRun
		};
    }
    
    private static Boolean getUserDetails(String type){
        Id userId = UserInfo.getUserId();
        Id profileId = UserInfo.getProfileId();
        Boolean accessLevel = false;
        
        Map<Id,BatchManagerAccess__mdt> entityVSMetadataMap = new Map<Id,BatchManagerAccess__mdt>();
        for(BatchManagerAccess__mdt cusMdt : BatchManagerAccess__mdt.getAll().values()){
            entityVSMetadataMap.put(cusMdt.EntityId__c, cusMdt);
        }
        
        if(entityVSMetadataMap.containsKey(userId)){
            accessLevel = type == 'default' ? entityVSMetadataMap.get(userId).DefaultRun__c : entityVSMetadataMap.get(userId).CustomizedRun__c;
        }
        else if(entityVSMetadataMap.containsKey(profileId)){
            accessLevel = type == 'default' ? entityVSMetadataMap.get(profileId).DefaultRun__c : entityVSMetadataMap.get(profileId).CustomizedRun__c;
        }
        return accessLevel;
    }
    
    private static List<ApexClass> getBatchClasses(){
        List<ApexClass> batchApexClassList = new List<ApexClass>();
        for(ApexClass apexClass : [SELECT Id, Name, ApiVersion, Body FROM ApexClass where NamespacePrefix = null AND Name != 'BatchManager']){
            if(apexClass.Body.contains('Database.Batchable')){
                batchApexClassList.add(apexClass);
            }
        }
        return batchApexClassList;
    }
    
    
    private static String getDescription(String classBody){
        return 'test description';
    }
    
    public class ClassSendWrapper{
        @AuraEnabled public String name;
        @AuraEnabled public List<List<ParamSendWrapper>> parameters;
        @AuraEnabled public String description;
        @AuraEnabled public Id batchId;
        @AuraEnabled public Boolean isBatchJobRunning;
        @AuraEnabled public Boolean defaultRunBatch;
        @AuraEnabled public Boolean customizedRunBatch;
    }
    
    public class ParamSendWrapper{
         @AuraEnabled public String varName;
         @AuraEnabled public String dataType;
         //@AuraEnabled public Integer order;
    }
    
    public class ParameterWrapper{
         @AuraEnabled public String varName;
         @AuraEnabled public String dataType;
         @AuraEnabled public String value;
    }
    
    public class CustomizedRunReceieveWrapper{
        @AuraEnabled public String batchId;
        @AuraEnabled public String batchName;
        @AuraEnabled public Integer batchSize;
        @AuraEnabled public List<ParameterReceiveWrapper> paramDetails;
    }
    
    public class ParameterReceiveWrapper{
        @AuraEnabled public String paramId;
        @AuraEnabled public String paramName;
        @AuraEnabled public String paramType;
        @AuraEnabled public String paramVal;
    }
    
}