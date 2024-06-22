import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

interface BottomTabBar {
  text?: string;
  url: Resource;
}

interface HeaderIconBtn {
  text: string;
  url: Resource;
}

@Entry
@Component
struct ZhifubaoFirstPage {
  title: string = (router.getParams() as Params).title
  @State bottomTabBars: BottomTabBar[] = [
    {
      url: $r('app.media.zfb_tab_home')
    },
    {
      text: '理财',
      url: $r('app.media.zfb_tab_money')
    },
    {
      text: '生活',
      url: $r('app.media.zfb_tab_life')
    },
    {
      text: '消息',
      url: $r('app.media.zfb_tab_chat')
    },
    {
      text: '我的',
      url: $r('app.media.zfb_tab_me')
    },
  ]
  @State headerIconBtns: HeaderIconBtn[] = [
    {
      text: '扫一扫',
      url: $r('app.media.zfb_top_scan')
    },
    {
      text: '收付款',
      url: $r('app.media.zfb_top_pay')
    },
    {
      text: '出行',
      url: $r('app.media.zfb_top_travel')
    },
    {
      text: '卡包',
      url: $r('app.media.zfb_top_card')
    },
  ]
  @State contentIconBtns: HeaderIconBtn[] = [
    {
      text: '滴滴出行',
      url: $r('app.media.zfb_nav1')
    },
    {
      text: '生活缴费',
      url: $r('app.media.zfb_nav2')
    },
    {
      text: '股票',
      url: $r('app.media.zfb_nav3')
    },
    {
      text: '蚂蚁森林',
      url: $r('app.media.zfb_nav4')
    },
    {
      text: '手机充值',
      url: $r('app.media.zfb_nav5')
    },
    {
      text: '余额宝',
      url: $r('app.media.zfb_nav6')
    },
    {
      text: '花呗',
      url: $r('app.media.zfb_nav7')
    },
    {
      text: '飞猪旅行',
      url: $r('app.media.zfb_nav8')
    },
    {
      text: '淘票票',
      url: $r('app.media.zfb_nav9')
    },
    {
      text: '饿了么',
      url: $r('app.media.zfb_nav10')
    },
    {
      text: '读书听讲',
      url: $r('app.media.zfb_nav11')
    },
    {
      text: '基金',
      url: $r('app.media.zfb_nav12')
    },
    {
      text: '直播广场',
      url: $r('app.media.zfb_nav13')
    },
    {
      text: '医疗健康',
      url: $r('app.media.zfb_nav14')
    },
    {
      text: '更多',
      url: $r('app.media.zfb_nav15_more')
    },
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      HeaderNav({ title: this.title })
        .zIndex(99)
        .position({x:0, y: 0})
        .backgroundColor('rgba(255,255,255,0.3)')
        .foregroundColor('white')

      // 顶部（header + content）
      Stack({ alignContent: Alignment.Top }) {
        // 顶部header
        Row({ space: 12 }) {
          // 左
          Column() {
            Row({ space: 3 }) {
              Text('北京')
                .fontSize(18)
                .fontColor('#fff')
              Image($r('app.media.zfb_head_down'))
                .width(16)
                .fillColor('#fff')
            }
            .alignItems(VerticalAlign.Top)

            Text('晴 2°C')
              .fontSize(14)
              .fontColor('#fff')
          }
          .alignItems(HorizontalAlign.Start)

          // 中
          Row() {
            Image($r('app.media.zfb_head_search'))
              .width(20)

            TextInput({ placeholder: '北京交通一卡通' })
              .placeholderColor('#000')
              .height(32)
              .backgroundColor('#fff')
              .layoutWeight(1)
              .padding({ left: 10, right: 10 })
            Text('搜索')
              .fontSize(18)
              .fontColor('#3876f6')
              .padding({ left: 10 })
              .border({
                width: {
                  left: 1
                },
                color: {
                  left: Color.Gray
                }
              })
          }
          .height(32)
          .layoutWeight(1)
          .borderRadius(5)
          .backgroundColor('#fff')
          .padding({ left: 6, right: 10 })

          // 右
          Image($r('app.media.zfb_head_plus'))
            .width(32)
            .fillColor('#fff')
        }
        .width('100%')
        .height(60)
        .padding({ left: 10, right: 10 })
        .backgroundColor('#3876f6')
        .zIndex(9)

        // 内容区
        Scroll() {
          Column() {
            Row() {
              ForEach(this.headerIconBtns, (item: HeaderIconBtn) => {
                Column({ space: 2 }) {
                  Image(item.url)
                    .width(35)
                    .fillColor('#fff')
                  Text(item.text)
                    .fontColor('#fff')
                }
              })
            }
            .width('100%')
            .padding({ top: 5, bottom: 15 })
            .justifyContent(FlexAlign.SpaceAround)

            Column() {
              Grid() {
                ForEach(this.contentIconBtns, (item: HeaderIconBtn) => {
                  GridItem() {
                    Column({ space: 4 }) {
                      Image(item.url)
                        .width(28)
                      Text(item.text)
                        .fontSize(14)
                    }
                  }
                })
              }
              .height(165)
              .rowsGap(10)
              .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
              .padding({ left: 10, right: 10 })
              .margin({ top: 16 })

              Row({ space: 5 }) {
                Image($r('app.media.zfb_pro_pic1'))
                  .layoutWeight(1)
                Image($r('app.media.zfb_pro_pic2'))
                  .layoutWeight(1)
                Image($r('app.media.zfb_pro_pic3'))
                  .layoutWeight(1)
              }
              .padding(10)

              Column({space: 10}) {
                Image($r('app.media.zfb_pro_list1'))
                Image($r('app.media.zfb_pro_list2'))
              }
            }
            .width('100%')
            .backgroundColor('#f9f8f9')
            .borderRadius({
              topLeft: 10,
              topRight: 10,
            })
          }
          .width('100%')
          .backgroundColor('#3876f6')
        }
        .margin({ top: 60, bottom: 60 })
      }
      .width('100%')
      .height('100%')

      // 底部tab bar
      Row() {
        ForEach(this.bottomTabBars, (item: BottomTabBar) => {
          Column({ space: 2 }) {
            if (item.text) {
              Image(item.url)
                .width(28)
              Text(item.text)
                .fontSize(14)
            } else {
              Image(item.url)
                .width(35)
            }
          }
        })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
  }
}