import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

@Observed
class PersonHeader {
  name: string = 'name'
  age: string = 'age'
}

@Observed
class Person {
  id: string;
  name: string;
  age: number;

  constructor(name: string, age: number) {
    // 结果一直是空字符串
    // this.id = util.generateRandomUUID()
    // console.log('this.id', JSON.stringify(this.id))
    this.id = Math.random().toString()
    this.name = name
    this.age = age
  }
}

@Entry
@Component
struct ObjectLinkPage {
  title: string = (router.getParams() as Params).title
  @State message: string = 'Hello World';
  @Provide persons: Person[] = [
    new Person('jack', 57),
    new Person('jelly', 31),
    new Person('mike', 21),
    new Person('henry', 35),
  ]
  deletePerson = (index: number) => {
    this.persons.splice(index, 1)
  }
  updatePerson = (index: number, person: Person) => {
    this.persons.splice(index, 1, new Person(person.name, person.age))
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      List({ space: 16 }) {
        PersonListItem({ index: -1, person: new PersonHeader() })

        ForEach(this.persons, (person: Person, index) => {
          PersonListItem({ index, person: person })
        }, (person: Person) => person.id)
      }
      // .listDirection(Axis.Horizontal)
      .layoutWeight(1)
      .padding({ top: 16, left: 20, right: 20 })
      .divider({ strokeWidth: 1, color: Color.Gray })

      // 默认主轴列数为1
      // .lanes(2)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct PersonListItem {
  @Prop index: number
  @ObjectLink person: Person | PersonHeader
  @Consume persons: Person[]

  @Builder
  ItemDeleteBtn() {
    Row({ space: 8 }) {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Image($r('app.media.delete'))
          .fillColor(Color.White)
          .width(20)
      }
      .width(35)
      .height(35)
      .backgroundColor(Color.Red)
      .onClick(() => {
        this.persons.splice(this.index, 1)
      })

      Text('年龄+1')
        .personAction()
        .onClick(() => {
          if (this.person instanceof Person) {
            this.person.age++
          }
        })
    }
  }

  build() {
    ListItem() {
      Row() {
        if (typeof (this.person.age) === 'number') {
          Text(this.person.name)
          Text(this.person.age.toString())
        } else {
          Text(this.person.name)
            .personHeader()
          Text(this.person.age)
            .personHeader()
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height(30)
    .enabled(typeof (this.person.age) === 'number')
    .swipeAction({
      end: this.ItemDeleteBtn()
    })
  }
}

@Extend(Text)
function personHeader(size: number = 20, weight: number = 700) {
  .fontSize(size)
  .fontWeight(weight)
}

@Extend(Text)
function personAction(backgroundColor: Color | string | Resource = Color.Blue) {
  .backgroundColor(backgroundColor)
  .fontColor(Color.White)
  .padding(4)
  .borderRadius(6)
}