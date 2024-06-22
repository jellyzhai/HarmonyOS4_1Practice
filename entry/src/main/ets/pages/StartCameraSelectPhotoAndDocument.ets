import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';
import hilog from '@ohos.hilog';
import Want from '@ohos.app.ability.Want';
// import wantConstant from '@ohos.app.ability.wantConstant';
import wantConstant from '@ohos.ability.wantConstant';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct StartCameraSelectPhotoAndDocument {
  title: string = (router.getParams() as Params).title
  // context: common.UIAbilityContext = getContext(this)
  @StorageProp('uiAbilityContext') context: common.UIAbilityContext = {} as common.UIAbilityContext
  @State photographImgUri: string = '';
  @State selectedImgUri: string = '';
  @State readText: string = '';

  selectPicture() {

  }

  build() {
    Column({ space: 10 }) {
      HeaderNav({ title: this.title })

      Button('打开相册选择')
        .onClick(() => {
          const photoViewPicker = new picker.PhotoViewPicker()
          const photoSelectOption = new picker.PhotoSelectOptions()
          photoSelectOption.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
          photoViewPicker.select(photoSelectOption)
            .then((result: picker.PhotoSelectResult) => {
              this.selectedImgUri = result.photoUris[0]
            })
            .catch((error: Object) => {
              hilog.error(0x1111, 'error:photoViewPicker.select', JSON.stringify(error))
            })
        })

      if (this.selectedImgUri) {
        Image(this.selectedImgUri)
          .width(100)
      } else {
        Column() {
          Text('相片显示区')
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .width(100)
        .height(100)
        .justifyContent(FlexAlign.Center)
        .border({
          width: 1,
          style: BorderStyle.Dashed,
          color: Color.Gray
        })
      }

      Divider()

      Button('打开文档选择')
        .onClick(() => {
          const docViewPicker = new picker.DocumentViewPicker()
          const docSelectOption = new picker.DocumentSelectOptions()
          docSelectOption.maxSelectNumber = 1
          // docSelectOption.selectMode = picker.DocumentSelectMode.File

          docViewPicker.select(docSelectOption)
            .then(urls => {
              hilog.info(0x1111, 'info:docViewPicker.select', JSON.stringify(urls))
              fs.readText(urls[0], { encoding: 'utf-8' })
                .then(text => {
                this.readText = text
              })
                .catch((error: Object) => {
                  hilog.error(0x1111, 'error:fs.readText', JSON.stringify(error))
                })
            })
            .catch((error: Object) => {
              hilog.error(0x1111, 'error:docViewPicker.select', JSON.stringify(error))
            })
        })

      if (this.readText) {
        Text(this.readText)
      } else {
        Text('文本显示区')
      }

      Divider()

      Button('打开相机拍照获取照片URI')
        .onClick(() => {
          const want: Want = {
            deviceId: '',
            /*bundleName: 'com.example.harmonyos4_1practice',
            moduleName: 'entry',
            abilityName: 'EntryAbility',*/
            action: wantConstant.Action.ACTION_IMAGE_CAPTURE,
            entities: [wantConstant.Entity.ENTITY_HOME]
          }

          // UIAbilityContext.startAbilityForResult
          this.context.startAbilityForResult(want).then(result => {
            hilog.info(0x1111, 'info:startAbilityForResult', JSON.stringify(result))
          })
        })
    }
    .width('100%')
    .height('100%')
  }
}