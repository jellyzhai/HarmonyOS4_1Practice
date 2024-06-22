import call from '@ohos.telephony.call';
import promptAction from '@ohos.promptAction';
import radio from '@ohos.telephony.radio';
import router from '@ohos.router';
import { Params } from '../model/RouteParamsModel';
import { HeaderNav } from '../components/HeaderNav';

@Entry
@Component
struct CallRadio {
  title: string = (router.getParams() as Params).title
  @State message: string = '网络类型：-； 信号等级：-';

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Button('拨打客服看电话')
        .onClick(() => {
          call.makeCall('13500001111', (err) => {
            if (!err) {
              promptAction.showToast({ message: '成功调用到电话界面', duration: 2000 })
            } else {
              promptAction.showToast({ message: '失败调用到电话界面', duration: 2000 })
            }
          })
        })

      Button('获取电话卡1的信息')
        .onClick(() => {
          radio.getSignalInformation(0)
            .then((value: radio.SignalInformation[]) => {
              this.message = `网络类型：${value[0].signalType}； 信号等级：${value[0].signalLevel}`
            })
            .catch(() => {
              promptAction.showToast({ message: '获取电话卡信息失败', duration: 200 })
            })
        })
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
  }
}