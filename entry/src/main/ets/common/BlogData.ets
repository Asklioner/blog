export class  Card {
  id?: number;
  icon?:string;
  author?:string;
  title?: string;
  authorId?: number;
  content?: string;
  likeCount?: number;
  commentCount?: number;
  createTime?: string;
  updateTime?: string;
}

export class  CardListData extends Card {
  list?: Card[];
  constructor(list:Card[]) {
    super()
    this.list = list
  }
}



