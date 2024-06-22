import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import geoLocationManager from '@ohos.geoLocationManager';
import promptAction from '@ohos.promptAction';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import hilog from '@ohos.hilog';

@Entry
@Component
struct GeoLocationManager {
  title: string = (router.getParams() as Params).title
  @State currentLocation: string = '';
  @State realTimeLocation: string = '';

  requestPermissionsFormUser(permissions: Array<Permissions>) {
    const context = getContext(this)
    const authorizationManager = abilityAccessCtrl.createAtManager()

    return authorizationManager.requestPermissionsFromUser(context, permissions)
      .then((result) => {
        return result.authResults.some(item => item === 0)
      })
      .catch((err: Object) => {
        hilog.error(0x1111, 'test_tag', JSON.stringify(err))
        promptAction.showToast({ message: '用户未授权获取位置' })
      })
  }

  locationChangeHandler(location: geoLocationManager.Location) {
      this.realTimeLocation = JSON.stringify(location)
  }

  aboutToDisappear(): void {
    geoLocationManager.off('locationChange', this.locationChangeHandler)
  }

  build() {
    Column({ space: 16 }) {
      HeaderNav({ title: this.title })

      Button('获取当前位置信息')
        .onClick(async () => {
          // const isAuthorized = await this.requestPermissionsFormUser(['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'])
          const requestInfo: geoLocationManager.LocationRequest = {
            priority: geoLocationManager.LocationRequestPriority.ACCURACY
          }

          geoLocationManager.getCurrentLocation(requestInfo)
            .then(async (location) => {
              console.log('0x1111', 'test_tat', JSON.stringify(location))
              const request: geoLocationManager.ReverseGeoCodeRequest = {
                locale: 'zh',
                latitude: 39.96467778,
                longitude: 116.29795556
                // latitude: location.latitude,
                // longitude: location.longitude
              }
              const address: geoLocationManager.GeoAddress[] = await geoLocationManager.getAddressesFromLocation(request)
              this.currentLocation = JSON.stringify(address)
              promptAction.showToast({ message: '获取当前位置信息成功' })
            })
            .catch(() => {
              promptAction.showToast({ message: '获取当前位置信息失败' })
            })
        })

      Column() {
        Text('当前位置信息：')
      }

      TextArea({ text: this.currentLocation, placeholder: '位置显示区' })
        .enabled(false)

      Button('开启实时定位')
        .onClick(() => {
          const request: geoLocationManager.LocationRequest = {
            priority: geoLocationManager.LocationRequestPriority.ACCURACY
          }
          geoLocationManager.on('locationChange', request, this.locationChangeHandler)
        })

      TextArea({ text: this.realTimeLocation, placeholder: '实时位置显示区' })
        .enabled(false)
    }
    .width('100%')
    .height('100%')
  }
}