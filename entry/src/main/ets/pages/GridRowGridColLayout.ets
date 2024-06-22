import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import display from '@ohos.display';

@Entry
@Component
struct GridRowGridColLayout {
  title: string = (router.getParams() as Params).title
  @State deviceWith: number = 0
  @State message: string = 'Hello World';
  @State colors: Color[] = [
    Color.Blue, Color.Brown, Color.Gray, Color.Orange, Color.Yellow, Color.Black, Color.Blue,
    Color.Brown, Color.Gray, Color.Orange, Color.Pink, Color.Red, Color.Grey
  ]

  aboutToAppear(): void {
    // 预览器中运行，需要模拟器或真机
    this.deviceWith = px2vp(display.getDefaultDisplaySync().width)
    console.log('test_tag', display.getDefaultDisplaySync().width)
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      // 手机预览器宽度为 360vp，算是小型设备
      GridRow({
        gutter: 10,
        columns: {
          xs: 1,
          sm: 2,
          md: 3,
          lg: 4,
          xl: 5,
          xxl: 6,
        },
        // xs < 180 <= sm < 360 <= md < 800 <= lg, 对应上面 columns 中的设备列 配置
        breakpoints: { value: ['180vp', '360vp', '800vp'], reference: BreakpointsReference.ComponentSize }
      }) {
        ForEach(this.colors, (color: Color, index: number) => {
          GridCol({
            offset: {
              md: index === (this.colors.length - 1) ? 1 : 0
            },
            span: {
              // 从 sm 小型设备开始 及以上，都执行该跨列设置
              // sm: index === (this.colors.length - 1) ? 2 : null

              // 从 lg 大型设备开始 及以上，都执行该跨列设置
              lg: index === (this.colors.length - 1) ? 2 : null
            }
          }) {
            Text((index + 1).toString())
              .fontColor(Color.White)
          }
          .backgroundColor(color)
        })
      }

      Blank()

      List({ space: 16 }) {
        ListItem() {
          Text(`当前设备宽度：${this.deviceWith}，组件设置宽度370，组件超过设备宽度有滚动条`)
        }
        .backgroundColor(Color.Pink)
        .width(370)
      }
      .listDirection(Axis.Horizontal)
      .height(50)
      .backgroundColor(Color.Orange)

      Blank()

      GridRow({
        gutter: 10,
        columns: {
          xs: 1,
          sm: 2,
          md: 3,
          lg: 4,
          xl: 5,
          xxl: 6,
        }
      }) {
        GridCol() {
          Text((1).toString())
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Blue)

        GridCol() {
          Text((1).toString())
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Blue)

        GridCol() {
          Text((1).toString())
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Blue)

        GridCol() {
          Text((1).toString())
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Blue)

        GridCol({
          span: {
            sm: 2,
          },
          offset: {
            lg: 1
          }
        }) {
          Text((1).toString())
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Blue)
      }
    }
    .width('100%')
    .height('100%')
  }
}