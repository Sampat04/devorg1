/* eslint-disable no-console */

import { LightningElement, api } from 'lwc';

export default class DynamicRowLWC extends LightningElement {

    @api objectInstance=[{'sobjectType': 'Custom_Object__c',
    'Name': '',
    'Field_1__c': '',
    'Field_2__c': ''}] ;
     
    @api currIndex;
    @api index;
    @api delIndex;
    @api filtered;

    connectedCallback(){
        //console.log('u are in cc call back');     
        //console.log('this.objectInstance (child) in cc callback = '+JSON.stringify(this.objectInstance));
    }
   
    addNewRowChild()
    {        
        const tmpObj = JSON.parse(JSON.stringify(this.objectInstance));      
        tmpObj.push({                        
            'sobjectType': 'Custom_Object__c',
            'Name': '',
            'Field_1__c': '',
            'Field_2__c': ''
        });  
        this.objectInstance = tmpObj;  

        //console.log('this.objectInstance(child) in AddNewRow = '+JSON.stringify(this.objectInstance));
        const addNewRowEvent = new CustomEvent('add',{detail:this.objectInstance});
        this.dispatchEvent(addNewRowEvent);      
    }


    removeRowChild(event)
    {
        
        this.delIndex = event.target.dataset.index;
        //console.log('delIndex = '+this.delIndex);

        const tmpObj = JSON.parse(JSON.stringify(this.objectInstance));     
        tmpObj.splice(this.delIndex,1);  //line 1

        /*
        var bigCities = cities.filter(function (e) {
           return e.population > 3000000;
        });
        //console.log(bigCities);
        

        this.filtered = tmpObj.filter(function(value, index){
            //return value => index !== this.delIndex;       
            return value.indexOf(query.toLowerCase()) !== this.delIndex;  
        });
        */
        //this.objectInstance = this.filtered;
        this.objectInstance = tmpObj;     //line 2

        //console.log('this.objectInstance(child) in removeRow = '+JSON.stringify(this.objectInstance));
        const removeRowEvent = new CustomEvent('remove',{detail:this.objectInstance});
        this.dispatchEvent(removeRowEvent);       
    }


    handleFieldChangeChild(event)
    {

        //console.log('this.objectInstance(child) in handleFieldChange b4 = '+JSON.stringify(this.objectInstance));
        this.currIndex = event.target.dataset.index;
        
        try
        {
            const tmpObj = JSON.parse(JSON.stringify(this.objectInstance)); 
            tmpObj[this.currIndex][event.target.name] = event.target.value; 
            this.objectInstance = tmpObj;  
        }
        catch(e)
        {
            //console.log('error = '+e.message);
        }
        
        //console.log('this.objectInstance(child) in handleFieldChange after = '+JSON.stringify(this.objectInstance));       
        const updateRowEvent = new CustomEvent('updater',{detail:this.objectInstance});
        this.dispatchEvent(updateRowEvent);       
    }

}