import { LightningElement } from 'lwc';
export default class ChildTest extends LightningElement {

    connectedCallback(){
        console.log('child cc');
    }
}