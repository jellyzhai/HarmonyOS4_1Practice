import router from '@ohos.router';

interface Page {
  title: string;
  url: string;
}

// 入口组件可以设置具名路由，同时传递 在UIAbility 中 WindowStage.loadContent 方法中传递的 LocalStorage
@Entry({routeName: 'entryRoute', storage: LocalStorage.getShared()})
@Component
struct Index {
  @State pages: Page[] = [
    {
      title: '综合练习',
      url: 'pages/OtherPractice'
    },
    {
      title: 'Stack',
      url: 'pages/StackPage'
    },
    {
      title: '支付宝首页',
      url: 'pages/ZhifubaoFirstPage'
    },
    {
      title: '放在Text中的小图标ImageSpan',
      url: 'pages/ImageSpanInText'
    },
    {
      title: 'Grid&Stack Practice',
      url: 'pages/GridStackPractice'
    },
    {
      title: 'GlobalBuilder',
      url: 'pages/GlobalBuilder'
    },
    {
      title: 'StateStyle',
      url: 'pages/StateStylePage'
    },
    {
      title: 'ObjectLink',
      url: 'pages/ObjectLinkPage'
    },
    {
      title: '离开页面前显示警告弹窗',
      url: 'pages/ShowAlertBeforeBack'
    },
    {
      title: 'Stack/List/字母索引,返回按钮',
      url: 'pages/StackListBackBtn'
    },
    {
      title: 'GridRow/GridCol栅格布局',
      url: 'pages/GridRowGridColLayout'
    },
    {
      title: 'Grid/GridItem网格布局',
      url: 'pages/GridCellLayout'
    },
    {
      title: 'swiper轮播',
      url: 'pages/SwiperLoopPlay'
    },
    {
      title: 'tabs切换',
      url: 'pages/TabsContainer'
    },
    {
      title: 'Navigation内有路由',
      url: 'pages/NavigationSinglePageApp'
    },
    {
      title: 'bindContentCover全屏模态框',
      url: 'pages/FullScreenModal'
    },
    {
      title: 'bindSheet半屏模态框',
      url: 'pages/HalfScreenModal'
    },
    {
      title: 'bindMenu点击显示菜单',
      url: 'pages/ClickBindMenu'
    },
    {
      title: 'bindContextMenu长按显示上下文菜单',
      url: 'pages/BindContextMenu'
    },
    {
      title: 'bindPopUp点击显示提示弹框',
      url: 'pages/BindPopUp'
    },
    {
      title: 'keyFrameAnimateTo关键帧动画',
      url: 'pages/KeyFramesAnimation'
    },
    {
      title: 'clickEffect&overlay属性方法',
      url: 'pages/ClickEffectOverlay'
    },
    {
      title: '线性/径向/扫描渐变',
      url: 'pages/GradientPractice'
    },
    {
      title: 'http模块实践',
      url: 'pages/HttpPractice'
    },
    {
      title: 'webSocket模块实践',
      url: 'pages/WebSocketPractice'
    },
    {
      title: '页面返回前提示确认信息',
      url: 'pages/AlertBeforeBackPage'
    },
    {
      title: '父子组件引用数据传递',
      url: 'pages/ParentChildParamsTransmission'
    },
    {
      title: '多目标关联性动画',
      url: 'pages/MultiObjectiveAssociationAnimation'
    },
    {
      title: 'web组件实践',
      url: 'pages/WebPractice'
    },
    {
      title: 'TaskPool任务池实践',
      url: 'pages/TaskPoolPractice'
    },
    {
      title: '启动拍照获取数据/选择照片/文档',
      url: 'pages/StartCameraSelectPhotoAndDocument'
    },
    {
      title: '文件下载/读/写/保存',
      url: 'pages/fsDownloadReadWriteSave'
    },
    {
      title: '首选项Preference使用',
      url: 'pages/PreferencesFirstSelection'
    },
    {
      title: '拨打电话call/电话卡信息radio',
      url: 'pages/CallRadio'
    },
    {
      title: '地理位置',
      url: 'pages/GeoLocationManager'
    },
    {
      title: '窗口和窗口舞台',
      url: 'pages/WindowAndWindowStage'
    },
    {
      title: '状态栏通知',
      url: 'pages/NotificationManager'
    },
    {
      title: '卡片可以打开的页面',
      url: 'pages/StartPageByCard'
    },
  ]

  aboutToAppear(): void {
    this.pages.reverse()
  }

  build() {
    List({ space: 8 }) {
      ForEach(this.pages, (item: Page, index) => {
        ListItem() {
          Text((index + 1) + '. ' + item.title)
            .fontColor(Color.Blue)
            .fontSize(20)
            .onClick(() => router.pushUrl({
              url: item.url,
              params: {
                title: item.title
              }
            }))
        }
        .width('100%')
        // .geometryTransition(item.title, {follow: true}) // 几何过度效果, 暂无效果
        // .sharedTransition(item.title) // 预览器崩溃，在回来后
      })
    }
    .height('100%')
    .width('100%')
    .padding(8)
  }

  pageTransition() {
    PageTransitionEnter({duration: 500})
      .slide(SlideEffect.Left)
      .opacity(0)
      .scale({x: 0.5, y: 0.5})

    PageTransitionExit({ duration: 500 })
      .slide(SlideEffect.Left)
      .opacity(0.5)
      .scale({x: 0.5, y: 0.5})
  }
}