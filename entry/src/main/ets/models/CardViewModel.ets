import {CardItemInterface} from './CardListModel'

export class CardItem implements CardItemInterface {
  icon: string;
  name: string;
  authorType: string;
  content: string;

  constructor(card: CardItemInterface) {
    this.icon = card.icon;
    this.name = card.name;
    this.authorType = card.authorType;
    this.content = card.content;
  }
}