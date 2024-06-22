import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct AlertBeforeBackPage {
  isFirstBack = true
  showAlertDialogOnBackPress = false
  title: string = (router.getParams() as Record<string, string>).title

  onBackPress(): boolean | void {
    if (this.showAlertDialogOnBackPress) {
      AlertDialog.show({
        autoCancel: false,
        message: '再想想，确认离开么(out page)',
        buttons: [
          {
            value: '取消',
            action: () => {}
          },
          {
            value: '确认',
            action: () => router.back()
          }
        ]
      })

      return true
    }

    if (this.isFirstBack) {
      promptAction.showToast({ message: '提示消失前再操作一次，以确认返回', duration: 2000 })
      this.isFirstBack = false

      setTimeout(() => this.isFirstBack = true, 2000)
      return true
    }
  }

  build() {
    Column({ space: 16 }) {
      // 在 onBackPress 方法中实现
      Button('页面外触发返回(手势边缘/系统按钮)，是否开启确认框')
        .onClick(() => {
          this.showAlertDialogOnBackPress = !this.showAlertDialogOnBackPress
          promptAction.showToast({ message: this.showAlertDialogOnBackPress ? '已开启' : '已关闭' })
        })

      Button('页面内 触发返回前提示 确认弹框')
        .onClick(() => {
          router.showAlertBeforeBackPage({ message: '确定要离开么(in page)' })
          router.back()
        })
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}