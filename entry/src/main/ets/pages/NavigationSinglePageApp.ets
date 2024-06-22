import promptAction from '@ohos.promptAction'

@Entry
@Component
struct NavigationSinglePageApp {
  @State title: string = '全部笔记'
  @State bgColor: Color = Color.White
  @State index: number = 0
  @State selectedIndex: number = 0
  @State hasRead: boolean = false
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

  // 应用于 toolBarConfig 属性后不显示
  @Builder
  BottomMenus() {
    this.HomeBar('app.media.film', 'Film', 0)
    this.HomeBar('app.media.my', 'My', 1)
  }

  @Builder
  TopMenus() {
    Row({ space: 10 }) {
      Text('笔记')
        .onClick(() => {
          this.title = '全部笔记'
          this.bgColor = Color.White
          this.index = 0
          console.log(JSON.stringify($r('app.media.icon')))
        })
      Text('待办')
        .onClick(() => {
          this.title = '全部待办'
          this.bgColor = Color.Green
          this.index = 1
        })
      Text('设置')
    }
    .padding(10)
    .backgroundColor(Color.Pink)
  }

  @Builder
  CustomNavDestination(name: string, param: object) {
    Text(name)
    Text(JSON.stringify(param))
  }

  build() {
    Navigation() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
        TabContent() {
          /*new NavPathInfo('ok', JSON.stringify({
            name: 'ok'
          }), (pathInfo) => console.log(JSON.stringify(pathInfo)))*/
          NavRouter() {
            Text('ok.txt（点击）')

            NavDestination() {
              Text('this is ok details.')
              Row() {
                Checkbox()
                  .select(this.hasRead)
                  .onChange((value) => this.hasRead = value)
                Text('已读详情')
              }

              // 嵌套路由
              NavRouter() {
                Text('嵌套路由入口（点击）')

                NavDestination() {
                  Text('嵌套路由内容')
                }
                .title('嵌套路由title')
                .mode(NavDestinationMode.DIALOG) // 没发现使用场景
                .backgroundColor(Color.Brown)
                .width('50%')
                .height('50%')
              }
              .backgroundColor(Color.Red)
            }
            .backgroundColor(Color.White)
            .title('ok')
            .onReady(pathInfo => {
              console.log('ok onReady', JSON.stringify(pathInfo))
            })
            .onShown(() => {
              promptAction.showToast({ message: 'onShown' })
            })
            .onHidden(() => {
              promptAction.showToast({ message: 'onHidden' })
            })
            .onBackPressed(() => {
              promptAction.showToast({ message: 'onBackPressed', bottom: '50%' })

              if (!this.hasRead) {
                AlertDialog.show({
                  autoCancel: false,
                  message: '离开前，请先勾选已读详情。',
                  buttons: [
                    {
                      value: '好的', action: () => {
                    }
                    }
                  ]
                })
              }

              // 返回 true 禁止离开
              return !this.hasRead
            })
          }
          // .mode(NavRouteMode.REPLACE)
          .backgroundColor(this.bgColor)
          .onStateChange((isActivated: boolean) => {
            if (isActivated) {
              promptAction.showToast({ message: 'ok 路由器已激活' })
            }
          })
        }
        .backgroundColor(Color.Orange)
        .tabBar(this.HomeBar('app.media.film', 'Film', 0))

        TabContent() {
          NavRouter() {
            Text('hi.txt（点击）')

            NavDestination() {
              Text('this is hi details.')
            }
            .backgroundColor(Color.Pink)
            .title('hi')
          }
          .backgroundColor(this.bgColor)
        }
        .backgroundColor(Color.Grey)
        .tabBar(this.HomeBar('app.media.my', 'My', 1))
      }
      .barBackgroundColor('#23d96e')
      .scrollable(false)
      .layoutWeight(1)
      .onChange(index => {
        this.selectedIndex = index
        this.index = index

        this.title = index === 0 ? '全部笔记' : '全部待办'
        this.bgColor = index === 0 ? Color.White : Color.Pink
      })
    }
    // .navBarWidth(10)
    // .navBarPosition(NavBarPosition.Start)
    // .mode(NavigationMode.Auto)
    // .backButtonIcon($r('app.media.icon')) // 不起作用
    // .hideNavBar(true) // 全部隐藏不显示了
    // .hideTitleBar(true)
    .hideToolBar(true)
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .menus(this.TopMenus())
    // .menus([
    //   {
    //     value: 'hi',
    //     icon: '../../resources/base/media/avatar.jpg'
    //   }
    // ])
    // .navDestination(this.CustomNavDestination) // 暂无效果
    // .toolbarConfiguration(this.BottomMenus()) // 暂无效果
    // .toolbarConfiguration([ // 暂无效果
    //   {
    //     value: '笔记1',
    //     icon: $r('app.media.icon'),
    //     action: () => {
    //       this.title = '全部笔记'
    //       this.bgColor = Color.White
    //       this.index = 0
    //     }
    //   },
    //   {
    //     value: '待办',
    //     icon: $r('app.media.ic_pay'),
    //     action: () => {
    //       this.title = '全部待办'
    //       this.bgColor = Color.Green
    //       this.index = 1
    //     }
    //   }
    // ])
    // .translate({x: 100, y: -100})
    // .opacity(0)
  }

  pageTransition() {
    PageTransitionEnter({duration: 500})
      .slide(SlideEffect.Right)
      .opacity(0)
      .scale({x: 0.5, y: 0.5})

    PageTransitionExit({ duration: 500 })
      .slide(SlideEffect.Right)
      .scale({x: 0.5, y: 0.5})
      .opacity(0)
  }
}