import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import window from '@ohos.window';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';
import hilog from '@ohos.hilog';
import { windowOperationUtil } from '../utils/windowOperation';

@Entry
@Component
struct WindowAndWindowStage {
  title: string = (router.getParams() as Params).title
  context: common.Context = getContext(this)
  currentWindow: window.Window | null = null
  @State isFullScreen: boolean = false;
  @State isAutoLandscape: boolean = false;

  aboutToAppear(): void {
    // 获取最终最上层的显示窗口。
    window.getLastWindow(this.context)
      .then(windowClass => {
        this.currentWindow = windowClass
      })
      .catch(() => {
        hilog.error(0x1111, 'test_tag', '获取currentWindow失败')
      })
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Row() {
        Text('设置当前窗口全屏')

        Toggle({ type: ToggleType.Switch, isOn: this.isFullScreen })
          .onChange(isOn => {
            this.isFullScreen = isOn
            this.currentWindow?.setWindowLayoutFullScreen(isOn)
              .then(() => {
                promptAction.showToast({ message: isOn ? '成功设置窗口全屏' : '取消设置窗口全屏' })
              })
              .catch(() => {
                promptAction.showToast({ message: isOn ? '设置窗口全屏失败' : '取消窗口全屏失败' })
              })
          })
      }

      Row() {
        Text('设置窗口自动横屏')

        Toggle({ type: ToggleType.Switch, isOn: this.isAutoLandscape })
          .onChange(isOn => {
            this.isAutoLandscape = isOn
            this.currentWindow?.setPreferredOrientation(window.Orientation.AUTO_ROTATION_LANDSCAPE)
              .then(() => {
                promptAction.showToast({ message: isOn ? '成功设置窗口自动横屏' : '取消设置窗口自动横屏' })
              })
              .catch(() => {
                promptAction.showToast({ message: isOn ? '设置窗口自动横屏失败' : '取消窗口自动横屏失败' })
              })
          })
      }

      Button('创建悬浮子窗口')
        .onClick(async () => {
          const config: window.Configuration = {
            name: '子窗口',
            windowType: window.WindowType.TYPE_DIALOG,
            // windowType: window.WindowType.TYPE_FLOAT,
            ctx: this.context
          }

          // 预览器上不能运行
          /* 通过 window 窗口命名空间创建子窗口，可创建浮动窗口, 应用回到后台，依然显示 */
          window.createWindow(config).then(async windowClass => {
            await windowClass.moveWindowTo(30, 50)
            await windowClass.resize(300, 400)
            await windowClass.setUIContent(('pages/Index'))
            // await windowClass.loadContentByName('entryRoute')
            await windowClass.showWindow()

            windowClass.on('touchOutside', () => {
              windowClass.destroyWindow()
            })
          })

          /* 通过 WindowStage 创建子窗口，不能创建浮动窗口 */
          // const windowClass = await windowOperationUtil.showSubWindow('子窗口', 'pages/Index')
          //
          // windowClass.on('touchOutside', () => {
          //   windowClass.destroyWindow()
          // })
        })
    }
    .width('100%')
    .height('100%')
  }
}