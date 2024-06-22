import { Params } from '../model/RouteParamsModel';
import router from '@ohos.router';
import { HeaderNav } from '../components/HeaderNav';
import webSocket from '@ohos.net.webSocket';
import promptAction from '@ohos.promptAction';

enum TerminalType {
  server = 'server',
  client = 'client',
}

@Observed
class MessageEntity {
  terminalType: TerminalType;
  message: string;
  date: Date;
  sending?: boolean;
  sendSuccess?: boolean;

  constructor(terminalType: TerminalType,
              message: string,
              date: Date,
              sending?: boolean,
              sendSuccess?: boolean) {
    this.terminalType = terminalType
    this.message = message
    this.date = date
    this.sending = sending
    this.sendSuccess = sendSuccess
    // for (const item of (Object.entries(obj) as Array<[string, TerminalType|string| boolean| Date]>)) {
    //   Reflect.set(this, item[0], item[1])
    // }
  }
}

// 需要模拟器或实体机 来测试
@Entry
@Component
struct WebSocketPractice {
  title: string = (router.getParams() as Params).title
  ws: webSocket.WebSocket = webSocket.createWebSocket()
  isConnected = false
  @State sending: boolean = false
  @State sendSuccess: boolean = false
  @State typingMsg: string = ''
  @State messages: MessageEntity[] = [
    new MessageEntity(TerminalType.server,
      'from server',
      new Date()
    ),
    new MessageEntity(TerminalType.client,
      'from client',
      new Date(Date.now() + 6000)
    ),
  ];

  aboutToAppear(): void {
    this.ws.on('message', (err, data) => {
      console.log('test_tag', JSON.stringify(err))
      console.log('test_tag', JSON.stringify(data))
      if (!err) {
        this.messages.push(new MessageEntity(TerminalType.server,
          data as string,
          new Date()
        ))
      }
    })

    this.ws.on('close', (err, data) => {
      if (!err) {
        this.isConnected = false
      }
    })

    this.ws.connect('http://192.168.0.116:8080').then((isConnected) => {
      console.log('test_tag this.ws.connect', JSON.stringify(isConnected))
      this.isConnected = isConnected
    })
  }

  build() {
    Column({ space: 6 }) {
      HeaderNav({ title: this.title })

      Column({ space: 16 }) {
        Text(this.isConnected ? '链接成功' : '链接已断开')
          .fontColor(this.isConnected ? Color.Green : Color.Gray)

        List({ space: 8 }) {
          ForEach(this.messages, (item: MessageEntity) => {
            ListItem() {
              MsgItem({ item: item })
            }
            .width('100%')
          })
        }
        .layoutWeight(1)
        .backgroundColor('rgba(0,0,0,0.1)')
        .borderRadius(8)
        .padding(10)

        Row({ space: 6 }) {
          TextArea({
            placeholder: '点击输入消息',
            text: this.typingMsg
          })
            .layoutWeight(1)
            .onChange(value => {
              console.log('TextArea onChange', value)
              this.typingMsg = value
            })

          Button('发送')
            .onClick(() => {
              if (!this.typingMsg.trim()) {
                promptAction.showToast({ message: '消息不能为空', duration: 3000 })
                return
              }

              if (this.isConnected) {
                this.sending = true
                const messageObj: MessageEntity = new MessageEntity(TerminalType.client,
                  this.typingMsg,
                  new Date(),
                  true
                )

                this.messages.push(messageObj)

                this.ws.send(this.typingMsg, (err) => {
                  messageObj.sending = false
                  messageObj.sendSuccess = !err
                })
                
                this.typingMsg = ''
              }
            })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .padding(10)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MsgItem {
  @ObjectLink item: MessageEntity

  aboutToAppear(): void {
    console.log('test_tag', 'MsgItem aboutToAppear', JSON.stringify(this.item))
  }

  build() {
    if (this.item.terminalType === TerminalType.server) {
      Row({ space: 6 }) {
        Text('S')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .borderRadius(6)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)

        Text(this.item.message)
          .padding(6)
          .borderRadius(6)
          .backgroundColor(Color.White)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Start)
    } else {
      Column({ space: 4 }) {
        Row({ space: 6 }) {
          Text(this.item.message)
            .padding(6)
            .borderRadius(6)
            .backgroundColor(Color.White)

          Text('C')
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
            .borderRadius(6)
            .backgroundColor(Color.Green)
            .fontColor(Color.White)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .justifyContent(FlexAlign.End)

        Text(this.item.sending ? '发送中...' : this.item.sendSuccess ? '' : '发送失败')
          .fontSize(14)
          .fontColor(this.item.sending ? Color.Gray : this.item.sendSuccess ? '' : Color.Red)
          .width('100%')
          .textAlign(TextAlign.End)
      }
      .width('100%')
    }
  }
}