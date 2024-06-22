import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { CardParamsMessage } from '../model/CardFormModel';
import { Params } from '../model/RouteParamsModel';

@Entry({ storage: LocalStorage.getShared() })
@Component
struct StartPageByCard {
  title: string = (router.getParams() as Params).title
  @LocalStorageProp(CardParamsMessage) message: string = '当前页面不是从卡片启动';

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Text(this.message)
    }
    .width('100%')
    .height('100%')
  }
}