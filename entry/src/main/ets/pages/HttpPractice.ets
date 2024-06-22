import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import http from '@ohos.net.http';
import axios from '@ohos/axios';

interface DataItem {
  id: string;
  name: string;
  age: number;
}

@Entry
@Component
struct HttpPractice {
  title: string = (router.getParams() as Params).title
  @State data: DataItem[] = [];
  @State isLoading: boolean = false

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      // 2024/5/4 22:12 点击后 预览器崩溃
      /*Button('获取全部users')
        .onClick(() => {
          this.isLoading = true
          const httpRequest = http.createHttp()
          httpRequest.request('http://192.168.0.116:3000/users', {
            method: http.RequestMethod.GET,
            expectDataType: http.HttpDataType.OBJECT
          }).then(response => {
            setTimeout(() => this.isLoading = false, 1000)

            if (response.responseCode === http.ResponseCode.OK) {
              this.data = response.result as DataItem[]
            }
            console.log('response', JSON.stringify(response.result))
          })
        })*/

      // 同上
      Button('获取全部users')
        .onClick(() => {
          this.isLoading = true
          axios.get('http://192.168.0.116:3000/users').then((response: Object) => {
            setTimeout(() => this.isLoading = false, 1000)

            if (Reflect.get(response, 'status') === 200) {
              this.data = Reflect.get(response, 'data') as DataItem[]
            }
            // console.log('response', JSON.stringify(response))
          })
        })

      // if (this.isLoading) {
      //   Row() {
      //     LoadingProgress()
      //       .width(30)
      //   }
      //   .width('100%')
      //   .justifyContent(FlexAlign.Center)
      // } else {
      // List() {
      //   ForEach(this.data, (item: DataItem) => {
      //     ListItem() {
      //       Grid() {
      //         GridItem() {
      //           Text(item.id.toString())
      //         }
      //
      //         GridItem() {
      //           Text(item.name)
      //         }
      //
      //         GridItem() {
      //           Text(item.age.toString())
      //         }
      //       }
      //       .rowsTemplate(this.data.reduce((tpl) => tpl + '1fr ', ''))
      //       .columnsTemplate('1fr 1fr 1fr')
      //       .width('100%')
      //     }
      //   })
      // }
      // .backgroundColor(Color.Gray)
      // }
    }
    .width('100%')
    .height('100%')
  }
}