import { Params } from './params';

export class RegisterParams extends Params{
  email?: string
  password?: string
  name?: string
  code?: string
  constructor(email:string,password:string,name:string,code:string){
    super();
    this.email = email;
    this.password = password;
    this.name = name;
    this.code = code;
  }
}