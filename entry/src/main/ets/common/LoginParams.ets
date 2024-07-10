import { Params } from './params';

export class LoginParams extends Params{
  email?: string
  password?: string
  constructor(email:string,password:string){
    super();
    this.email = email;
    this.password = password;
  }
}