import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { DARK_MODE_KEY, entryAbilityPreference } from '../model/PreferencesModel';
import { Params } from '../model/RouteParamsModel';

@Entry
@Component
struct PreferencesFirstSelection {
  title: string = (router.getParams() as Params).title
  // 预览器中无法使用
  // preference = entryAbilityPreference.getPreference()
  @State message: string = '恢复默认状态'
  @State switchOn: boolean = false

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title, fontColor: this.switchOn ? Color.White : Color.Black })

      Row({space: 20}) {
        Text('暗黑模式')
          .fontColor(this.switchOn ? Color.White : Color.Black)

        Row({space: 5}) {
          Toggle({
            type: ToggleType.Switch,
            isOn: this.switchOn
          })
            .onChange((isOn: boolean) => {
              this.switchOn = isOn

              // 预览器中无法使用
              // this.preference.put(DARK_MODE_KEY, isOn)
              // this.preference.flush()
            })
          Text(this.switchOn ? '开' : '关')
            .fontColor(this.switchOn ? Color.White : Color.Black)
        }
      }

      Button(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.switchOn = false

          // 预览器中无法使用
          // this.preference.put(DARK_MODE_KEY, false)
          // this.preference.flush()
        })

      // 下面对象 通过按下实现点’.‘查看方法
      // this.preference
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.switchOn ? Color.Black : Color.White)
  }
}