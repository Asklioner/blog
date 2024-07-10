
import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import {CommonConstants} from '../entryability/CommonConstants'
import {CardItemInterface} from '../models/CardListModel'
import { CardItem } from '../models/CardViewModel'
import { WaterFlowDataSource } from '../entryability/WaterFlowDataSource'
import { http } from '@kit.NetworkKit';
@Entry
@Component
struct Second {
  @State cardItem: CardItem = new CardItem({} as CardItemInterface)
  @State minSize: number = 80
  @State maxSize: number = 180
  @State fontSize: number = 24
  @State colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]
  scroller: Scroller = new Scroller()
  dataSource: WaterFlowDataSource = new WaterFlowDataSource()
  private controller: TabsController = new TabsController();
  oldPassword?: string
  newPassword?: string

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
              LazyForEach(this.dataSource,(item:CardItem,index:number)=>{
                FlowItem() {
                  Column() {
                    Row(){
                      Row(){
                        //this.CardItem.Image
                        Image($r('app.media.icon'))
                          .width($r('app.float.blog_icon_width'))
                          .aspectRatio(1)
                          .borderRadius($r('app.float.blog_icon_br'))
                        Column(){
                          Text(item.name)
                            .fontSize($r('app.float.blog_name_fs'))
                            .fontWeight(500)
                            .height($r('app.float.blog_name_height'))
                            .fontColor('red')
                          Text(item.authorType)
                            .fontWeight(FontWeight.Normal)
                            .fontSize($r('app.float.author_type_fs'))
                            .height($r('app.float.author_type_height'))
                            .fontColor('blue')
                        }
                        .margin({ left: $r('app.float.blog_title_ml') })
                        .justifyContent(FlexAlign.Start)
                        .alignItems(HorizontalAlign.Start)
                      }
                      .justifyContent(FlexAlign.Start)
                      // Row() {
                      //   Text('关注')
                      //     .fontSize($r('app.float.follow_font_size'))
                      //     .margin({ left: $r('app.float.follow_margin_left') })
                      // }
                      // .borderRadius($r('app.float.blog_title_follow_br'))
                      // .padding({
                      //   left: $r('app.float.blog_title_padding_left'),
                      //   right: $r('app.float.blog_title_padding_left')
                      // })
                      // .width($r('app.float.blog_title_follow_width'))
                      // .height($r('app.float.blog_title_follow_height'))
                    }
                    .justifyContent(FlexAlign.SpaceBetween)
                    .width("100%")
                    .padding({
                      top: $r('app.float.card_title_padding'),
                      bottom: $r('app.float.card_title_padding')
                    })
                    Row() {
                      //this.CardItem.Comment
                      //item.content.length > 100 ? `${item.content.substring(0, 100)}...` : item.content
                      Text(item.content)
                        .fontSize(`fp`)
                        .lineHeight(`vp`)
                        .width("100%")
                        .onClick(() => {
                          //this.jumpDetail();
                        })
                        .copyOption(CopyOptions.LocalDevice)
                        .fontColor("black")
                    }
                  }
                }
                .onAppear(()=>{
                  if (index + 5 == this.dataSource.totalCount()) {
                    this.dataSource.addLastItem(this.cardItem)
                  }
                })
                .width('100%')
                .height('150')
              })
            }
        }
        .size({width: "100%", height: "100%"})
        .tabBar("博客")

        TabContent() {
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
        .size({width: "100%", height: "100%"})
        .tabBar("设置")
      }
      .size({width: "100%", height: "100%"})
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}