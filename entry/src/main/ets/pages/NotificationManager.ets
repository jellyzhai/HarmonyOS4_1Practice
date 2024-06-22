import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import notificationManager from '@ohos.notificationManager';
import { BusinessError } from '@ohos.base';
import promptAction from '@ohos.promptAction';
import wantAgent from '@ohos.app.ability.wantAgent';

@Entry
@Component
struct NotificationManager {
  title: string = (router.getParams() as Params).title
  @State message: string = 'Hello World';

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      // 需要在模拟器或真实设备上运行
      Button('基本文本通知')
        .onClick(() => {
          const request: notificationManager.NotificationRequest = {
            id: 1,
            notificationSlotType: notificationManager.SlotType.SOCIAL_COMMUNICATION,
            showDeliveryTime: true,
            deliveryTime: Date.now(),
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
              normal: {
                title: '基本文本标题，基本文本标题，基本文本标题，基本文本标题，',
                text: '基本文本内容，基本文本内容，基本文本内容，基本文本内容，基本文本内容，基本文本内容，',
                additionalText: '附加内容，附加内容，附加内容，附加内容，'
              }
            }
          }

          notificationManager.publish(request, (error: BusinessError) => {
            if (error?.code) {
              promptAction.showToast({ message: '基本文本通知失败' })
            } else {
              promptAction.showToast({ message: '基本文本通知成功' })
            }
          })
        })

      Button('长文本通知')
        .onClick(() => {
          const request: notificationManager.NotificationRequest = {
            id: 2,
            notificationSlotType: notificationManager.SlotType.SERVICE_INFORMATION,
            showDeliveryTime: true,
            deliveryTime: Date.now(),
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
              longText: {
                title: '展开前的长文本标题，',
                text: '展开前的长文本内容',
                expandedTitle: '展开后的长文本标题',
                longText: '展开后的长文本内容，展开后的长文本内容，展开后的长文本内容，展开后的长文本内容，展开后的长文本内容，展开后的长文本内容，',
                briefText: '简要概述',
                additionalText: '附加内容'
              }
            }
          }

          notificationManager.publish(request, (error: BusinessError) => {
            if (error?.code) {
              promptAction.showToast({ message: '长文本通知失败' })
            } else {
              promptAction.showToast({ message: '长文本通知成功' })
            }
          })
        })

      Button('多行文本通知')
        .onClick(() => {
          const request: notificationManager.NotificationRequest = {
            id: 3,
            notificationSlotType: notificationManager.SlotType.CONTENT_INFORMATION,
            showDeliveryTime: true,
            deliveryTime: Date.now(),
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
              multiLine: {
                title: '展开前的多行文本标题，',
                text: '展开前的多行文本内容',
                longTitle: '展开后的多行文本内容',
                lines: [
                  '1、多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，',
                  '2、多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，',
                  '3、多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，多行文本通知，'
                ],
                briefText: '简要概述',
                additionalText: '附加内容'
              }
            }
          }

          notificationManager.publish(request, (error: BusinessError) => {
            if (error?.code) {
              promptAction.showToast({ message: '多行文本通知失败' })
            } else {
              promptAction.showToast({ message: '多行文本通知成功' })
            }
          })
        })

      Button('进度通知')
        .onClick(() => {
          const template: notificationManager.NotificationTemplate = {
            name: 'downloadTemplate',
            data: {
              title: '下载文件的标题',
              fileName: '文件名称.mp3',
              progressValue: 0,
              progressMaxValue: 100
            }
          }

          const request: notificationManager.NotificationRequest = {
            id: 4,
            template,
            notificationSlotType: notificationManager.SlotType.OTHER_TYPES,
            showDeliveryTime: true,
            deliveryTime: Date.now(),
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
              normal: {
                title: template.data.fileName as string,
                text: '进度通知内容，',
                additionalText: '附加内容，附加内容，附加内容，附加内容，'
              }
            }
          }

          let timerID = -1
          clearInterval(timerID)

          timerID = setInterval(() => {
            if (template.data.progressValue > 100) {
              clearInterval(timerID)
            } else {
              (template.data.progressValue as number)++
              notificationManager.publish(request, (error: BusinessError) => {
                if (error?.code) {
                  promptAction.showToast({ message: '进度通知失败' })
                  clearInterval(timerID)
                }
              })
            }
          }, 1000)
        })

      Button('意图通知')
        .onClick(async () => {
          const wantAgentInfo: wantAgent.WantAgentInfo = {
            requestCode: 1,
            actionType: wantAgent.OperationType.START_ABILITY,
            actionFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG],
            wants: [
              {
                deviceId: '',
                bundleName: 'com.example.harmonyos4_1practice',
                moduleName: 'entry',
                abilityName: 'EntryAbility'
              }
            ]
          }

          const wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo)

          const request: notificationManager.NotificationRequest = {
            id: 5,
            wantAgent: wantAgentObj,
            notificationSlotType: notificationManager.SlotType.CUSTOMER_SERVICE,
            showDeliveryTime: true,
            deliveryTime: Date.now(),
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
              normal: {
                title: '意图通知标题',
                text: '点击当前意图通知内容，',
                additionalText: '附加内容，附加内容，附加内容，附加内容，'
              }
            }
          }

          notificationManager.publish(request, (error: BusinessError) => {
            if (error?.code) {
              promptAction.showToast({ message: '意图通知失败' })
            } else {
              promptAction.showToast({ message: '意图通知成功' })
            }
          })
        })

      Text(`
        在api 11版本中，其他内容通知类型，预留接口，暂不支持, 如：
        NOTIFICATION_CONTENT_PICTURE 图片类型通知。（预留能力，暂未支持）。
        NOTIFICATION_CONTENT_CONVERSATION	社交类型通知。（预留能力，暂未支持）。
        NOTIFICATION_CONTENT_SYSTEM_LIVE_VIEW11+	实况窗类型通知。（预留能力，暂未支持）。
        NOTIFICATION_CONTENT_LIVE_VIEW11+	普通实况窗类型通知。（预留能力，暂未支持）。
      `)
        .fontSize(14)
    }
    .width('100%')
    .height('100%')
  }
}