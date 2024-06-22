import { AlertDialog } from '@ohos.arkui.advanced.Dialog';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

interface Person {
  name: string;
  age: number;
}

interface Address {
  city: string;
}

interface PersonWithAddress extends Person {
  address: Address
}

interface CountBuilderParams {
  count: number
}

@Entry
@Component
struct ParentChildParamsTransmission {
  title: string = (router.getParams() as Params).title
  @State count: number = 0;
  @State person: Person = { name: 'jelly', age: 31 };
  @State personWithAddress: PersonWithAddress = { name: 'jelly', age: 31, address: { city: 'Beijing' } };

  @Builder
  // 直接传递非引用值，父组件变化 不会触发 Builder 组件更新
  // CountBuilder(count: number) {

  // 改用 引用对象的方式传递，父组件变化 可以触发 Builder 组件更新
  CountBuilder($$: CountBuilderParams) {
    Column() {
      Text('CountBuilder 中改用 引用对象的方式传递，父组件变化 可以触发 Builder 组件更新')
        .fontColor(Color.White)
      Text('CountBuilder 中接受的数据')
      Text('数量：' + $$.count)
    }
    .padding(8)
    .borderRadius(4)
    .backgroundColor(Color.Gray)
  }

  aboutToAppear(): void {
    // 需要再模拟器 或真机中才有效，否则会报错
    getContext(this).resourceManager.getStringValue($r('app.string.module_desc').id, (err, str) => {
      console.log('test_tag', JSON.stringify(err)) // test_tag "[PC Preview] unknown type"
      console.log('test_tag', str)
    })
  }

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title })

      Scroll() {
        Column({ space: 10 }) {
          Column({ space: 10 }) {
            Button('父组件中点击改变 非引用值')
              .onClick(() => this.count++)

            Text('数量：' + this.count)

            NonReferenceChildComp({ count: $count })

            this.CountBuilder({ count: this.count })
            // this.CountBuilder(this.count)
          }
          .backgroundColor(Color.Pink)
          .padding(10)
          .borderRadius(5)

          Column({ space: 10 }) {
            Text('1层引用值,可更新页面')
            Button('父组件中点击改变 引用值年龄')
              .onClick(() => this.person.age++)

            Grid() {
              GridItem() {
                Text('名称')
                  .fontWeight(700)
              }

              GridItem() {
                Text('年龄')
                  .fontWeight(700)
              }

              GridItem() {
                Text(this.person.name)
              }

              GridItem() {
                Text(this.person.age.toString())
              }
            }
            .rowsTemplate('1fr 1fr')
            .columnsTemplate('1fr 1fr')
            .backgroundColor('rgba(0,0,0,0.1)')
            .height(70)

            ReferenceChildComp({ person: this.person })
          }
          .backgroundColor(Color.Pink)
          .padding(10)
          .borderRadius(5)

          Column({ space: 10 }) {
            Text('第2层引用值，不能更新页面。使用@Observed装饰需传递的class, 将其实例化数据，作为嵌套的第2层引用数据，只将第2层数据传递给自定义component组件，该组件内使用@objectLink装饰传递的数据')

            Column() {
              TextInput({ text: this.personWithAddress.address.city, placeholder: '输入城市名' })
                .backgroundColor('rgba(0,0,0,0.2)')
                .onChange(value => this.personWithAddress.address.city = value)

              Text('输入改变城市名')
                .width('100%')
                .fontSize(14)
                .fontColor(Color.Gray)
            }


            Grid() {
              GridItem() {
                Text('名称')
                  .fontWeight(700)
              }

              GridItem() {
                Text('城市')
                  .fontWeight(700)
              }

              GridItem() {
                Text(this.personWithAddress.name)
              }

              GridItem() {
                Text(this.personWithAddress.address.city)
              }
            }
            .rowsTemplate('1fr 1fr')
            .columnsTemplate('1fr 1fr')
            .backgroundColor('rgba(0,0,0,0.1)')
            .height(70)
          }
          .backgroundColor(Color.Pink)
          .padding(10)
          .borderRadius(5)
        }
        // .height('100%') // 如果设置这个高度，就跟父容器 scroll 一样高，没有超出高的部分，就不会有滚动
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.On)
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
  }
}

@Component
struct NonReferenceChildComp {
  @Link count: number

  build() {
    Button('子组件中点击改变 非引用值')
      .onClick(() => this.count++)
  }
}

@Component
struct ReferenceChildComp {
  @Link person: Person

  build() {
    Column({ space: 10 }) {
      Text('子组件')

      TextInput({ placeholder: '输入改变父组件中的引用数据', text: this.person.name })
        .backgroundColor('rgba(0,0,0,0.2)')
        .onChange(value => this.person.name = value)

      Button('子组件中点击改变 引用值年龄')
        .onClick(() => this.person.age++)
    }
    .padding(10)
    .borderRadius(5)
    .backgroundColor(Color.Orange)
  }
}