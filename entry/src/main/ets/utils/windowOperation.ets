import window from '@ohos.window'

class WindowOperationUtil {
  windowStage = {} as window.WindowStage

  setWindowStage(windowStage: window.WindowStage) {
    this.windowStage = windowStage
  }

  async showSubWindow(subWindowName: string, path: string) {
    if (!Object.keys(this.windowStage)) {
      return
    }
    const windowClass = await this.windowStage.createSubWindow(subWindowName)
    await windowClass.moveWindowTo(50, 50)
    await windowClass.resize(350, 500)
    await windowClass.setUIContent(path)
    await windowClass.showWindow()

    return windowClass
  }
}

export const windowOperationUtil = new WindowOperationUtil()