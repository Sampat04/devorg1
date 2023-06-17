@RestResource(urlMapping = '/createContact/')
global class TestAPI_Expose {
    
    @HTTPPost
    global static string doPost(){
        
        RestRequest req = RestContext.request; //get request sent by External System, not present as parameter in doPost method
        system.debug('request = '+req);
        //req has 2 parts: 1. req.params, 2. req.requestBody
        
        //send request using 'RestResponse' object

        return 'call made to TestAPI_Expose qw';
    }

}

//Http h1, HttpRequest h2, HttpResponse h3 = h1.send(h2);

/*
Security token (case-sensitive): qYV7lAZPCLKyQyUyt8gA280q

grant_type = password
client_id = 3MVG9d8..z.hDcPLXYrbI.0CuOaAkyU96.zMHl4jvUi_ag00IwoOrDkSoOii0YkitZ..gIvr2XECarBOqfZMF
client_secret = A61F18E40AB4E8DB79057E858F414BD56D7799E380F93421B6CCAA2C7214D828
username = sampat4@persistent.com
password = newuser@125qYV7lAZPCLKyQyUyt8gA280q

to get access token set endpoint URL = https://login.salesforce.com/services/oauth2/token

{
    "access_token": "00D7F000003iCew!ARkAQGY_9qXpqAGirwcwPvsLk5OmfMVVKrgb8T6O_5J6gvwPNj7sIC9TG_3W5Yr4V5Jjrn2rxGsN7KB_4pMgh5mJqcAMgDf7",
    "instance_url": "https://australia434-dev-ed.my.salesforce.com",
    "id": "https://login.salesforce.com/id/00D7F000003iCewUAE/0057F0000011C7HQAU",
    "token_type": "Bearer",
    "issued_at": "1629037362899",
    "signature": "qHrRaYAnNxkPeMn0VlsHF29SqGpOD82Ne8eKXjagsao="
}

endpoint URL to test = https://australia434-dev-ed.my.salesforce.com/services/apexrest/createContact/
*/