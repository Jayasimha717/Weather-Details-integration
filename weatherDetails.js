import { LightningElement } from 'lwc';
import getWeatherdetails from '@salesforce/apex/WeatherApi.getWeatherdetails'

export default class WeatherDetails extends LightningElement {

    city='';
    showWeatherdetails = false;
    weatherdetails={};
    handleChange(event)
    {
        this.city = event.target.value;
    }

    handleClick()
    {
        getWeatherdetails({cityname:this.city})
        .then((result)=>
        {
            this.showWeatherdetails = true;
            this.weatherdetails = result;
            console.log('details--'+result);
        })
        .catch((error)=>
        {
            console.log(error);
            this.showWeatherdetails=false;
        })
    }
}