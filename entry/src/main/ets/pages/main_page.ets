// Second.ets
import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import { WaterFlowDataSource } from '../entryability/WaterFlowDataSource'
@Entry
@Component
struct Second {
  @State minSize: number = 80
  @State maxSize: number = 180
  @State fontSize: number = 24
  @State colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]
  scroller: Scroller = new Scroller()
  dataSource: WaterFlowDataSource = new WaterFlowDataSource()
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []
  private controller: TabsController = new TabsController();

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }


  // 设置FlowItem的宽/高数组
  setItemSizeArray() {
    for (let i = 0; i < 100; i++) {
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.setItemSizeArray()
  }

  @Builder
  itemFoot() {
    Column() {
      Text(`Footer`)
        .fontSize(10)
        .backgroundColor(Color.Red)
        .width(50)
        .height(50)
        .align(Alignment.Center)
        .margin({ top: 2 })
    }
  }

  build() {
    Column() {

      Tabs({
        barPosition: BarPosition.End,
        controller: this.controller,
      }) {
        TabContent() {
          WaterFlow(){
            LazyForEach(this.dataSource,(item:number)=>{
              FlowItem() {
                Column() {
                  Text("N" + item).fontSize(12).height('16')
                  Image('res/waterFlowTest(' + item % 5 + ').jpg')
                    .objectFit(ImageFit.Fill)
                    .width('100%')
                    .layoutWeight(1)
                }
              }
            })
          }
        }
        .size({width: "100%", height: "100%"})
        .tabBar("首页")


        TabContent() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor("#bbccaa")
        }
        .size({width: "100%", height: "100%"})
        .tabBar("消息")

        TabContent() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor("#ccaabb")
        }
        .size({width: "100%", height: "100%"})
        .tabBar("我的")
      }
      .size({width: "100%", height: "100%"})
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}