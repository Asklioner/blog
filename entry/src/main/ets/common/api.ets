// api.ets文件
import { http } from '@kit.NetworkKit';
import { Params } from './params';

const BASE_URL: string = 'http://43.142.182.70:8081';//这里写接口地址


export function httpRequestDel(url: string,params: Params) {
  url = BASE_URL+url
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.DELETE,
    header : {
      'Authorization': params.token,
      'Content-Type': 'application/json',
    },
  });
  return responseResult
}


export function httpRequestPut(url: string, params: Params) {
  url = BASE_URL+url
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.PUT,
    extraData: params,
    header: {
      'Authorization': params.token,
      'Content-Type': 'application/json',
    }
  });
  return responseResult
}


export function httpRequestPost(url: string, params: Params) {
  url = BASE_URL+url
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.POST,
    extraData: params,
    header: {
      'Accept': '*/*',
      'Authorization': params.token,
      "Content-Type": "application/json;",
    }
  });
  return responseResult
}

export function httpRequestGet(url: string) {
  url = BASE_URL+url
  let httpRequest = http.createHttp();
  const  token = AppStorage.get("token") as string
  console.log("token test is ..."+token)
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    header: {
      'Authorization': token,
      'Content-Type': 'application/json',
    }
  });
  return responseResult
}
