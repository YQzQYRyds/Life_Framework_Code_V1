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

@Builder
export function RentingHouseBuilder() {
  RentingHousePage()
}

function formatData(data: RentingHouseData[]): ArrayList<RentingHouseData> {
  let list: ArrayList<RentingHouseData> = new ArrayList()
  data.forEach(item => list.add(item))
  return list
}

@Preview
@Component
export struct RentingHousePage {
  pathStack: NavPathStack = new NavPathStack()
  private allData: RentingHouseData[] = []
  @State filteredData: RentingHouseData[] = []

  // 筛选索引: 0=全部, 1=第一项, 2=第二项, 3=第三项
  @State rentIdx: number = 0
  @State roomIdx: number = 0
  @State decoIdx: number = 0

  // 筛选选项
  private rentOptions: string[] = ['全部', '合租', '整租']
  private roomOptions: string[] = ['全部', '一居室', '二居室', '三居室']
  private decoOptions: string[] = ['全部', '精装', '简装']

  aboutToAppear(): void {
    this.allData = RentingHouseModel.getHouseData()
    this.applyFilter()
  }

  applyFilter(): void {
    let result: RentingHouseData[] = []
    for (let i = 0; i < this.allData.length; i++) {
      let item: RentingHouseData = this.allData[i]
      if (this.rentIdx > 0 && item.rentingTag !== this.rentOptions[this.rentIdx]) {
        continue
      }
      if (this.roomIdx > 0 && item.roomType !== this.roomOptions[this.roomIdx]) {
        continue
      }
      if (this.decoIdx > 0 && item.decoration !== this.decoOptions[this.decoIdx]) {
        continue
      }
      result.push(item)
    }
    this.filteredData = result
  }

  build() {
    NavDestination() {
      Column() {
        // 租用方式筛选行
        Row({ space: px2vp(10 * 3.5) }) {
          ForEach(this.rentOptions, (label: string, index: number) => {
            Text(label)
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(this.rentIdx === index ? 500 : 400)
              .fontColor(this.rentIdx === index ? Color.White : '#333333')
              .backgroundColor(this.rentIdx === index ? '#0A59F7' : '#F5F5F5')
              .border({
                width: this.rentIdx === index ? 0 : 1,
                color: '#DDDDDD',
                style: BorderStyle.Solid
              })
              .borderRadius(px2vp(56 * 3.5))
              .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(4 * 3.5), bottom: px2vp(4 * 3.5) })
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.rentIdx = index
                this.applyFilter()
              })
          })
        }
        .justifyContent(FlexAlign.Start)
        .padding({ left: px2vp(16 * 3.5) })

        // 户型筛选行
        Row({ space: px2vp(10 * 3.5) }) {
          ForEach(this.roomOptions, (label: string, index: number) => {
            Text(label)
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(this.roomIdx === index ? 500 : 400)
              .fontColor(this.roomIdx === index ? Color.White : '#333333')
              .backgroundColor(this.roomIdx === index ? '#0A59F7' : '#F5F5F5')
              .border({
                width: this.roomIdx === index ? 0 : 1,
                color: '#DDDDDD',
                style: BorderStyle.Solid
              })
              .borderRadius(px2vp(56 * 3.5))
              .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(4 * 3.5), bottom: px2vp(4 * 3.5) })
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.roomIdx = index
                this.applyFilter()
              })
          })
        }
        .justifyContent(FlexAlign.Start)
        .padding({ left: px2vp(16 * 3.5) })
        .margin({ top: px2vp(12 * 3.5) })

        // 装修筛选行
        Row({ space: px2vp(10 * 3.5) }) {
          ForEach(this.decoOptions, (label: string, index: number) => {
            Text(label)
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(this.decoIdx === index ? 500 : 400)
              .fontColor(this.decoIdx === index ? Color.White : '#333333')
              .backgroundColor(this.decoIdx === index ? '#0A59F7' : '#F5F5F5')
              .border({
                width: this.decoIdx === index ? 0 : 1,
                color: '#DDDDDD',
                style: BorderStyle.Solid
              })
              .borderRadius(px2vp(56 * 3.5))
              .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(4 * 3.5), bottom: px2vp(4 * 3.5) })
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.decoIdx = index
                this.applyFilter()
              })
          })
        }
        .justifyContent(FlexAlign.Start)
        .padding({ left: px2vp(16 * 3.5) })
        .margin({ top: px2vp(12 * 3.5) })

        // 房源列表
        if (this.filteredData.length === 0) {
          Text('暂无匹配房源')
            .fontSize(px2vp(16 * 3.5))
            .fontColor(Color.Gray)
            .margin({ top: px2vp(60 * 3.5) })
            .width('100%')
            .textAlign(TextAlign.Center)
        }

        List({ space: px2vp(16 * 3.5) }) {
          ForEach(this.filteredData, (item: RentingHouseData, index: number) => {
            ListItem() {
              Row() {
                Image(item.img)
                  .width(px2vp(90 * 3.5))
                  .height(px2vp(63 * 3.5))
                  .borderRadius(px2vp(8 * 3.5))
                  .margin({ left: px2vp(16 * 3.5) })

                Column() {
                  Text(item.roomName)
                    .fontSize(px2vp(16 * 3.5))
                    .fontWeight(500)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Row({ space: px2vp(6 * 3.5) }) {
                    Text(item.rentingTag)
                      .fontSize(px2vp(11 * 3.5))
                      .fontColor('#0A59F7')
                      .backgroundColor('#EBF2FF')
                      .borderRadius(px2vp(4 * 3.5))
                      .padding({ left: px2vp(4 * 3.5), right: px2vp(4 * 3.5), top: px2vp(1 * 3.5), bottom: px2vp(1 * 3.5) })
                    Text(item.roomType)
                      .fontSize(px2vp(11 * 3.5))
                      .fontColor('#0A59F7')
                      .backgroundColor('#EBF2FF')
                      .borderRadius(px2vp(4 * 3.5))
                      .padding({ left: px2vp(4 * 3.5), right: px2vp(4 * 3.5), top: px2vp(1 * 3.5), bottom: px2vp(1 * 3.5) })
                    Text(item.decoration)
                      .fontSize(px2vp(11 * 3.5))
                      .fontColor('#E8860C')
                      .backgroundColor('#FFF6EB')
                      .borderRadius(px2vp(4 * 3.5))
                      .padding({ left: px2vp(4 * 3.5), right: px2vp(4 * 3.5), top: px2vp(1 * 3.5), bottom: px2vp(1 * 3.5) })
                  }
                  .margin({ top: px2vp(4 * 3.5) })

                  Text(item.size)
                    .fontSize(px2vp(14 * 3.5))
                    .fontColor(Color.Grey)
                    .margin({ top: px2vp(2 * 3.5) })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: px2vp(15 * 3.5) })
                .layoutWeight(1)

                Text(`${item.price}元/月`)
                  .fontColor('#E84026')
                  .fontSize(px2vp(14 * 3.5))
                  .fontWeight(600)
                  .margin({ right: px2vp(16 * 3.5) })
              }
              .width(CommonConstants.FULL_PARENT)
              .height(px2vp(80 * 3.5))
              .alignItems(VerticalAlign.Center)
            }
          }, (item: RentingHouseData, index: number) => `${index}_${item.roomName}`)
        }
        .layoutWeight(1)
        .margin({ top: px2vp(16 * 3.5) })
      }
      .margin({ top: px2vp(14 * 3.5) })
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Color.White)
    }
    .title('房屋出租')
    .margin({ top: 30 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = BuilderNameConstants.RentingHouse;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(RentingHouseBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
