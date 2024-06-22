import { WebSocketServer } from 'ws';

const wss = new WebSocketServer({ port: 8080 });

wss.on('connection', function connection(ws) {
  ws.on('error', console.error);

  ws.on('message', function message(data) {
    setTimeout(() => {
      ws.send('[server] 接收到了消息：' + data)
    }, 500)
  });

  ws.send('[server] 连接成功');
  console.log('连接成功');
});