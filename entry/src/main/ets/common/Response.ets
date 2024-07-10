export class Response<DataType>{
  success?: string
  code?: string
  message?: string
  data?: DataType
}