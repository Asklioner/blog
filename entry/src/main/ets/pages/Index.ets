import router from '@ohos.router';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { Response } from '../common/Response';
import { LoginData } from '../common/LoginData';
import { httpRequestPost } from '../common/api';
import { Params } from '../common/params';
import { LoginParams } from '../common/LoginParams';


@CustomDialog
struct CustomDialogExample{
  cancel?: () => void
  confirm?: (username?: string, password?: string) => void
  controller?: CustomDialogController
  username?: string
  password?: string


  build() {
    Column(){
      TextInput({placeholder: '请输入用户名'}).onChange((value: string) => {
        this.username = value
      }).margin(20)
      TextInput({placeholder: '请输入密码'}).type(InputType.Password).onChange((value: string) => {
        this.password = value
      }).margin(20)
      Flex({justifyContent: FlexAlign.SpaceAround}){
        Button('登录').onClick(() => {
          if(this.confirm){
            if(this.username != undefined && this.password != undefined && this.username != '' && this.password != '')
            {
                this.confirm(this.username, this.password)
            }else{
              AlertDialog.show({
                title: '警告',
                message: '账号或密码不能为空',
                alignment: DialogAlignment.Bottom,
                autoCancel: true,
              })
            }
          }
        })
        Button('取消').onClick(() => {
          if(this.controller != undefined){
            this.controller.close()
          }
          if(this.cancel){
            this.cancel()
          }
        })
      }.margin(20)
    }
  }
}

@CustomDialog
struct register{
  cancel?: () => void
  confirm?: (username?: string, password?: string, email?: string,) => void
  controller?: CustomDialogController
  username?: string
  password?: string
  passwordAgain?: string
  email?: string
  authCode?: string
  realCode?: string

  build() {
    Column(){
      TextInput({placeholder: '请输入用户名'}).onChange((value: string) => {
        this.username = value
      }).margin(20)
      TextInput({placeholder: '请输入密码'}).type(InputType.Password).onChange((value: string) => {
        this.password = value
      }).margin(20)
      TextInput({placeholder: '再次输入密码'}).type(InputType.Password).onChange((value: string) => {
        this.passwordAgain = value
      }).margin(20)
      Row(){
        Flex({ direction: FlexDirection.Row }){
          TextInput({placeholder: '邮箱'}).type(InputType.Email).onChange((value: string) => {
            this.email = value
          }).width('70%').margin({right: 20})
          Button('发送').onClick(() => {
            //发送验证码
            let httpRequest = http.createHttp()
            httpRequest.request(
              //路由待定
              "url",
              {
                method: http.RequestMethod.POST,
                extraData: this.email,
                expectDataType: http.HttpDataType.STRING
              },
              (err: BusinessError, data: http.HttpResponse) => {
                if(!err){
                  this.realCode = JSON.stringify(data.result)
                  httpRequest.destroy()
                }else{
                  console.info('error:' + JSON.stringify(err))
                  httpRequest.destroy()
                }
              }
            )
          }).width('30%')
        }
      }.margin(20)
      TextInput({placeholder: '验证码'}).type(InputType.Normal).onChange((value: string) => {
        this.authCode = value
      }).margin(20)
      Flex({justifyContent: FlexAlign.SpaceAround}){
        Button('注册').onClick(() => {
          if(this.confirm){
            if(this.username != undefined && this.password != undefined && this.passwordAgain != undefined
              && this.username != '' && this.password != '' && this.passwordAgain != '' && this.email != undefined
              && this.authCode != undefined && this.email != '' && this.authCode != '' && this.realCode != undefined
              && this.realCode != ''){
              if(this.password != this.passwordAgain){
                AlertDialog.show({
                  title: '警告',
                  message: '两次密码不一致',
                  alignment: DialogAlignment.Bottom,
                  autoCancel: true,
                })
              }else if(this.authCode != this.realCode){
                AlertDialog.show({
                  title: '警告',
                  message: '验证码错误',
                  alignment: DialogAlignment.Bottom,
                  autoCancel: true,
                })
              }else{
                this.confirm(this.username, this.password, this.email)
              }
            }else{
              AlertDialog.show({
                title: '警告',
                message: '不能有空项',
                alignment: DialogAlignment.Bottom,
                autoCancel: true,
              })
            }
          }
        })
        Button('取消').onClick(() => {
          if(this.controller != undefined){
            this.controller.close()
          }
          if(this.cancel){
            this.cancel()
          }
        })
      }.margin(20)
    }
  }
}

@CustomDialog
struct Forget{
  cancel?: () => void
  confirm?: (username?: string, newPassword?: string, email?: string) => void
  controller?: CustomDialogController
  username?: string
  newPassword?: string
  newPasswordAgain?: string
  email?: string
  authCode?: string
  realCode?: string

  build() {
    Column(){
      TextInput({placeholder: '请输入用户名'}).type(InputType.Normal).onChange((value: string) => {
        this.username = value
      }).margin(20)
      TextInput({placeholder: '请输入新密码'}).type(InputType.Password).onChange((value: string) => {
        this.newPassword = value
      }).margin(20)
      TextInput({placeholder: '请再次输入新密码'}).type(InputType.Password).onChange((value: string) => {
        this.newPasswordAgain = value
      }).margin(20)
      Row(){
        Flex({ direction: FlexDirection.Row }){
          TextInput({placeholder: '邮箱'}).type(InputType.Email).onChange((value: string) => {
            this.email = value
          }).width('70%').margin({right: 20})
          Button('发送').onClick(() => {
            if(this.email != undefined && this.email != ''){
              let httpRequest = http.createHttp()
              httpRequest.request(
                //路由待定
                "url",
                {
                  method: http.RequestMethod.POST,
                  extraData: this.email,
                  expectDataType: http.HttpDataType.STRING
                },
                (err: BusinessError, data: http.HttpResponse) => {
                  if(!err){
                    this.realCode = JSON.stringify(data.result)
                    httpRequest.destroy()
                  }else{
                    console.info('error:' + JSON.stringify(err))
                    httpRequest.destroy()
                  }
                }
              )
            }

          }).width('30%')
        }
      }.margin(20)
      TextInput({placeholder: '验证码'}).type(InputType.Normal).onChange((value: string) => {
        this.authCode = value
      }).margin(20)
      Flex({justifyContent: FlexAlign.SpaceAround}){
        Button('修改').onClick(() => {
          if(this.confirm){
            if(this.username != undefined && this.newPassword != undefined &&
              this.newPasswordAgain != undefined && this.email != undefined &&
              this.authCode != undefined && this.realCode != undefined &&
              this.username != '' && this.newPassword != '' &&
              this.newPasswordAgain != '' && this.email != '' &&
              this.authCode != '' && this.realCode != '')
            {
              if(this.authCode != this.realCode){
                AlertDialog.show({
                  title: '警告',
                  message: '验证码错误',
                  alignment: DialogAlignment.Bottom,
                  autoCancel: true,
                })
              }else if(this.newPassword != this.newPasswordAgain){
                AlertDialog.show({
                  title: '警告',
                  message: '两次密码不一致',
                  alignment: DialogAlignment.Bottom,
                  autoCancel: true,
                })
              }else{
                this.confirm(this.username, this.newPassword, this.email)
              }
            }else{
              AlertDialog.show({
                title: '警告',
                message: '不能有空项',
                alignment: DialogAlignment.Bottom,
                autoCancel: true,
              })
            }
          }
        })
        Button('取消').onClick(() => {
          if(this.controller){
            this.controller.close()
          }
          if(this.cancel){
            this.cancel()
          }
        })
      }.margin(20)
    }
  }
}


@Entry
@Component
struct Index {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: () => {},
      confirm: (email ?: string, password ?: string) => {this.onConfirm(email ?? "", password ?? "")}
    })
  })

  register: CustomDialogController = new CustomDialogController({
    builder: register({
      cancel: () => {},
      confirm: (username?: string, password?: string, email?: string) =>
      {this.onRegister(username, password, email)}
    })
  })

  forget: CustomDialogController = new CustomDialogController({
    builder: Forget({
      cancel: () => {},
      confirm: (username?: string, newPassword?: string, email?: string) => {
        this.onForget(username, newPassword, email)
      }
    })
  })

  onRegister(username?: string, password?: string, email?: string){
    //注册
    let httpRequest = http.createHttp()
    httpRequest.request(
      'url',
      {
        method: http.RequestMethod.POST,
        extraData: [username, password, email],
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if(!err){
          //错误码
        }else{
          console.log('注册失败')
          httpRequest.destroy()
        }
      }
    )
  }

  onConfirm(email: string, password: string){
    //登录提交请求
    let loginParams:LoginParams = new LoginParams(email,password);
    let response = httpRequestPost("/user/login",loginParams);
    response.then((res)=>{
      let response:Response<LoginData> = JSON.parse(res.result.toString());
      let token = response.data?.token;
      AppStorage.set("token",token);
      console.log(token);
      router.replaceUrl({
        url: 'pages/main_page'
      }, router.RouterMode.Standard)
    }).catch((err:BusinessError)=>{
      console.log('登陆失败')
    })
  }

  onForget(username?: string, newPassword?: string, email?: string){
    //忘记密码
    let httpRequest = http.createHttp()
    httpRequest.request(
      'url',
      {
        method: http.RequestMethod.POST,
        extraData: [username, newPassword, email],
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if(!err){
          //错误码
        }else{
          console.log('请求失败')
          httpRequest.destroy()
        }
      }
    )
  }

  build() {
    Column(){
      Stack({}){
        Image($r("app.media.background1"))
        Row({space: 40}){
          Button('登录', { stateEffect: true })
            .onClick(() => {
              this.dialogController.open()
            }).backgroundColor(0x000000)
          Button('注册', { stateEffect: true })
            .onClick(() => {
              this.register.open()
            }).backgroundColor(0x000000)
          Button('忘记密码', { stateEffect: true })
            .onClick(() => {
              this.forget.open()
            }).backgroundColor(0x000000)
        }
      }
    }
  }
}

