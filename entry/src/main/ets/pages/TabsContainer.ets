import router from '@ohos.router'
import { HeaderNav } from '../components/HeaderNav'
import { Params } from '../model/RouteParamsModel'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct TabsContainer {
  title: string = (router.getParams() as Params).title
  @State selectedIndex: number = 0
  tabController = new TabsController()

  @Builder
  HomeBar(imgUrl: string, title: string, index: number) {
    Column({ space: 6 }) {
      Image($r(imgUrl))
        .width(30)
        .fillColor(this.selectedIndex === index ? '#36f' : Color.Gray)
      Text(title)
        .fontSize(20)
        .fontColor(this.selectedIndex === index ? '#36f' : Color.Gray)
    }
    .onClick(() => {
      this.selectedIndex = index
      this.tabController.changeIndex(index)
    })
  }

  build() {
    Column() {
      HeaderNav({ title: this.title })

      Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
        TabContent() {
          Tabs() {
            TabContent() {
              Text('Home_1_content')
            }
            .tabBar('Home_1')

            TabContent() {
              Text('Home_2_content')
            }
            .tabBar('Home_2')

            TabContent() {
              Text('Home_3_content')
            }
            .tabBar('Home_3')

            TabContent() {
              Text('Home_11_content')
            }
            .tabBar('Home_11')

            TabContent() {
              Text('Home_22_content')
            }
            .tabBar('Home_22')

            TabContent() {
              Text('Home_33_content')
            }
            .tabBar('Home_33')
          }
          // .barOverlap(true)
          .divider({
            strokeWidth: 1,
            color: Color.Green
          })
          .barMode(BarMode.Scrollable)
          .onTabBarClick(index => {
            promptAction.showToast({ message: 'tabBar索引：' + index })
          })
        }
        .backgroundColor(Color.Pink)
        .tabBar(this.HomeBar('app.media.home', 'Home', 0))

        TabContent() {
          Text('Film')
        }
        .backgroundColor(Color.Orange)
        .tabBar(this.HomeBar('app.media.film', 'Film', 1))

        TabContent() {
          Text('My')
        }
        .backgroundColor(Color.Grey)
        .tabBar(this.HomeBar('app.media.my', 'My', 2))
      }
      // .vertical(true)
      // .fadingEdge(true)
      // .divider({
      //   strokeWidth: 1
      //   color: Color.Green
      // })
      .barBackgroundColor('#23d96e')
      .scrollable(false)
      .layoutWeight(1)
      .onChange(index => this.selectedIndex = index)
    }
    .width('100%')
    .height('100%')
  }
}