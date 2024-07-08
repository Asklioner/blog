import {CardItem} from './CardViewModel'
import {CardItemInterface, CARD_LIST} from './CardListModel'


export class CardArray {
  cardArray: CardItem[] = [];

  constructor() {
    CARD_LIST.forEach((item: CardItemInterface, index: number) => {
      this.cardArray.push(new CardItem(item, index));
    });
  }

  getInstance() {
    return this;
  }
}

export default new CardArray();