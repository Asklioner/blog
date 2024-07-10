import {CardItemInterface} from './CardListModel'

export class CardItem implements CardItemInterface {
  icon: ResourceStr;
  name: string;
  authorType: string;
  content: string;
  commentList: [] = [];

  constructor(card: CardItemInterface) {
    this.icon = card.icon;
    this.name = card.name;
    this.authorType = card.authorType;
    this.content = card.content;
    this.commentList = card.commentList;
  }
}