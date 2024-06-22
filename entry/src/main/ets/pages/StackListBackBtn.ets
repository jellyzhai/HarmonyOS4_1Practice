import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

export interface City {
  type: string;
  names: string[];
}

@Entry
@Component
struct StackListBackBtn {
  title: string = (router.getParams() as Params).title
  scrollList = new Scroller()
  @State showBackBtn: boolean = false
  @State selectedAlphabetIndex: number = 0
  @State messages: string[] = ['Hello World', '1', '22', '333', '4444', '55555', '666666'];
  @State cities: City[] = [
    {
      type: 'A',
      names: ['阿拉善', '安阳', '安顺']
    },
    {
      type: 'B',
      names: ['北京', '保定', '蚌埠']
    },
    {
      type: 'C',
      names: ['长春', '长沙', '常德']
    },
    {
      type: 'D',
      names: ['东阳', '大连', '大理']
    },
    {
      type: 'E',
      names: ['鄂尔多斯', '恩施', '额尔古纳']
    },
    {
      type: 'F',
      names: ['福州', '佛山', '涪陵']
    },
    {
      type: 'G',
      names: ['广州', '桂林', '贵阳']
    },
    {
      type: 'H',
      names: ['黄冈', '湖州', '黑河']
    },
  ];
  @State alphabet: string[] = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  getAlphabetPopupData(letter: string): string[] {
    return this.cities.find(item => item.type === letter)?.names ?? []
  }

  @Builder
  Header(title: string) {
    Text(title)
      .fontSize(30)
      .fontWeight(700)
      .backgroundColor(Color.Pink)
      .width('100%')
      .textAlign(TextAlign.Start)
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      Stack({ alignContent: Alignment.BottomEnd }) {
        List({ space: 10, scroller: this.scrollList, initialIndex: this.selectedAlphabetIndex }) {
          ForEach(this.cities, (item: City, index: number) => {
            ListItemGroup({ header: this.Header(item.type), style: ListItemGroupStyle.CARD }) {
              ForEach(item.names, (name: string) => {
                ListItem({ style: ListItemStyle.CARD }) {
                  Text(name)
                    .fontColor(Color.Black)
                }
                .width('100%')
                .height(50)
                .align(Alignment.Start)
                .backgroundColor(`rgba(0,${index},0,0.${index + 1})`)
              })
            }
            .divider({
              strokeWidth: 1
            })
          })
        }
        // .alignListItem(ListItemAlign.Center)
        // .chainAnimtion(true)
        // .listDirection(Axis.Horizontal)
        .sticky(StickyStyle.Header)
        .divider({ strokeWidth: 1, color: Color.Brown })
        .onScrollIndex((start: number, end: number, center: number) => {
          this.selectedAlphabetIndex = start
          if (start >= 2) {
            this.showBackBtn = true
          }
          if (start === 0) {
            this.showBackBtn = false
          }
        })

        AlphabetIndexer({ arrayValue: this.alphabet, selected: this.selectedAlphabetIndex })
          .position({x: '80%', y: '20%'})
          // .alignStyle(IndexerAlign.Right)
          .itemSize(50)
          // .height('100%')
          .font({
            size: 25,
          })
          .color(Color.White)
          .selectedFont({
            size: 25,
            weight: 700
          })
          .selectedColor(Color.Pink)
          .popupBackground(0xD2B48C)
          .popupItemBackgroundColor('rgba(0,0,0,0.2)')
          .popupColor(Color.White)
          .popupSelectedColor(Color.Brown)
          .popupUnselectedColor(Color.White)
          .backgroundColor('rgba(0,0,0,0.2)')
          .borderRadius(16)
          .usingPopup(true)
          .onRequestPopupData(index => this.getAlphabetPopupData(this.alphabet[index]))
          .onSelect(alphabetIndex => {
            this.selectedAlphabetIndex = alphabetIndex
            this.scrollList.scrollToIndex(alphabetIndex, true, ScrollAlign.START)
          })
          .onPopupSelect(alphabetIndex => {
            const selectedPopupValue = this.getAlphabetPopupData(this.alphabet[this.selectedAlphabetIndex])[alphabetIndex]
            promptAction.showToast({message: selectedPopupValue})
          })

        if (this.showBackBtn) {
          Text('返回')
            .width(50)
            .height(50)
            .textAlign(TextAlign.Center)
            .backgroundColor('rgba(0,0,0,0.2)')
            .fontColor(Color.White)
            .borderRadius(25)
            .margin(20)
            .transition(TransitionEffect.OPACITY.animation({ duration: 500 })
              .combine(TransitionEffect.translate({ y: '150' })))
            .onClick(() => {
              this.scrollList.scrollToIndex(0, true)
            })
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}