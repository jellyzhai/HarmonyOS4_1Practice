import router from '@ohos.router';
import { UIContext } from '@ohos.arkui.UIContext';
import { Params } from '../model/RouteParamsModel';
import { HeaderNav } from '../components/HeaderNav';

@Entry
@Component
struct KeyFramesAnimation {
  title: string = (router.getParams() as Params).title
  uiContext: UIContext | undefined = undefined
  @State radius: number = 50
  @State scaleRatio: number = 1

  aboutToAppear(): void {
    this.uiContext = this.getUIContext()
  }

  onPageShow(): void {
    this.uiContext?.keyframeAnimateTo({ iterations: -1 }, [
      {
        duration: 1000,
        curve: Curve.Linear,
        event: () => {
          this.scaleRatio = 0.5
        }
      },
      {
        duration: 1000,
        curve: Curve.Linear,
        event: () => {
          this.scaleRatio = 1
        }
      }
    ])
  }

  // 当前组件将要重新使用前，调用的函数
  aboutToReuse(params: object): void {
    console.log('aboutToReuse', JSON.stringify(params))
  }

  // 当前组件被标记为可回收，在系统内存不足时，将要被回收前，调用的函数
  aboutToRecycle(): void {
    console.log('aboutToRecycle')
  }

  build() {
    Column({ space: 32 }) {
      HeaderNav({ title: this.title })

      Circle({ width: this.radius, height: this.radius })
        .fill(Color.Pink)
        .scale({ x: this.scaleRatio, y: this.scaleRatio })
    }
    .width('100%')
    .height('100%')
  }
}