import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';

@Entry
@Component
struct GridCellLayout {
  title: string = (router.getParams() as Params).title
  rowGridScroller = new Scroller()

  onPageShow(): void {
    this.rowGridScroller.scrollToIndex(2, true, ScrollAlign.CENTER)
    // this.rowGridScroller.scrollTo({ xOffset: 350, yOffset: 0, animation: { duration: 1500 } })
  }

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title })

      Scroll() {
        Column({ space: 10 }) {
          // Grid(null, { regularSize: [100, 50] }) {
          Grid() {
            // GridItem({style: GridItemStyle.PLAIN}) {
            GridItem() {
              Text('111')
            }
            .backgroundColor('#c18000')
            .rowStart(0)
            .rowEnd(2)
            .columnStart(0)
            .columnEnd(1)

            GridItem() {
              Text('222')
            }
            .backgroundColor('#c18000')
            .rowStart(3)
            .rowEnd(4)
            .columnStart(0)
            .columnEnd(2)

            GridItem() {
              Text('333')
            }
            .backgroundColor('#c18000')
            .rowStart(2)
            .rowEnd(4)
            .columnStart(3)
            .columnEnd(4)

            GridItem() {
              Text('444')
            }
            .backgroundColor('#c18000')
            .rowStart(0)
            .rowEnd(1)
            .columnStart(2)
            .columnEnd(4)
          }
          .width(310)
          .height(310)
          .backgroundColor(Color.Black)
          .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
          // .layoutDirection(GridDirection.Row)
          .rowsGap(10)
          .columnsGap(10)

          Grid(this.rowGridScroller) {
            ForEach([1, 2, 3, 4, 5], (item: number) => {
              GridItem() {
                Text(item.toString())
              }
              .backgroundColor(Color.White)
              .width(200)
            })
          }
          .height(100)
          .backgroundColor(Color.Gray)
          .padding(10)
          .rowsTemplate('1fr')
          // .columnsTemplate([1,2,3,4,5].reduce(pre => pre + '1fr ', ''))
          .columnsGap(10)
        }
        .height('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}