import { Params } from './params';

export class SendCodeParams extends Params{
  email?: string
  constructor(email:string){
    super();
    this.email = email;
  }
}