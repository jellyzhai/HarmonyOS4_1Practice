import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

@Entry
@Component
struct FullScreenModal {
  title: string = (router.getParams() as Params).title
  @State isShowModal: boolean = false;

  @Builder
  AddPassenger() {
    List({ space: 16 }) {
      ListItem() {
        Row() {
          Text('选择乘车人')
            .fontColor(Color.White)
            .fontSize(30)
            .fontWeight(700)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.Blue)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')

      ListItem() {
        Row() {
          Checkbox()
            .shape(CheckBoxShape.ROUNDED_SQUARE)
          Text('张**')
          Text('411481********0636')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')

      ListItem() {
        Row() {
          Checkbox()
            .shape(CheckBoxShape.ROUNDED_SQUARE)
          Text('赵四')
          Text('390481********06423')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')

      ListItem() {
        Button('确认')
          .onClick(() => {
            this.isShowModal = !this.isShowModal
          })
      }
      .width('100%')
    }
    .height('100%')
    .borderRadius(10)
    .backgroundColor(Color.White)
    // .transition(TransitionEffect.translate({ y: '100%' })
    //   .animation({ duration: 500, curve: Curve.ExtremeDeceleration }))
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Text('+添加乘车人')
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Orange)
        .onClick(() => {
          this.isShowModal = !this.isShowModal
        })
    }
    .width('100%')
    .height('100%')
    // 3个参数释义：是否显示的boolean 变量；将被显示的自定义的内容封面；动画类型
    // 貌似绑定到哪个组件上 都可以
    .bindContentCover(this.isShowModal, this.AddPassenger(), ModalTransition.DEFAULT)
  }
}