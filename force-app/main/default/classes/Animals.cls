public class Animals{
    public static Object animals(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"Name":"Lion"}');
        
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 200){
            System.debug(res.getBody());
        }
        else{
            System.debug('Error. Status :'+ res.getStatusCode());
        }
        
        return new Map<String, Object> {
			'chessString' => 'WCC 2023',
			'resp1' => res
		};
        
        /*ReturnWrapper rwInst = new ReturnWrapper();
        rwInst.chessString = 'WCC 2023';
        rwInst.resp1 = res;
        return rwInst;*/
	}
    
    public class ReturnWrapper{
        public String chessString;
        public HttpResponse resp1;
    }
}