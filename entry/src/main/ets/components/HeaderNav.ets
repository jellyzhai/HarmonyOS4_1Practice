import router from '@ohos.router'

@Component
export struct HeaderNav {
  @Prop title: string
  @Prop fontColor: Color = Color.Black
  confirmInfoBeforeBack?: string

  @Builder
  cryptoBackground() {
    Stack() {
      Row() {
        Text('加密水印')
          .fontSize(10)
          .rotate({angle: 45, perspective: 1500})
          .position({x: 50, y: 5})
        Text('加密水印')
          .fontSize(10)
          .rotate({angle: 45, perspective: 1500})
          .position({x: 100, y: 10})
        Text('加密水印')
          .fontSize(10)
          .rotate({angle: 45, perspective: 1500})
          .position({x: 200, y: 15})
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Pink)
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Row() {
      Stack() {
        Text(this.title)
          .fontWeight(700)
          .fontSize(22)
          .fontColor(this.fontColor)

        Text() {
          ImageSpan($r('app.media.back_arrow'))
            .width(24)
            .position({ x: 0 })
            .zIndex(9)
            .backgroundColor(this.fontColor === Color.Black ? 'rgba(0,0,0,0.1)' : Color.Gray)
            .borderRadius(4)
            .onClick(() => {
              if (this.confirmInfoBeforeBack) {
                router.showAlertBeforeBackPage({ message: this.confirmInfoBeforeBack })
              }
              router.back()
            })
            .padding(4)
        }
        .width('100%')
      }
    }
    // 客服说，在模拟器中，可以看到下面自定义 background 效果
    .background(this.cryptoBackground(), {align: Alignment.Center})
    // .blur(0)
    // .linearGradientBlur(10, {fractionStops: [[50, 100]],direction: GradientDirection.LeftTop})
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .border({
      width: {
        bottom: 1,
      },
      color: Color.Gray
    })
  }
}
