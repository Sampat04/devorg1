@RestResource(urlMapping = '/createContactRec/')
global class TestAPI_Expose2 {
    
    @HTTPPost
    global static string doPost(){
        
        RestRequest request = RestContext.request;
        String requestBody = request.requestBody.toString(); 
        //system.debug('res 1 = '+requestBody);
        Map<String, Object> mapResultBody = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
		//system.debug('res 2 = '+mapResultBody);
        Map<String, Object> subMap = (Map<String, Object>) mapResultBody.get('LinkEvent');
        system.debug('subMap = '+subMap);
        //Map<String, Object> subMap2 = (Map<String, Object>)mapResultBody.get('LinkEvent');
        //system.debug('subMap2 = '+subMap2);
        String dictonaryEntry = String.valueOf(subMap.get('DictEntry'));
        String dictonaryNumber = String.valueOf(subMap.get('DictNum'));
        String recordId = null;
        
        Object obj = mapResultBody.get('EntryResponseList');
        String IDXKey = dictonaryEntry;
        
        Map<String, String> sfFieldValueMap = new Map<String, String>();
        Map<String, String> fieldNameValueMap = new Map<String, String>();
        List<Object> objList = (List<Object>) obj;
        system.debug('objList = '+objList);
        //List<Object> objList2 = (List<Object>)obj;
        //system.debug('objList2 = '+objList2);
        for(Object o : objList)
        {
            Map<String, Object> objMap = (Map<String, Object>) o;
            if(fieldNameValueMap.containsKey(objMap.get('Name').toString())){
                String oldValue = fieldNameValueMap.get(objMap.get('Name').toString());
                String newValue = oldValue+';'+objMap.get('Value').toString();
                fieldNameValueMap.put(objMap.get('Name').toString(), newValue);
            }
            else 
                fieldNameValueMap.put(objMap.get('Name').toString(), objMap.get('Value').toString());
        }
        
                List<Contact> conRecord = new List<Contact>();
        if(fieldNameValueMap.containsKey('SalesforceId'))
        { 
            conRecord = [SELECT Id,LastName, Fax FROM Contact WHERE Id=:fieldNameValueMap.get('SalesforceId') LIMIT 1];
        }
        
        if(conRecord!=null & conRecord.size()>0)
        {
            //conRecord[0].IDX_D123_Response__c = obj.toString();
            conRecord[0].Fax = fieldNameValueMap.get('FaxNumber');
            conRecord[0].LastName = fieldNameValueMap.get('Name');
            update conRecord;
            return conRecord[0].Id;
        }
        else
        {
            Contact newRecord = new Contact();
            //newRecord.IDX_D123_Response__c = obj.toString();
            newRecord.Fax = fieldNameValueMap.get('FaxNumber');
            newRecord.LastName = fieldNameValueMap.get('Name');
            insert newRecord;
            return newRecord.Id;
        }

    }
    
}