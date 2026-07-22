/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import CommonConstants from 'common/constants/CommonConstants'
import RentingHouseModel from '../viewmodle/RentingHouseModel'
import RentingHouseData from '../viewmodle/RentingHouseData'
import { ArrayList } from '@kit.ArkTS'
import { BuilderNameConstants, RouterModule } from 'RouterModule'
import { ButtonOne , ButtonTwo, ButtonThree } from '../viewmodle/ButtonData'

@Builder
export function RentingHouseBuilder() {
  RentingHousePage()
}

@Builder
function contentBuilder(houseData: Tmp) {
  List({space:px2vp(33* 3.5)}) {
    ForEach(houseData.houseData.convertToArray(), (item: RentingHouseData) => {
      ListItem() {
        Row() {
          Image(item.img)
            .width(px2vp(90 * 3.5))
            .height(px2vp(63 * 3.5))
            .borderRadius(px2vp(8 * 3.5))
            .margin({ left: px2vp(16 * 3.5) })
          Column() {
            Text(`${item.rentingTag} · ${item.roomName} · ${item.roomType}`)
              .fontSize(px2vp(16 * 3.5))
              .fontWeight(500)
            Text(`${item.size}`)
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(400)
              .margin({ top: px2vp(2 * 3.5) })
              .fontColor(Color.Grey)
            Text(`${item.price}元/月`)
              .fontColor('#E84026')
              .fontSize(px2vp(14 * 3.5))
              .margin({ top: '5vp' })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: '15vp' })
        }
        .justifyContent(FlexAlign.Start)
        .width(CommonConstants.FULL_PARENT)
        .height(px2vp(63 * 3.5))
      }
    })
  }
  .margin({top:px2vp(35 * 3.5)})
}


function formatData(data: RentingHouseData[]) {
  let houseData: ArrayList<RentingHouseData> = new ArrayList()
  data.forEach(item => {
    houseData.add(item)
  })
  return houseData
}

@Component
export struct RentingHousePage {
  pathStack: NavPathStack = new NavPathStack()

  private buttonList1: ButtonOne[] = [
    new ButtonOne($r('app.string.sublease')),
    new ButtonOne($r('app.string.whole'))
  ];
  private buttonList2: ButtonTwo[] = [
    new ButtonTwo($r('app.string.one')),
    new ButtonTwo($r('app.string.two')),
    new ButtonTwo($r('app.string.three')),
  ];
  private buttonList3: ButtonThree[] = [
    new ButtonThree($r('app.string.hardcover')),
    new ButtonThree($r('app.string.lite'))
  ];
  @State houseData: ArrayList<RentingHouseData> = new ArrayList()

  aboutToAppear(): void {
    this.houseData = formatData(RentingHouseModel.getHouseData())
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Button() {
            Text('全部')
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(400)
              .fontColor(Color.White)
              .padding({ left: px2vp(2 * 3.5) })
          }
          .borderRadius(px2vp(56 * 3.5))
          .width(px2vp(52 * 3.5))
          .height(px2vp(28 * 3.5))
          .margin({ right: px2vp(11 * 3.5) })

          ForEach(this.buttonList1, (item: ButtonOne, index: number) => {
            Button() {
              Text(item.text)
                .fontSize(px2vp(14 * 3.5))
                .fontWeight(400)
                .fontColor(Color.Black)
                .padding({ left: px2vp(2 * 3.5) })
            }
            .borderRadius(px2vp(56 * 3.5))
            .width(px2vp(52 * 3.5))
            .height(px2vp(28 * 3.5))
            .margin({ right: px2vp(11 * 3.5) })
            .backgroundColor('#E5E5E5')
          }, (item: ButtonOne, index: number) => index + JSON.stringify(item))
        }
        .justifyContent(FlexAlign.Start)
        .margin({ left: px2vp(16 * 3.5) })

        Row() {
          Button() {
            Text('全部')
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(400)
              .fontColor(Color.White)
              .padding({ left: px2vp(2 * 3.5) })
          }
          .borderRadius(px2vp(56 * 3.5))
          .width(px2vp(52 * 3.5))
          .height(px2vp(28 * 3.5))
          .margin({ right: px2vp(11 * 3.5) })

          ForEach(this.buttonList2, (item: ButtonTwo , index: number) => {
            Button() {
              Text(item.text)
                .fontSize(px2vp(14 * 3.5))
                .fontWeight(400)
                .fontColor(Color.Black)
                .padding({ left: px2vp(2 * 3.5) })
            }
            .borderRadius(px2vp(56 * 3.5))
            .width(px2vp(66 * 3.5))
            .height(px2vp(28 * 3.5))
            .margin({ right: px2vp(11 * 3.5) })
            .backgroundColor('#E5E5E5')
          }, (item: ButtonTwo , index: number) => index + JSON.stringify(item))
        }
        .margin({ top: px2vp(12 * 3.5), left: px2vp(16 * 3.5) })

        Row() {
          Button() {
            Text('全部')
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(400)
              .fontColor(Color.White)
              .padding({ left: px2vp(2 * 3.5) })
          }
          .borderRadius(px2vp(56 * 3.5))
          .width(px2vp(52 * 3.5))
          .height(px2vp(28 * 3.5))
          .margin({ right: px2vp(11 * 3.5) })

          ForEach(this.buttonList3, (item:ButtonThree, index: number) => {
            Button() {
              Text(item.text)
                .fontSize(px2vp(14 * 3.5))
                .fontWeight(400)
                .fontColor(Color.Black)
                .padding({ left: px2vp(2 * 3.5) })
            }
            .borderRadius(px2vp(56 * 3.5))
            .width(px2vp(52 * 3.5))
            .height(px2vp(28 * 3.5))
            .margin({ right: px2vp(11 * 3.5) })
            .backgroundColor('#E5E5E5')
          }, (item: ButtonThree, index: number) => index + JSON.stringify(item))
        }
        .margin({ top: px2vp(12 * 3.5), left: px2vp(16 * 3.5) })

        contentBuilder({ houseData: this.houseData })
      }
      .margin({top:px2vp(14 * 3.5)})
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Color.White)
    }
    .title('房屋出租')
    .margin({top:30})
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

//按引用传递参数时，传递的参数可为状态变量，且状态变量的改变会引起@Builder方法内的UI刷新 中间类
class Tmp {
  houseData: ArrayList<RentingHouseData> = new ArrayList()
}

const builderName = BuilderNameConstants.RentingHouse;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(RentingHouseBuilder);
  RouterModule.registerBuilder(builderName, builder);
}



