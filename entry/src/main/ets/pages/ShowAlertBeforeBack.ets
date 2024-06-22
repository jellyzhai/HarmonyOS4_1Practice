import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';

@Entry
@Component
struct ShowAlertBeforeBack {
  title: string = (router.getParams() as Params).title
  confirmInfoBeforeBack = '当前页面还有未完成操作，确定要离开么？'
  @State message: string = 'Hello World';

  build() {
    Column() {
      HeaderNav({ title: this.title, confirmInfoBeforeBack: this.confirmInfoBeforeBack })
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
  }
}