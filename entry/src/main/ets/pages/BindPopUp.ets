import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

@Entry
@Component
struct BindPopUp {
  title: string = (router.getParams() as Params).title
  @State isPopUpShow: boolean = false

  @Builder
  PopUpBuilder() {
    Column({ space: 12 }) {
      Text('提示')
        // .width('100%')
        .backgroundColor(Color.Gray)
        .fontColor(Color.White)
        .fontSize(18)
        .fontWeight(700)

      Text('这是提示内容')
    }
    .padding(10)
    .backgroundColor(Color.Orange)
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Text() {
        Span('点击问号，显示帮助提示')

        ImageSpan($r('app.media.question_mark'))
          .width(20)
          .onClick(() => {
            this.isPopUpShow = !this.isPopUpShow
          })
          .bindPopup(this.isPopUpShow, {
            builder: this.PopUpBuilder(),
            radius: 8,
            targetSpace: 4, // 弹框距离目标的距离
            popupColor: Color.Pink,
            maskColor: Color.Pink,
            onStateChange: (event) => {
              this.isPopUpShow = event.isVisible
            }
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}