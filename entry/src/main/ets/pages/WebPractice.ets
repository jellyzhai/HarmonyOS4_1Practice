import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import webview from '@ohos.web.webview'

/*
 * 示例
 * https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101667364948559963
 * */
@Entry
@Component
struct WebPractice {
  title: string = (router.getParams() as Params).title
  controller: WebviewController = new webview.WebviewController()

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title })

      Web({src: 'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101667364948559963', controller: this.controller})
        .onConfirm(event => {
          console.log('test_tag', JSON.stringify(event))
          return false
        })

    }
    .width('100%')
    .height('100%')
  }
}