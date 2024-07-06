import {router} from '@kit.ArkUI'
import {BusinessError} from "@kit.BasicServicesKit"

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Column({ space: 20 }) {
        Text('space: 20').fontSize(15).fontColor(Color.Gray).width('90%')
        Row().width('90%').height(50).backgroundColor(0xF5DEB3)
      }.width('100%')
      // 添加按钮，以响应用户点击
      Button() {
        Text('Next')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .type(ButtonType.Capsule)
      .margin({
        top: 20
      })
      .backgroundColor('#0D9FFB')
      .width('40%')
      .height('5%')
      //跳转页面
     .onClick(()=>{
       console.info('Welcome')
       router.pushUrl({url:'pages/Second'}).then(()=>{
         console.info('Success in jumping Second page')
       }).catch((err:BusinessError)=>{
         console.error(`Failed to Second page.Code is ${err.code},message is ${err.message}`)
       })
     })
    }
    .height('100%')
    .width('100%')
  }
}