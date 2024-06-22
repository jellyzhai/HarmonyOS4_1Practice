import router from '@ohos.router'
import { HeaderNav } from '../components/HeaderNav'
import { Params } from '../model/RouteParamsModel'

@Entry
@Component
struct StackPage {
  @State message: string = 'Hello World'
  title: string = (router.getParams() as Params).title

  build() {
    Column() {
      HeaderNav({ title: this.title })

      Stack({ alignContent: Alignment.BottomStart }) {
        Image($r('app.media.poster'))
          .width(300)
          .borderRadius({
            topLeft: 20,
            topRight: 20
          })
        Text(this.message)
          .fontSize(30)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .width(300)
          .padding({ left: 10  })
          .backgroundColor('rgba(0,0,0,0.3)')
      }
    }
    .width('100%')
    .height('100%')
  }
}