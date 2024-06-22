import { HeaderNav } from '../components/HeaderNav';
import router from '@ohos.router';
import { Params } from '../model/RouteParamsModel';

@Observed
class TasteTableware {
  text: string;
  checked: boolean = false;

  constructor(text: string) {
    this.text = text
  }
}

@Entry
@Component
struct HalfScreenModal {
  title: string = (router.getParams() as Params).title
  @State @Watch('onModalHide') isShow: boolean = false
  @State tastes: TasteTableware[] = [
    new TasteTableware('不要辣'),
    new TasteTableware('少放辣'),
    new TasteTableware('多加饭'),
    new TasteTableware('不需要米饭'),
    new TasteTableware('不需要餐具'),
    new TasteTableware('需要餐具'),
  ];

  @Builder
  HalfModalBuilder() {
    Column({space: 10 }) {
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.tastes, (item: TasteTableware) => {
          HalfModalSelectableBtn({ taste: item })
        })
      }
      .padding(16)

      Button('确认')
        .onClick(() => {
          this.isShow = !this.isShow
        })
    }
    .padding({bottom: 16})
  }

  onModalHide() {
    if (!this.isShow) {
      AlertDialog.show({
        autoCancel: false,
        message: `您选择了 ${JSON.stringify(this.tastes.filter(item => item.checked).map(item => item.text))}`,
        confirm: {
          enabled: true,
          action: () => {
          },
          value: '确认'
        }
      })
    }
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Row() {
        Text('请选择口味和餐具')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Text('>')
          .fontColor(Color.Gray)
          .fontSize(18)
          .scale({ y: 1.2 })
      }
      .width('94%')
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(10)
      .justifyContent(FlexAlign.SpaceBetween)
      .bindSheet(this.isShow, this.HalfModalBuilder(), {
        showClose: false,
        maskColor: 'rgba(0,255,255, 0.5)',
        backgroundColor: Color.Pink,
        title: {
          title: '请选择口味和餐具'
        },
        detents: [SheetSize.FIT_CONTENT, SheetSize.MEDIUM, SheetSize.LARGE], //只有这样定义，拖动条才显示出来
        shouldDismiss: (sheetDismiss: SheetDismiss) => {
          // 点击遮罩背景调用，暂时没发现有啥用
          console.log('点击遮罩背景：', JSON.stringify(sheetDismiss))
        },
        onAppear: () => {
          // 没有别调用
          console.log('模态框显示了')
        }
        // enableOutsideInteractive: false, // 是否允许模态框外部内容，允许交互
        // height: SheetSize.FIT_CONTENT, // 默认为 适用内容的高度
        // blurStyle: BlurStyle.COMPONENT_ULTRA_THICK, // 可以控制模态框背景
        // dragBar: false, // 看不出效果
        // preferType: SheetType.POPUP, // 没看出效果
      })
      .onClick(() => {
        this.isShow = !this.isShow
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0,0,0,0.1)')
  }
}


@Component
struct HalfModalSelectableBtn {
  @ObjectLink taste: TasteTableware

  build() {
    Button(this.taste.text)
      .margin({ right: 8, bottom: 8 })
      .backgroundColor(this.taste.checked ? Color.Green : Color.Gray)
      .fontColor(Color.White)
      .onClick(() => {
        this.taste.checked = !this.taste.checked
      })
  }
}