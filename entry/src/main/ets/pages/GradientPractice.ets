import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';

@Entry
@Component
struct GradientPractice {
  title: string = (router.getParams() as Params).title
  @State message: string = 'Hello World';

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })
        // .geometryTransition(this.title, {follow: true}) // 几何过度效果, 暂无效果

      Row()
        .width('90%')
        .height(100)
        .borderWidth(1)
        .linearGradient({
          // angle: 25, // 和方向只能设置一个
          direction: GradientDirection.RightBottom,
          // colors: [[Color.Transparent, 0.45], [Color.Green, 0.5], [Color.Transparent, 0.55]],
          colors: [[Color.Red, 0.25], [Color.Green, 0.5], [Color.Blue, 1]],
          // repeating: true
        })

      Row()
        .width('90%')
        .height(100)
        .borderWidth(1)
        .radialGradient({
          center: ['50%', '50%'],
          radius: 100,
          colors: [[Color.Black, 0.2], [Color.Blue, 0.4], [Color.Brown, 0.6], [Color.Green, 0.8]],
          repeating: true
        })
        // .sphericalEffect(1) // 为全球面效果

      Row()
        .width(300)
        .height(300)
        .borderRadius(150)
        .sweepGradient({
          center: ['50%', '50%'],
          // rotation: 90,
          start: 0,
          end: 360,
          repeating: true,
          colors: [[Color.Red, 0.1], [Color.Green, 0.2], [Color.Blue, 0.3]]
        })
        // .backgroundBrightness({rate: 5, lightUpDegree: 10})
    }
    .width('100%')
    .height('100%')
  }
}