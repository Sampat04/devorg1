import { LightningElement } from 'lwc';
export default class AccountForm extends LightningElement {

    recordId = '0017F00000Knv7LQAR';
    objectApiName = 'Account';

handleSubmit(event) {
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }
    handleSuccess(event) {
        console.log('onsuccess event recordEditForm', event.detail.id);
    }

}