// Second.ets
import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct Second {
  private controller: TabsController = new TabsController();

  build() {
    Column() {
      Tabs({// Tabs不设置vertical属性时，默认上下排版
        barPosition: BarPosition.Start,
        controller: this.controller
      }) {
        TabContent() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor("#aabbcc")
        }
        .size({width: "100%", height: "100%"})
        .tabBar("消息")

        TabContent() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor("#bbccaa")
        }
        .size({width: "100%", height: "100%"})
        .tabBar("联系人")

        TabContent() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor("#ccaabb")
        }
        .size({width: "100%", height: "100%"})
        .tabBar("动态")
      }
      .size({width: "100%", height: "100%"})
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}