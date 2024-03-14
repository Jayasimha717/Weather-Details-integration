public with sharing class WeatherApi {
    
    @AuraENabled(cacheable=true)
    public static WeatherDetailsWrapper getWeatherdetails(string cityname)
    {
        string apikey = '0899edd5abd6dd2564837c2c880d547f';
        string endpoint='http://api.openweathermap.org/data/2.5/weather';
        endpoint += '?q='+cityname;
        endpoint += '&units=metric';
        endpoint += '&APPID='+apikey;
        system.debug('endpoint url--'+endpoint);
        
        //callout to weather api
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        if(res.getStatusCode() == 200)
        {
            
            Map<String,Object> result = (Map<String,Object>)Json.deserializeUntyped(res.getBody());
            system.debug('result--'+result);
        }
        
        WeatherDetailsWrapper weatherDetails = new WeatherDetailsWrapper();
        if(res.getStatusCode() == 200)
        {
           	Map<String,Object> result = (Map<String,Object>)Json.deserializeUntyped(res.getBody());
          	weatherDetails.city = (string)result.get('name');
           	Map<String,Object> mainResult = (Map<String,Object>)result.get('main');
            weatherDetails.Temperature = (Decimal)mainResult.get('temp');
            weatherDetails.feelsLike = (Decimal)mainResult.get('feels_like');
            weatherDetails.MinTemperature = (Decimal)mainResult.get('temp_min');
            weatherDetails.MaxTemperature = (Decimal)mainResult.get('temp_max');
            weatherDetails.pressure = (Decimal)mainResult.get('pressure');
            weatherDetails.humidity = (Decimal)mainResult.get('humidity');
        }
        system.debug('weatherdetails--'+weatherDetails);
        return weatherDetails;
    }
    
    //wrapper class to store weather details in serial manner
    public class WeatherDetailsWrapper
    {
        @AuraEnabled public string city {get;set;}
        @AuraEnabled public Decimal Temperature {get;set;}
        @AuraEnabled public Decimal feelsLike {get;set;}
        @AuraEnabled public Decimal MinTemperature {get;set;}
        @AuraEnabled public Decimal MaxTemperature {get;set;}
        @AuraEnabled public Decimal pressure {get;set;}
        @AuraEnabled public Decimal humidity {get;set;}
    }
    
}