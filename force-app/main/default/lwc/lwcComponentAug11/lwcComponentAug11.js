import { LightningElement, track, api } from 'lwc';
import fetchRecords from '@salesforce/apex/LwcHandlerAug11.fetchRecords';

export default class LwcComponentAug11 extends LightningElement {

    @track recordWrapper;
    loaded = false; //by default track
    loadedInt = 'null';

    connectedCallback() {
        this.fetchRecordsCall();
    }

    fetchRecordsCall(){
        fetchRecords().then(result => {
            this.loaded = true;
            console.log('line 20 : ',result);
            this.recordWrapper = result;
        })
        .catch(error => {
            console.error('Error in fetchRecords : ',error);
        });
    }

}