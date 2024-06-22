import router from '@ohos.router'
import { HeaderNav } from '../components/HeaderNav'
import { Params } from '../model/RouteParamsModel'

@Entry
@Component
struct ImageSpanInText {
  title: string = (router.getParams() as Params).title
  @State message: string = 'Hello World'
  @State count: number = 0

  build() {
    Column() {
      HeaderNav({ title: this.title })
      Text() {
        ImageSpan($r('app.media.zfb_tab_money'))
          .width(30)
          .verticalAlign(ImageSpanAlignment.CENTER)
        Span(this.message)
      }
      .fontSize(30)
      .fontWeight(FontWeight.Bold)

      Row() {
        Button('-')
          .onClick(() => {
            if (this.count > 1) {
              this.count--
            } else {
              AlertDialog.show({
                message: '再少就没有了',
                autoCancel: false,
                alignment: DialogAlignment.Center,
                // confirm: {
                //   enabled: true,
                //   value: '了解',
                //   style: DialogButtonStyle.HIGHLIGHT,
                //   action: () => {
                //   },
                // }
                buttons: [
                  {
                    enabled: true,
                    value: '了解',
                    style: DialogButtonStyle.HIGHLIGHT,
                    action: () => {
                    },
                  },
                  {
                    enabled: true,
                    value: '哦了',
                    style: DialogButtonStyle.HIGHLIGHT,
                    action: () => {
                    },
                  }
                ]
                // gridCount: 3
              })
            }
          })
        Text(this.count.toString())
        Button('+')
          .onClick(() => {
            this.count++
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}