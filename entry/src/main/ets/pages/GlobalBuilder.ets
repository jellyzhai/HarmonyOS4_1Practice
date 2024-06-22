import router from '@ohos.router'
import { HeaderNav } from '../components/HeaderNav'
import { Params } from '../model/RouteParamsModel'

@Entry
@Component
struct GlobalBuilder {
  title: string = (router.getParams() as Params).title
  @State message: string = 'Hello World'

  // 内部函数组件，内部建议使用this, 而不是参数
  @Builder InnerText() {
    Text(this.message)
      .fontColor(Color.Blue)
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)

      this.InnerText()

      Button('修改文本')
        .onClick(() => {
          this.message = 'de a mou'
        })

      TextBuilder({ text: this.message })
    }
    .width('100%')
    .height('100%')
  }
}

interface TextBuilderParams {
  text: string
}

// 参数必须是引用传参，内部UI才会更新, 推荐形参使用 $$
// 全局函数组件，内部不建议使用 this，而是参数
// 函数组件内部不能修改参数值，否则会报错
@Builder
function TextBuilder($$: TextBuilderParams) {
  Text($$.text)
    .fontSize(25)
    .fontColor(Color.Green)
    .onClick(() => {

      // $$.text = 'test'
    })

  TextComponent({ text: $$.text })
}

@Component
struct TextComponent {
  @Prop text: string

  build() {
    Text(this.text)
      .fontSize(20)
      .fontColor(Color.Orange)
  }
}