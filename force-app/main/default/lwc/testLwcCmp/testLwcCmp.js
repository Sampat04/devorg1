import { LightningElement, track, api } from 'lwc';
import getContacts from '@salesforce/apex/LwcHandler.getContacts';
import getContactsList from '@salesforce/apex/LwcHandler.getContactsList';

export default class TestLwcCmp extends LightningElement {

    @api recordId;
    buttonCall = false;
    inputBoxString = 'nothing typed';
    @track contactList;
    @track namelist;
    
    connectedCallback(){
        this.getContacts();
    }

    getContacts(){
        getContacts({
            accountId : this.recordId
        })
        .then(result => {
            //console.log('result = ',JSON.stringify(result));
        })
        .catch(error => {
            console.error('Error in getContacts : ',error);
        });
    }

    eventDisplay(event){
        this.buttonCall = !this.buttonCall;

        const inp1 = this.template.querySelectorAll('lightning-input');
        //console.log(inp1);
        //console.log('inp1 = '+inp1[0].value);
        //console.log('inp2 = '+inp1[1].value);

        /*this.namelist = ['ant','bat','cat'];
        this.namelist.forEach(name => {
            console.log(name);
        });
        for(let name of this.namelist){
            console.log(name+'--');
        }*/
        //console.log('evt2 = ',JSON.stringify(event));
    }

    inputEvt(event){
        //console.log(event);
        //console.log(event.target);
        this.inputBoxString = event.target.value;

        getContactsList({
            str : this.inputBoxString
        }).then(result => {
            //console.log(result);
            this.contactList = result;
        }).catch(error => {
            //console.error(error);
        })
    }
    
}

/*
1. lightning dataTable
2. passing text value from UI
3. passing button click, which button clicked out of 2
*/