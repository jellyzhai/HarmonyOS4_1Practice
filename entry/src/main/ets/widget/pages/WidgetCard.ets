import { CardMessageParams, CardRouterParams } from '../../model/CardFormModel'

const localStorage = new LocalStorage()

@Entry(localStorage)
@Component
struct WidgetCard {
  @LocalStorageProp('city') city = '北京'
  @LocalStorageProp('temperature') temperature = '20'

  readonly ABILITY_NAME: string = 'EntryAbility';

  readonly FULL_WIDTH_PERCENT: string = '100%';

  readonly FULL_HEIGHT_PERCENT: string = '100%';

  /*
   * action的类型，支持三种预定义的类型：
   * - router：跳转到提供方应用的指定UIAbility。
   * - message：自定义消息，触发后会调用提供方FormExtensionAbility的onFormEvent()生命周期回调。
   * - call：后台启动提供方应用。触发后会拉起提供方应用的指定UIAbility（仅支持launchType为singleton的UIAbility，
   * 即启动模式为单实例的UIAbility），但不会调度到前台。提供方应用需要具备后台运行权限(ohos.permission.KEEP_BACKGROUND_RUNNING)。
   * */
  build() {
    Column({ space: 8 }) {
      // 通过 router 的 action 类型，携带参数，启动 UIAbility
      Button('action:router 页面跳转')
        .onClick(() => {
          postCardAction(this, {
            action: 'router',
            abilityName: this.ABILITY_NAME,
            params: {
              cardPageUri: 'pages/StartPageByCard',
              cardMessage: '来自卡片启动，action:router, 当前参数会出现在 UIAbility 的 onCreate 或 onNewWant 回调方法的参数want中'
            } as CardRouterParams
          });
        })

      // 通过 message 的 action 类型，携带参数，更新卡片数据
      Button('action:message 卡片刷新')
        .onClick(() => {
          postCardAction(this, {
            action: 'message',
            params: {
              city: this.city,
              temperature: (Number(this.city) + 1).toString()
            } as CardMessageParams
          });
        })

      Column() {
        Text(`城市：${this.city}`)
        Text(`气温：${this.temperature} °`)
      }
    }
    .width(this.FULL_WIDTH_PERCENT)
    .height(this.FULL_HEIGHT_PERCENT)
  }
}