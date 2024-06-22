import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';

@Entry
@Component
struct LoopPlaySwiper {
  title: string = (router.getParams() as Params).title
  swiperController = new SwiperController();

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title })

      Swiper(this.swiperController) {
        ForEach([1, 2, 3, 4], (item: number) => {
          Text(item.toString())
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .backgroundColor(`rgba(${item*50}, 0, ${item*50}, ${(item + 1) / 10})`)
        })
      }
      // .autoPlay(true)
      // .interval(500)
      // .displayArrow(true)
      // .vertical(true)
      // .displayMode(SwiperDisplayMode.AUTO_LINEAR)
      // .itemSpace(100) // 2张卡片之间 在滑动时 显示的距离
      // .effectMode(EdgeEffect.Fade)
      // .disableSwipe(true)
      .indicator(new DotIndicator().itemWidth(20).color(Color.Brown))
      .displayArrow({
        showBackground: true,
        backgroundColor: 'rgba(0,0,0,0.1)'
      })
      .duration(300)
      .curve(Curve.Smooth)
      .onChange((index: number) => {
        console.log('LoopPlaySwiper onChange index', index)
      })

      Row() {
        Button('pre')
          .onClick(() => {
            this.swiperController.showPrevious()
          })
        Button('next')
          .onClick(() => {
            this.swiperController.showNext()
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}