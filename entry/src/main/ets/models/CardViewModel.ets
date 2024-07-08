import {CommentItemInterface, CommentItem } from "./CommentViewModel"
import {CardItemInterface} from './CardListModel'
import {COMMENT_LIST} from './CommentModel'
import {PICTURE_ARRAY_LIST } from './PictureArrayModel'

export class CardItem implements CardItemInterface {
  icon: ResourceStr;
  name: ResourceStr;
  authorType: ResourceStr;
  content: ResourceStr;
  pictureArray: Resource[] = [];
  commentList: CommentItem[] = [];

  constructor(card: CardItemInterface, index: number) {
    this.icon = card.icon;
    this.name = card.name;
    this.authorType = card.authorType;
    this.content = card.content;
    this.pictureArray = PICTURE_ARRAY_LIST[index % PICTURE_ARRAY_LIST.length];

    COMMENT_LIST.forEach((item: CommentItemInterface) => {
      this.commentList.push(new CommentItem(item));
    });
  }
}