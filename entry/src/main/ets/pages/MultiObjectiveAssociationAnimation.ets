import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';

@Entry
@Component
struct MultiObjectiveAssociationAnimation {
  title: string = (router.getParams() as Params).title
  @State fontColor: Color = Color.White;
  @State fontWeight: number = 400;
  @State scaleSize: number = 1;
  @State translateX: number = 30;
  @State rotateAngle: number = 45;
  @State colors: [string, number][] = [['red', 0.2], ['black', 1]];
  danceStrings: string = '大家嗨起来'

  onPageShow(): void {
    this.scaleSize = 1.3
    this.translateX = -30
    this.rotateAngle = -45
    this.fontWeight = 700
    this.fontColor = Color.Orange
    this.colors = [['black', 0.2], ['red', 1]]
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      ForEach(this.danceStrings.split(''), (item: string, index: number) => {
        Text(item)
          .fontSize(30)
          .fontWeight(this.fontWeight)
          .fontColor(this.fontColor)
          .borderRadius(5)
          .padding(5)
          // .rotate({ angle: this.rotateAngle })
          .scale({ x: this.scaleSize, y: this.scaleSize })
          .translate({ x: this.translateX })
          .linearGradient({ angle: 90, colors: this.colors })
          // 动画之间的延时间距 = duration / 动画数量
          .animation({
            duration: 2000,
            delay: 400 * (index + 1),
            tempo: 2.5,
            playMode: PlayMode.Alternate,
            iterations: -1
          })
      })

    }
    .width('100%')
    .height('100%')
  }
}