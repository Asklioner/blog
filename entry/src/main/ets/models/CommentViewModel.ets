
export interface CommentItemInterface {
  icon: ResourceStr;
  name: ResourceStr;
  favorCount: number;
  content: ResourceStr;
  timePosition: ResourceStr;
  reviewCnt?: number;
  subContent?: ResourceStr;
}

export class CommentItem implements CommentItemInterface {
  icon: ResourceStr;
  name: ResourceStr;
  favorCount: number;
  content: ResourceStr;
  timePosition: ResourceStr;
  reviewCnt?: number;
  subContent?: ResourceStr;

  constructor(item: CommentItemInterface) {
    this.icon = item.icon;
    this.name = item.name;
    this.favorCount = item.favorCount;
    this.content = item.content;
    this.timePosition = item.timePosition;
    if (item?.reviewCnt) {
      this.reviewCnt = item.reviewCnt;
    }
    if (item?.subContent) {
      this.subContent = item.subContent;
    }
  }
}
