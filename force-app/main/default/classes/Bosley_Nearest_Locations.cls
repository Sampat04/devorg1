public class Bosley_Nearest_Locations {
    
    @AuraEnabled  
    public static list<account> Find_Nearest_Locations(String Address)
    {        
        system.debug('entered apex method; Address = '+Address);
        list<account> Nearest_Location_List;
        String formattedAddress='';
        String jsonResponse;
        if(Address!=null && Address!='')
        {                     
            List<String> splitAddress = Address.split(' ');
            for(string s : splitAddress)
            {           
                formattedAddress += s+'+';
            }
            formattedAddress = formattedAddress.removeEnd('+');
            
            system.debug('formattedAddress = '+formattedAddress);
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            //            request.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyC4neGsVw0Rm7ebyBopLE6aXB8zQDlhb6A');
            request.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address='+formattedAddress+',+CA&key=AIzaSyC4neGsVw0Rm7ebyBopLE6aXB8zQDlhb6A');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                //       AllLocations allLocs = (AllLocations)JSON.deserialize(response.getBody(), AllLocations.class);
                jsonResponse = response.getBody();
                system.debug('response = '+jsonResponse);            
                //       jsonResponse = '{"results" : [{"address_components" : [{"long_name" : "1600","short_name" : "1600","types" : [ "street_number" ]},{"long_name" : "Amphitheatre Pkwy","short_name" : "Amphitheatre Pkwy","types" : [ "route" ]},{"long_name" : "Mountain View","short_name" : "Mountain View","types" : [ "locality", "political" ]},{"long_name" : "Santa Clara County","short_name" : "Santa Clara County","types" : [ "administrative_area_level_2", "political" ]},{"long_name" : "California","short_name" : "CA","types" : [ "administrative_area_level_1", "political" ]},{"long_name" : "United States","short_name" : "US","types" : [ "country", "political" ]},{"long_name" : "94043","short_name" : "94043","types" : [ "postal_code" ]}],"formatted_address" : "1600 Amphitheatre Parkway, Mountain View, CA 94043, USA","geometry" : {"location" : {"lat" : 37.4224764,"lng" : -122.0842499},"location_type" : "ROOFTOP","viewport" : {"northeast" : {"lat" : 37.4238253802915,"lng" : -122.0829009197085},"southwest" : {"lat" : 37.4211274197085,"lng" : -122.0855988802915}}},"place_id" : "ChIJ2eUgeAK6j4ARbn5u_wAGqWA","types" : [ "street_address" ]}],"status" : "OK"}';
                
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);        
                system.debug('result = '+results);     
                
                List<Object> results1 = (List<Object>) results.get('results');
                system.debug('result = '+results1);
                
                Map<String, Object> results2 = (Map<String, Object>) results1[0];  
                
                Map<String, Object> results3 = (Map<String, Object>) results2.get('geometry');        
                system.debug('abc = '+results3);
                
                Map<String, Object> results4 = (Map<String, Object>) results3.get('location');
                system.debug('abcd = '+results4);
                
                Decimal addressLat = (Decimal) results4.get('lat');
                Decimal addressLng = (Decimal) results4.get('lng');
                system.debug('lat = '+addressLat+' lng = '+addressLng);
                
                
                Nearest_Location_List = [SELECT Id,Name FROM Account ORDER BY 
                                         DISTANCE(BillingAddress,GEOLOCATION(:addressLat,:addressLng),'km') nulls last limit 3];
                
                for(account acc : Nearest_Location_List){
                    system.debug(acc+'\n');            
                }
            }  
        }        
        return Nearest_Location_List;      
    }   
}