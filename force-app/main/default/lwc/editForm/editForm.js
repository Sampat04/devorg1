import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
//import ACCOUNT_FIELD from '@salesforce/schema/Contact.Physician';

export default class EditForm extends LightningElement {
    // Expose a field to make it available in the template
    nameField = NAME_FIELD;
    //accountField = ACCOUNT_FIELD;

    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;
}