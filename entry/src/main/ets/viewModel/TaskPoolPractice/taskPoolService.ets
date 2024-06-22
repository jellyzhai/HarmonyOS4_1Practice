export interface SeaBeingsConstructorParams {
  name: string
  speed: number
  width: number
  height: number
  x: number
  y: number
}

export const SeaBeingsConstructorParamsArr: SeaBeingsConstructorParams[] = [
  {
    name: 'crab',
    width: 26,
    height: 26,
    speed: 0.5,
    x: 0,
    y: 0,
  },
  {
    name: 'small_lobster',
    width: 30,
    height: 30,
    speed: 0.6,
    x: 0,
    y: 0,
  },
  {
    name: 'squid',
    width: 34,
    height: 34,
    speed: 0.7,
    x: 0,
    y: 0,
  },
  {
    name: 'gold_fish',
    width: 39,
    height: 39,
    speed: 0.8,
    x: 0,
    y: 0,
  },
  {
    name: 'swordfish',
    width: 42,
    height: 42,
    speed: 0.9,
    x: 0,
    y: 0,
  },
  {
    name: 'bomb',
    width: 45,
    height: 45,
    speed: 1,
    x: 0,
    y: 0,
  }
]

@Observed
export class SeaBeings {
  name: string
  speed: number
  width: number
  height: number
  x: number
  y: number

  constructor(instance: SeaBeingsConstructorParams) {
    this.name = instance.name
    this.speed = instance.speed
    this.width = instance.width
    this.height = instance.height
    this.x = instance.x
    this.y = instance.y
  }
}

export const seaBeingsArr: SeaBeings[] = [
  new SeaBeings({
    name: 'crab',
    width: 26,
    height: 26,
    speed: 0.5,
    x: 0,
    y: 0,
  }),
  new SeaBeings({
    name: 'small_lobster',
    width: 30,
    height: 30,
    speed: 0.6,
    x: 0,
    y: 0,
  }),
  new SeaBeings({
    name: 'squid',
    width: 34,
    height: 34,
    speed: 0.7,
    x: 0,
    y: 0,
  }),
  new SeaBeings({
    name: 'gold_fish',
    width: 39,
    height: 39,
    speed: 0.8,
    x: 0,
    y: 0,
  }),
  new SeaBeings({
    name: 'swordfish',
    width: 42,
    height: 42,
    speed: 0.9,
    x: 0,
    y: 0,
  }),
  new SeaBeings({
    name: 'bomb',
    width: 45,
    height: 45,
    speed: 1,
    x: 0,
    y: 0,
  }),
]

// @Sendable
// class SeaAnimalHandler {
//
// }

@Concurrent
export function getPositionX(x: number, width: number, speed: number, initPositionX: number): number {
  x -= speed * width

  if (x < -width) {
    x = initPositionX
  }

  console.log('test_tag getPositionX', x.toString())
  return x
}