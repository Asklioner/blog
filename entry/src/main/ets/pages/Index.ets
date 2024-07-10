import router from '@ohos.router';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';
import { JSON } from '@kit.ArkTS';
import { ValueType } from '@kit.ArkData';


@CustomDialog
struct CustomDialogExample{
  cancel?: () => void
  confirm?: (username?: string, password?: string) => void
  controller?: CustomDialogController
  username?: string
  password?: string


  build() {
    Column(){
      TextInput({placeholder: '请输入邮箱'}).onChange((value: string) => {
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
  confirm?: (username?: string, password?: string, email?: string, authCode?: string) => void
  controller?: CustomDialogController
  username?: string
  password?: string
  passwordAgain?: string
  email?: string
  authCode?: string

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
            let httpRequest = http.createHttp()
            httpRequest.request(
              "/user/code",
              {
                method: http.RequestMethod.POST,
                extraData: this.email,
              },
              (err: BusinessError, data: http.HttpResponse) => {
                if(!err){
                  if(JSON.parse(data.result.toString())){
                    promptAction.showToast({
                      message: '发送成功',
                      duration: 2000
                    });
                  }else{
                    promptAction.showToast({
                      message: '发送失败',
                      duration: 2000
                    });
                  }
                  httpRequest.destroy()
                }else{
                  console.info('发送失败')
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
              && this.authCode != undefined && this.email != '' && this.authCode != ''){
              if(this.password != this.passwordAgain){
                AlertDialog.show({
                  title: '警告',
                  message: '两次密码不一致',
                  alignment: DialogAlignment.Bottom,
                  autoCancel: true,
                })
              }else{
                this.confirm(this.username, this.password, this.email, this.authCode)
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
      confirm: (username?: string, password?: string) => {this.onConfirm(username, password)}
    })
  })

  register: CustomDialogController = new CustomDialogController({
    builder: register({
      cancel: () => {},
      confirm: (username?: string, password?: string, email?: string, authCode?: string) =>
      {this.onRegister(username, password, email, authCode)}
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


  onRegister(username?: string, password?: string, email?: string, code?: string){
    //注册
    let httpRequest = http.createHttp()
    httpRequest.request(
      '/user/register',
      {
        method: http.RequestMethod.POST,
        extraData: [email, username, password, code],
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if(!err){
          promptAction.showToast({
              message: '注册成功',
              duration: 2000
          })
          httpRequest.destroy()
        }else{
          promptAction.showToast({
            message: '注册失败',
            duration: 2000
          })
          httpRequest.destroy()
        }
      }
    )
  }

  onConfirm(username?: string, password?: string){
    this.dialogController.close()
    // router.replaceUrl({
    //   url: 'pages/main_page'
    // }, router.RouterMode.Standard)

    //登录提交请求
    let httpRequest = http.createHttp()
    httpRequest.request(
      'http://192.168.5.18:8081/user/login',
      {
        method: http.RequestMethod.POST,
        extraData: {
          'email':'610759768@qq.com',
          'password':'zhaokedi1'
        },
        header: {
        'Content-Type': 'application/json',
      },
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if(!err){
          console.info('1')
          console.info('返回结果: ' + data.result)
          console.log(data.responseCode.toString())
          console.log(JSON.stringify(data.result))
          console.log(JSON.stringify(data.header))

          AppStorage.set("token",data.result);
          router.replaceUrl({
            url: 'pages/main_page'
          }, router.RouterMode.Standard)
          this.dialogController.close()

          httpRequest.destroy()
        }else{
          promptAction.showToast({
            message: '账号或密码错误',
            duration: 2000
          })
          httpRequest.destroy()
        }
      }
    )

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
        Image($r('app.media.background1'))
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