import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';


@Entry
@Component
struct Setting {
  oldPassword?: string
  newPassword?: string

  build() {
    Column({space: 20}){
      Flex({ direction: FlexDirection.Row }){
        Image($r('app.media.icon')).width('30%').margin({right: 30})
        //Text(this.CardItem.name).fontSize(40).margin({top: 20})
        Text('用户名').fontSize(40).margin({top: 20})
      }.margin(20)
      TextInput({placeholder: '旧密码'}).onChange((value: string) => {
        this.oldPassword = value
      })
      TextInput({placeholder: '新密码'}).onChange((value: string) => {
        this.newPassword = value
      })
      Button('修改').onClick(() => {
        let httpRequest = http.createHttp()
        httpRequest.request(
          'url',
          {
            method: http.RequestMethod.POST,
            //要加用户名
            extraData: [this.oldPassword, this.newPassword]
          },
          (err: BusinessError, data: http.HttpResponse) => {
            if(!err){
              //错误码
              httpRequest.destroy()
            }else{
              console.log('请求失败')
              httpRequest.destroy()
            }
          }
        )
      })
    }.margin(20)
  }
}