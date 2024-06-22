import { HeaderNav } from '../components/HeaderNav';
import router from '@ohos.router';
import { Params } from '../model/RouteParamsModel';
import { getPositionX, SeaBeings, SeaBeingsConstructorParamsArr } from '../viewModel/TaskPoolPractice/taskPoolService';
import taskpool from '@ohos.taskpool';


/*
 * 预览器中 任务执行结果 是空数组，需要在模拟器或真机运行
 * */

@Entry
@Component
struct TaskPoolPractice {
  title: string = (router.getParams() as Params).title
  containerWidth = 300
  intervalID = 0
  colors: Color[] = [Color.Black, Color.Blue, Color.Brown, Color.Gray, Color.Green, Color.Orange]
  @State seaBeingsArr: Array<SeaBeings[]> = [];
  // 6 rows 4 columns
  getRandomNum = () => Math.floor(Math.random() * 6)

  aboutToAppear(): void {
    Array(6).fill(0).forEach(() => {
      const results: SeaBeings[] = []

      Array(4).fill(0).forEach(() => {
        results.push(new SeaBeings(SeaBeingsConstructorParamsArr[this.getRandomNum()]))
      })

      this.seaBeingsArr.push(results)
    })
  }

  updatePositionByTaskPool() {
    this.intervalID = setInterval(() => {
      this.seaBeingsArr.forEach(items => {
        items.forEach(item => {
          const task = new taskpool.Task(getPositionX, item.x, item.width, item.speed, this.containerWidth + item.width)

          taskpool.execute(task).then(result => {
            // item.x = result
            console.log('test_tag taskpool.execute(task)', JSON.stringify(result))
          }).catch((err: Object) => {
            console.log('err ', err)
          })
        })
      })
    }, 1000)
  }

  cancelUpdate() {
    clearInterval(this.intervalID)
  }

  build() {
    Column({space: 10}) {
      HeaderNav({ title: this.title })

      Grid() {
        ForEach(this.seaBeingsArr, (items: SeaBeings[]) => {
          ForEach(items, (item: SeaBeings) => {
            GridItem() {
              BeingsBox({ beings: item })
                .backgroundColor(this.colors[this.getRandomNum()])
            }
            .width(110)
          })
        })
      }
      .columnsGap(6)
      .rowsGap(6)

      Button('每隔1s更新一次值')
        .onClick(() => {
          this.updatePositionByTaskPool()
        })
      Button('取消更新')
        .onClick(() => {
          this.cancelUpdate()
        })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct BeingsBox {
  @ObjectLink beings: SeaBeings

  build() {
    Column({ space: 6 }) {
      Text(this.beings.name)
        .fontColor(Color.White)
      Text() {
        Span('positionX:')
        Span(this.beings.x.toString())
          .fontWeight(700)
      }
      .fontColor(Color.White)
    }
    .padding(6)
    .width('100%')
  }
}