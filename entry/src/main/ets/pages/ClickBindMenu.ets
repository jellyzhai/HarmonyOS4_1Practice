import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ClickBindMenu {
  title: string = (router.getParams() as Params).title
  @State isMenuShow: boolean = false;

  @Builder
  MenuBuilder() {
    List({ space: 8 }) {
      ListItem() {
        Text('KTV')
          .textStyle()
      }

      ListItem() {
        Text('剧本杀')
          .textStyle()
      }
    }
    .divider({
      strokeWidth: 1,
      color: Color.Gray,
      // startMargin: 16,
      // endMargin: 16
    })
    .padding(16)
    .borderRadius(8)
    // .shadow(ShadowStyle.OUTER_DEFAULT_XS) // 会导致弹框边缘有2层的效果
    .onDisAppear(() => {
      this.isMenuShow = false
    })
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Row() {
        Text('美食')
          .textStyle()
        Text('电影')
          .textStyle()
        Text('旅游')
          .textStyle()
        Column({ space: 4 }) {
          Image($r('app.media.menu'))
          .width(18)
          .fillColor(Color.White)
          // Text('...')
          //   .textAlign(TextAlign.Start)
          //   .fontColor(Color.White)
          //   .fontWeight(700)

          Text('更多功能')
            .textStyle(16)
        }
        .bindMenu(
          this.isMenuShow,
          this.MenuBuilder,
          // [
          //   {
          //     value: 'KTV',
          //     action: () => {
          //       promptAction.showToast({ message: '点击了菜单：KTV' })
          //     }
          //   },
          //   {
          //     value: '剧本杀',
          //     action: () => {
          //       promptAction.showToast({ message: '点击了菜单：剧本杀' })
          //     }
          //   },
          // ],
          // {
          //   title: '更多功能',
          //   // showInSubWindow: true
          // }
        )
        .onClick(() => {
          this.isMenuShow = !this.isMenuShow
        })
      }
      .backgroundColor(Color.Orange)
      .width('100%')
      .padding(8)
      .borderRadius(6)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}

@Extend(Text)
function textStyle(size: number = 18) {
  .fontSize(size)
  .fontWeight(400)
  .fontColor(Color.Gray)
}