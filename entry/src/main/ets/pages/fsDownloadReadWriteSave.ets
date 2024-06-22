import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import { Params } from '../model/RouteParamsModel';
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';
import hilog from '@ohos.hilog';
import resourceManager from '@ohos.resourceManager';
import request from '@ohos.request';
import picker from '@ohos.file.picker';

interface OverlayText { text: string }

@Entry
@Component
struct FsDownloadReadWriteSave {
  title: string = (router.getParams() as Params).title
  innerImg = $r('app.media.zfb_pro_pic3')
  externalImgUrl = 'https://developer.mozilla.org/static/media/mastodon.ef3a62906d984f615f00.svg'
  @StorageProp('uiAbilityContext') uiAbilityContext: common.UIAbilityContext = {} as common.UIAbilityContext
  @State fileDir: string = this.uiAbilityContext.filesDir;
  @State imgDownloadingText: string = '加载中...';
  @State imgDownloadingEndText: string = '长按图片下载';
  @State imgOverlayText: string = this.imgDownloadingText;
  @State isShowDownloadAppImgMenu: boolean = false;
  @State isShowDownloadNetworkImgMenu: boolean = false;
  @State fileNames: string[] = []

  async saveImgToUserDir(originUri: string, targetFileName: string) {
    try {
      // 默认打开方式就是 只读
      const originFile = fs.openSync(originUri, fs.OpenMode.READ_ONLY)

      const saveOption = new picker.PhotoSaveOptions()
      saveOption.newFileNames = [targetFileName]
      const viewPicker = new picker.PhotoViewPicker()

      // 返回用户文件夹的文件路径数组
      const uris = await viewPicker.save(saveOption)
      const targetFile = fs.openSync(uris[0], fs.OpenMode.READ_WRITE)

      let readCount = 0
      let offsetLength = 0
      const arrayBuffer = new ArrayBuffer(4096)

      // 返回读取到缓冲区的文件字节数。读取文件到内存缓冲区中
      readCount = fs.readSync(originFile.fd, arrayBuffer, {
        offset: offsetLength
      }) // {offset: number} 表示从源文件中开始读的字节长度位置

      while (readCount > 0) {
        // 返回写入到目标文件中的字节数。将内存缓冲区中的数据写入文件中
        fs.writeSync(targetFile.fd, arrayBuffer, { length: readCount }) // {length: number} 表示可写入的字节长度
        offsetLength += readCount
        readCount = fs.readSync(originFile.fd, arrayBuffer, { offset: offsetLength })
      }

      fs.closeSync(originFile)
      fs.closeSync(targetFile)

      promptAction.showToast({ message: '图片保存到用户目录' })
    } catch (error) {
      promptAction.showToast({ message: '图片保存到用户目录失败' })
      hilog.error(0x1111, 'test_tag 图片保存到用户目录失败:', JSON.stringify(error))
    }
  }

  hideAppImgDownloadBtn = () => {
    this.isShowDownloadAppImgMenu = false
  }
  downloadAppImg = () => {
    // resourceManager > getRawFileContent(path: string): Promise<Uint8Array>;
    this.uiAbilityContext.resourceManager.getMediaContent(this.innerImg, (error, result: Uint8Array) => {
      if (error) {
        hilog.error(0x1111, 'test_tag', `下载应用内部图片失败' + ${JSON.stringify(error)}`)
      } else {
        try {
          // 将应用代码中的图片资源，写入到加密应用文件夹中
          const file = fs.openSync(this.fileDir + 'jelly_zfb.png', fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE)
          fs.writeSync(file.fd, result)
          fs.closeSync(file)
        } catch (error) {
          promptAction.showToast({ message: '图片下载到应用目录失败' })
          hilog.error(0x1111, 'test_tag 图片下载到应用目录失败:', JSON.stringify(error))
        }

        this.saveImgToUserDir(this.fileDir + 'jelly_zfb.png', 'jelly_zfb.png')
      }
    })
  }
  hideNetworkImgDownloadBtn = () => {
    this.isShowDownloadNetworkImgMenu = false
  }
  downloadNetworkImg = async () => {
    // 下载网络图片到 应用文件夹 el1 中
    const downloadTask = await request.downloadFile(getContext(this), {
      url: this.externalImgUrl,
      filePath: this.fileDir + '/jelly_mastodon.svg'
    })

    downloadTask.on('complete', () => {
      // 可以到手机文件夹查看下载的文件
      this.saveImgToUserDir(this.fileDir + 'jelly_mastodon.svg', 'jelly_mastodon.svg')
    })

    downloadTask.on('fail', (error) => {
      promptAction.showToast({ message: '下载失败：' + error, duration: 3000 })
      hilog.error(0x1111, 'test_tag', `downloadTask.on'fail' + ${JSON.stringify(error)}`)
    })
  }

  showFileNamesInApp() {
    this.fileNames = fs.listFileSync(this.fileDir, {
      // 不循环往子目录查找
      recursion: false,
      filter: {
        suffix: ['.svg', '.png'],
        fileSizeOver: 0,
        displayName: ['jelly*']
      }
    })
  }

  @Builder
  TipForDownloadingPicture($$: OverlayText) {
    Text($$.text)
      .textAlign(TextAlign.Center)
      .backgroundColor('rgba(0,0,0,0.4)')
      .fontColor(Color.White)
  }

  @Builder
  DownloadTextInMenu(hideDownloadBtn: () => void, downloadCallback: () => void) {
    Text('下载')
      .padding({ top: 4, bottom: 4, left: 8, right: 8 })
      .onDisAppear(() => {
        console.log('hide')
        hideDownloadBtn()
      })
      .onClick(() => {
        downloadCallback()
      })
  }

  build() {
    Scroll() {
      Column({ space: 10 }) {
        HeaderNav({ title: this.title })

        Text('应用文件夹路径: ' + this.fileDir)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Divider()

        Image(this.innerImg)
          .width(150)
          .overlay(this.TipForDownloadingPicture({ text: this.imgDownloadingEndText }), { align: Alignment.Bottom })
          .gesture(
            LongPressGesture()
              .onAction(() => {
                this.isShowDownloadAppImgMenu = true
                promptAction.showToast({ message: '触发长按手势' })
              })
              .onActionEnd(() => {
                promptAction.showToast({ message: '长按手势结束' })
              }),
            GestureMask.Normal
          )
          .bindMenu(this.isShowDownloadAppImgMenu, this.DownloadTextInMenu(this.hideAppImgDownloadBtn, this.downloadAppImg))

        Divider()

        Image(this.externalImgUrl)
          .onComplete(() => {
            this.imgOverlayText = this.imgDownloadingEndText
          })
          .width(100)
          .height(100)
          .overlay(this.TipForDownloadingPicture({ text: this.imgOverlayText }), { align: Alignment.Bottom })
          .gesture(LongPressGesture().onAction(() => {
            this.isShowDownloadNetworkImgMenu = true
            promptAction.showToast({ message: '触发长按手势' })
          }).onActionEnd(() => {
            promptAction.showToast({ message: '长按手势结束' })
          }), GestureMask.Normal)
          .bindMenu(this.isShowDownloadNetworkImgMenu, this.DownloadTextInMenu(this.hideNetworkImgDownloadBtn, this.downloadNetworkImg))

        Divider()

        Button('显示文件列表名称(上面下载文件后，再点击)')
          .onClick(() => {
            this.showFileNamesInApp()
          })

        Text('加密应用文件夹中文件名：' + this.fileNames.toString())
      }
      .position({ y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}