import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

interface OHAbility {
  text: string;
  color: string
}

@Entry
@Component
struct OtherPractice {
  title: string = (router.getParams() as Params).title
  @State selectAllHabit: boolean = false
  @State message: string = 'Hello World';
  @State inputStr: string = '';
  @State abilities: Array<OHAbility> = [
    { text: 'arkUI', color: 'rgba(255,255,0,1)' },
    { text: 'arkTS', color: 'red' },
    { text: 'arkTS', color: 'green' },
    { text: '元服务', color: 'blue' },
    { text: '权限控制', color: 'green' }]

  getFilteredResult() {
    return this.abilities.filter(item => item.text.toLowerCase()
      .includes(this.inputStr.toLowerCase()));
  }

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title })

      Scroll() {
        Column({ space: 20 }) {
          Image($r('app.media.icon'))
            .width(300)
            .border({width: 1})
            // .fitOriginalSize(true)
            // .fillColor('red')
            // .objectFit(ImageFit.Contain)
            .renderMode(ImageRenderMode.Template)
            .interpolation(ImageInterpolation.High)

          RowSplit() {
            CheckboxGroup({ group: 'habit' })
              .selectAll(this.selectAllHabit)
              .onChange(event => {
                console.log(JSON.stringify(event))
              })
            Text('全选')
              .height(30)
              .onClick(() => {
                this.selectAllHabit = !this.selectAllHabit
              })
          }

          Row({ space: 8 }) {
            Row() {
              Checkbox({ name: 'smoking', group: 'habit' })
              Text('抽烟')
            }

            Row() {
              Checkbox({ name: 'drinking', group: 'habit' })
              Text('喝酒')
            }

            Row() {
              Checkbox({ name: 'perm', group: 'habit' })
              Text('烫头')
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          Badge({
            count: 1,
            position: BadgePosition.RightTop,
            style: {
              badgeColor: Color.Orange,
              borderColor: Color.Green,
              borderWidth: 2
            }
          }) {
            Image($r('app.media.zfb_pro_pic3'))
              .width(100)
          }

          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(Color.Brown)
            .padding(20)
            .backgroundImage($r('app.media.startIcon', ImageRepeat.XY))

          TextInput({ placeholder: '输入过滤以下字符列表' })// .type(InputType.Password)
            .onChange(value => {
              this.inputStr = value
            })

          List() {
            ForEach(this.getFilteredResult(), (item: OHAbility) => {
              ListItem() {
                Text(item.text)
              }
              .width('100%')
            })
          }
          .backgroundColor(Color.Pink)

          Text('border')
            .width('100%')
            .border({
              width: {
                bottom: 1
              },
              color: '#36D'
            })
            .padding({ bottom: 6 })
            .textAlign(TextAlign.End)

          Text('VIP')
            .padding({ top: 6, bottom: 6, left: 12, right: 12 })
            .fontColor(Color.Yellow)
            .backgroundColor(Color.Orange)
            .border({
              width: 1,
              color: Color.Yellow
            })
            .fontStyle(FontStyle.Italic)
            .shadow({ radius: 10, type: ShadowType.COLOR })
            .borderRadius({
              topLeft: 22,
              bottomRight: 22
            })

          Text('胶囊圆角')
            .width(100)
            .height(30)
            .backgroundColor(Color.Pink)
            .borderRadius(15)
            .textAlign(TextAlign.Center)

          Row() {
            Text('grandfather')
              .fontSize(20)
              .height(40)
              .backgroundColor(Color.Blue)
              .layoutWeight(2)

            Text('parent')
              .fontSize(20)
              .height(40)
              .backgroundColor(Color.Brown)
              .layoutWeight(1)

            Text('child')
              .fontSize(20)
              .height(40)
              .backgroundColor(Color.Green)
              .layoutWeight(2)
          }
          .foregroundColor('white')
          .width('100%')
          .backgroundColor(Color.Gray)

          // .sphericalEffect(1)
          // .lightUpEffect(0.8)

          Column() {
            Text('harmony ability')
              .textCase(TextCase.UpperCase)
              .fontWeight(700)

            Flex({
              wrap: FlexWrap.Wrap,
              justifyContent: FlexAlign.Center
            }) {
              ForEach(this.abilities, (item: OHAbility) => {
                Text(item.text)
                  .padding(20)
                  .margin(10)
                  .backgroundColor(item.color)
              })
            }
          }
        }
      }
      .layoutWeight(1)

      // .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}