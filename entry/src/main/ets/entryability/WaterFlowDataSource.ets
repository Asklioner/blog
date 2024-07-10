// 实现IDataSource接口的对象，用于瀑布流组件加载数据
import {CardItemInterface} from '../models/CardListModel'
import {CardItem} from '../models/CardViewModel'
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { JSON } from '@kit.ArkTS';

// 定义 CardItem 接口
interface backCardItem {
  icon: string;
  name: string;
  authorType: string;
  content: string;
  commentList: [];
}

export class WaterFlowDataSource implements IDataSource {
  private dataArray: CardItem[] = [];
  private listeners: DataChangeListener[] = []

  constructor() {
    this.fetchDataFromBackend();
  }

  // 从后端获取数据
  private fetchDataFromBackend(): void {
    //从后端获取数据
    // let httpRequest = http.createHttp();
    // httpRequest.request(
    //   'http://192.168.5.18:8081/blog/all',
    //   {
    //     method:http.RequestMethod.GET,
    //     expectDataType: http.HttpDataType.STRING
    //   },
    //   (err:BusinessError,data:http.HttpResponse)=>{
    //     if (!err && data.resultType === http.HttpDataType.STRING) {
    //       try {
    //         let result = data.result.toString()
    //         console.log(result)
    //         let x = JSON.parse(result) as backCardItem[]
    //         const backendData:backCardItem[] = x
    //         this.dataArray = backendData
    //         console.log('Received cards:', this.dataArray)
    //         httpRequest.destroy()
    //       } catch (error) {
    //         console.error('Error parsing JSON:', error);
    //         httpRequest.destroy()
    //       }
    //     }else{
    //       httpRequest.destroy()
    //     }
    //   }
    // )
    // 模拟从后端获取数据
    const newData: CardItemInterface[] = [
      {
        icon: 'app.media.icon',
        name: '原神',
        authorType: '米哈游',
        content: '《原神》是一款全新开放世界冒险RPG。你将在游戏中探索一个被称作「提瓦特」的幻想世界。绝区0也是一款非常好玩的游戏！！！！！！！',
        commentList: [],
      },
      {
        icon: 'app.media.icon',
        name: '绝区零',
        authorType: '鹰角',
        content: '最喜欢的一集，你说得对，但是杭州电子科技大学是一款我的问题',
        commentList: [],
      },
      {
        icon: 'app.media.icon',
        name: '绝区零',
        authorType: '卡普空',
        content: '但是杭州电子科技大学是一款我的问题',
        commentList: [],
      },
      {
        icon: 'app.media.icon',
        name: '绝区零',
        authorType: '鹰角',
        content: '你说得对，但是杭州电子科技大学是一款我的问题',
        commentList: [],
      },
      {
        icon: 'app.media.icon',
        name: '绝区零',
        authorType: '鹰角',
        content: '最喜欢的一集。但是杭州电子科技大学是一款我的问题',
        commentList: [],
      },
      {
        icon: 'app.media.icon',
        name: '绝区零',
        authorType: '鹰角',
        content: '最喜欢的一集，你说得对，但是杭州电子科技大学是一款我的问题',
        commentList: [],
      },
      {
        icon: 'app.media.icon',
        name: '绝区零',
        authorType: '鹰角',
        content: '杭州电子科技大学是一款我的问题',
        commentList: [],
      },
    ];

    // 将新数据转换为 CardItem 并合并到 dataArray 中
    this.dataArray = this.dataArray.concat(newData.map(item => new CardItem(item)));
  }


  // 获取索引对应的数据
  public getData(index: number): CardItem {
    return this.dataArray[index];
  }


  // 通知控制器数据重新加载
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    });
  }


  // 通知控制器数据增加
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    });
  }

  // 通知控制器数据变化
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  // 通知控制器数据删除
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  // 通知控制器数据位置变化
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }

  //通知控制器数据批量修改
  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }

  // 获取数据总数
  public totalCount(): number {
    return this.dataArray.length
  }

  // 注册改变数据的控制器
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  // 注销改变数据的控制器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  // 增加数据
  public add1stItem(item: CardItem): void {
    this.dataArray.splice(0, 0, item);
    this.notifyDataAdd(0);
  }

  // 在数据尾部增加一个元素
  public addLastItem(item: CardItem): void {
    this.dataArray.push(item);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  // 在指定索引位置增加一个元素
  public addItem(index: number, item: CardItem): void {
    this.dataArray.splice(index, 0, item);
    this.notifyDataAdd(index);
  }

  // 删除第一个元素
  public delete1stItem(): void {
    this.dataArray.splice(0, 1)
    this.notifyDataDelete(0)
  }

  // 删除第二个元素
  public delete2ndItem(): void {
    this.dataArray.splice(1, 1)
    this.notifyDataDelete(1)
  }

  // 删除最后一个元素
  public deleteLastItem(): void {
    this.dataArray.splice(-1, 1)
    this.notifyDataDelete(this.dataArray.length)
  }

  // 在指定索引位置删除一个元素
  public deleteItem(index: number): void {
    this.dataArray.splice(index, 1)
    this.notifyDataDelete(index)
  }

  // 重新加载数据
  public reload(): void {
    this.fetchDataFromBackend();
    this.notifyDataReload()
  }
}