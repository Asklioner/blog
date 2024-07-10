import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import {CommonConstants} from '../entryability/CommonConstants'
import {CardItemInterface} from '../models/CardListModel'
import { CardItem } from '../models/CardViewModel'
import { WaterFlowDataSource } from '../entryability/WaterFlowDataSource'
import { http } from '@kit.NetworkKit';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';


@CustomDialog
struct exchangeUsername{
  confirm?: (username?: string) => void
  controller?: CustomDialogController
  username?: string

  build() {
    Column({space: 10}){
      TextInput({placeholder: '请输入用户名'}).onChange((value) => {
        this.username = value
      })
      Button('修改').onClick(() => {
        if(this.confirm){
          this.confirm(this.username)
        }
        if(this.controller){
          this.controller.close()
        }
      })
    }.margin(20)
  }
}



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
  exchangeUsername: CustomDialogController = new CustomDialogController({
    builder: exchangeUsername({
      confirm: (username?: string) => {this.onConfirm(username)}
    })
  })
  @State icon: Resource = $r('app.media.icon')
  @State username: string = '123'

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

  onConfirm(username?: string){
    let httpRequest = http.createHttp()
    httpRequest.request(
      '/user',
      {
        method: http.RequestMethod.PUT,
        header: {
          'Content-Type': 'multipart/form-data',
        },
        multiFormDataList: [
          {
            name: "name",
            contentType: 'text/plain',
            data: username,
          }
        ],
      },
      (err, data) => {
        if(!err){
          promptAction.showToast({
            message: '修改成功',
            duration: 2000
          });
        }else{
          promptAction.showToast({
            message: '修改失败',
            duration: 2000
          });
        }
      }
    )
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
              Image(this.icon).width('30%').margin({right: 30}).onClick(() => {
                const documentSelectOptions = new picker.DocumentSelectOptions()
                documentSelectOptions.maxSelectNumber = 1
                documentSelectOptions.fileSuffixFilters = ['.png', '.jpg'];
                let uris: Array<string> = [];
                let context = getContext(this) as common.Context;
                const documentViewPicker = new picker.DocumentViewPicker(context);
                documentViewPicker.select(documentSelectOptions).then((documentSelectResult: Array<string>) => {
                  uris = documentSelectResult;
                  console.info('documentViewPicker.select to file succeed and uris are:' + uris);
                }).catch((err: BusinessError) => {
                  console.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
                })
                let file = fs.openSync(uris[0], fs.OpenMode.READ_ONLY)
                let buffer = new ArrayBuffer(4096 * 4)
                let readLen = fs.readSync(file.fd, buffer)
                fs.closeSync(file)
                let httpRequest = http.createHttp()
                httpRequest.request(
                  '/user',
                  {
                    method: http.RequestMethod.PUT,
                    header: {
                      'Content-Type': 'multipart/form-data',
                    },
                    multiFormDataList: [
                      {
                        name: "icon",
                        contentType: 'text/plain',
                        data: readLen,
                      }
                    ],
                  }
                )
              })
              //Text(this.CardItem.name).fontSize(40).margin({top: 20})
              Text(this.username).fontSize(40).margin({top: 20}).onClick(() => {
                this.exchangeUsername.open()
              })
            }.margin(20)


            TextInput({placeholder: '旧密码'}).onChange((value: string) => {
              this.oldPassword = value
            })
            TextInput({placeholder: '新密码'}).onChange((value: string) => {
              this.newPassword = value
            })
            Button('修改密码').onClick(() => {
              let httpRequest = http.createHttp()
              httpRequest.request(
                '/user/password',
                {
                  method: http.RequestMethod.PUT,
                  //要加用户名
                  extraData: this.newPassword

                },
                (err: BusinessError, data: http.HttpResponse) => {
                  if(!err){
                    promptAction.showToast({
                      message: '修改成功',
                      duration: 2000
                    });
                    httpRequest.destroy()
                  }else{
                    promptAction.showToast({
                      message: '修改失败',
                      duration: 2000
                    });
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