import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct BindContextMenu {
  // title: string = (router.getParams() as Params).title
  title: string = (router.getParams() as Record<string, string>).title

  @Builder
  MenuBuilder() {
    List({ space: 16 }) {
      ListItem() {
        Text('分享')
          .textStyle()
          .onClick(() => {
            promptAction.showToast({ message: '点击了 ·分享·', duration: 3000 })
          })
      }

      ListItem() {
        Text('收藏')
          .textStyle()
          .onClick(() => {
            promptAction.showToast({ message: '点击了 ·收藏·', duration: 3000 })
          })
      }
    }
    .width('25%')
    .divider({
      strokeWidth: 1,
      color: 'rgba(0,0,0,0.2)',
      // startMargin: 16,
      // endMargin: 16
    })
    .padding(16)
    .onAppear(() => {
      promptAction.showToast({ message: '显示上下文菜单' })
    })
    .onDisAppear(() => {
      promptAction.showToast({ message: '隐藏上下文菜单' })
    })
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title, confirmInfoBeforeBack: '确认要离开么？' })

      Text('长按以下图片，尝试更多功能')
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(Color.Blue)
        .fontColor(Color.White)
        .padding(10)

      Image($r('app.media.ms_desktop'))
        .width(300)
        .bindContextMenu(this.MenuBuilder, ResponseType.LongPress)
    }
    .width('100%')
    .height('100%')
  }
}


@Extend(Text)
function textStyle(size: number = 18) {
  .fontSize(size)
  .fontWeight(400)
}