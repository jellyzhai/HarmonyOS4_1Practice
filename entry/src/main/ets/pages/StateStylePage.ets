import router from '@ohos.router'
import { HeaderNav } from '../components/HeaderNav'
import { Params } from '../model/RouteParamsModel'

@Entry
@Component
struct StateStylePage {
  title: string = (router.getParams() as Params).title
  @State message: string = 'Hello World'
  @State enabledText: boolean = true

  @Styles
  normalStyle() {
    .backgroundColor(Color.Blue)
  }

  @Styles
  pressedStyle() {
    .backgroundColor(Color.Orange)
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .copyOption(CopyOptions.LocalDevice)
        .focusable(true)
        // .selection(1,5)
        .fontColor(Color.Black)
        .stateStyles({
          normal: {
            .fontStyle(FontStyle.Normal)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
            .border({ width: 0 })
            .fontColor(Color.Black)
          },
          disabled: {
            // 直接就显示禁用样式
            // .fontStyle(FontStyle.Italic)
          },
          pressed: {
            // 直接就显示按压样式
            // .fontSize(30)
          },
          focused: {
            .border({ width: 1 })
            .borderRadius(10)
          },
          selected: {
            // 没实现效果
            // .backgroundColor(Color.Black)
            // .fontColor(Color.Pink)
          }
        })
        .enabled(this.enabledText)

      Button('切换禁用文本')
        .stateStyles({
          normal: this.normalStyle,
          pressed: this.pressedStyle,
        })
        .onClick(() => {
          this.enabledText = !this.enabledText
        })
    }
    .width('100%')
    .height('100%')
  }
}
