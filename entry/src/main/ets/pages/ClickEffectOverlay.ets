import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';

interface ClickedTimesParams {
  times: number
}

@Entry
@Component
struct ClickEffectOverlay {
  title: string = (router.getParams() as Params).title
  @State clickedTimes: number = 0

  @Builder
  OverlayForBtn($$: ClickedTimesParams) {
    Stack() {
      Circle({ width: 18, height: 18 })
        .fill(Color.Red)

      Text($$.times > 9 ? `9+` : $$.times.toString())
        .width(18)
        .textAlign(TextAlign.Center)
        .fontSize(14)
        .fontColor(Color.White)
    }
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Button('点击测试 ClickEffect')
        .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.7 })
        .overlay(this.OverlayForBtn({ times: this.clickedTimes }), { align: Alignment.TopEnd, offset: { x: 4, y: -4 } })
        .onClick(() => {
          this.clickedTimes++
        })
    }
    .width('100%')
    .height('100%')
  }
}