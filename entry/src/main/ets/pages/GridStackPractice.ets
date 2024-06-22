import router from '@ohos.router'
import { HeaderNav } from '../components/HeaderNav'
import { Card, Params } from '../model/RouteParamsModel'

@Entry
@Component
struct GridStackPractice {
  title: string = (router.getParams() as Params).title
  placeholderCardUrl = [
    $r('app.media.bg_00'),
    $r('app.media.bg_01'),
    $r('app.media.bg_02'),
    $r('app.media.bg_03'),
    $r('app.media.bg_04'),
    $r('app.media.bg_05'),
  ]
  @State pickedCardIndex: number = -1
  @State hasPickedPrize: boolean = false
  @State cardUrls: Array<Resource> = [
    $r('app.media.img_00'),
    $r('app.media.img_01'),
    $r('app.media.img_02'),
    $r('app.media.img_03'),
    $r('app.media.img_04'),
    $r('app.media.img_05'),
  ]
  @State cards: Array<Card> = [
    {
      url: null,
      count: 0
    },
    {
      url: null,
      count: 0
    },
    {
      url: null,
      count: 0
    },
    {
      url: null,
      count: 0
    },
    {
      url: null,
      count: 0
    },
    {
      url: null,
      count: 0
    },
  ]

  getPickedCardIndex() {
    this.pickedCardIndex = Math.floor(Math.random() * 6)
    return this.pickedCardIndex
  }

  updateCards = () => {
    this.cards[this.pickedCardIndex] = {
      url: this.cardUrls[this.pickedCardIndex],
      count: this.cards[this.pickedCardIndex].count + 1
    }

    this.hasPickedPrize = this.cards.every(card => card.count > 0)

    this.pickedCardIndex = -1
  }
  
  onceMore = () => {
    this.cards = this.cards.map(() => ({ url: null, count: 0 } as Card))
    this.hasPickedPrize = false
  }

  // 按值传递参数时，如果参数时状态变量，变化时，不会更新页面；除非使用字面量对象(按引用)传递
  @Builder
  PopupMaskDialog(title: string, img: Resource, btnText: string, callback: () => void) {
    Column({ space: 20 }) {
      Text(title)
        .fontSize(25)
        .fontColor(Color.White)

      Image(img)
        .width(200)

      Button(btnText)
        .backgroundColor(Color.Transparent)
        .fontSize(Color.White)
        .border({
          width: 2,
          color: Color.White
        })
        .onClick(() => {
          callback()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0,0,0,0.8)')
    .justifyContent(FlexAlign.Center)
    .transition(TransitionEffect.scale({ x: 0, y: 0 })
      .animation({ duration: 300, curve: Curve.ExtremeDeceleration })
      .combine(TransitionEffect.OPACITY))
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      Stack() {
        Column() {
          Grid() {
            ForEach(this.cards, (item: Card, index: number) => {
              GridItem() {
                Stack() {
                  Image(item.url)
                    .width(80)
                    .visibility(item.count > 1 ? Visibility.Visible : Visibility.Hidden)
                    .borderRadius(10)

                  if (item.count === 0) {
                    Image(this.placeholderCardUrl[index])
                      .width(80)
                      .borderRadius(10)
                  } else {
                    if (item.count === 1) {
                      Image(item.url)
                        .width(80)
                        .borderRadius(10)
                        .transition(TransitionEffect.rotate({ y: 1, angle: -90 }).animation({ duration: 500 }))
                    } else {

                      Badge({
                        count: item.count,
                        style: {}
                      }) {
                        Image(item.url)
                          .width(80)
                          .borderRadius(10)
                          .transition(TransitionEffect.translate({ y: '-100%' })
                            .animation({ duration: 1000 })
                            .combine(TransitionEffect.OPACITY.animation({ duration: 300 })))
                      }
                    }
                  }
                }
              }
            })
          }
          .height(320)
          .rowsTemplate('1fr 1fr')
          .columnsTemplate('1fr 1fr 1fr')

          Button('立即抽卡')
            .width(200)
            .backgroundColor(Color.Brown)
            .clickEffect({ level: ClickEffectLevel.MIDDLE })
            .onClick(() => {
              this.getPickedCardIndex()
            })
        }
        .justifyContent(FlexAlign.Center)
        .height('100%')

        if (this.pickedCardIndex >= 0) {
          this.PopupMaskDialog('获得生肖卡', this.cardUrls[this.pickedCardIndex], '开心收下', this.updateCards)
        }

        if (this.hasPickedPrize) {
          this.PopupMaskDialog('恭喜获得大奖', $r('app.media.hw'), '再来一次', this.onceMore)
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}