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
import mainViewModel from '../modle/MainViewModel'
import ItemData from '../modle/ItemData'
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'RouterModule'

@Builder
export function officeBuilder() {
  OfficePage()
}


@Builder
function SearchBuilder() {
  Row() {
    Image($r('app.media.ic_public_gps'))
      .width(px2vp(24 * 3.5))
      .height(px2vp(24 * 3.5))
      .margin({ left: px2vp(16 * 3.5) })
    Text('城市')
      .fontSize(px2vp(18 * 3.5))
      .fontColor(Color.White)
      .margin({ left: px2vp(2.11 * 3.5)})

    Search({ placeholder: '搜索办事服务...' })
      .placeholderColor(Color.White)
      .searchIcon({ src: $r('app.media.ic_public_input_search') })
      .width(px2vp(248 * 3.5))
      .height(px2vp(40 * 3.5))
      .margin({ left: px2vp(14 * 3.5)})
      .onClick(() => {
        buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.ServiceSearch)
      })

  }
  .width(CommonConstants.FULL_PARENT)
}

@Builder
function FirstGridBuilder(items: ItemData[]) {
  Grid() {
    ForEach(items, (item: ItemData) => {
      GridItem() {
        Column() {
          Image(item.img)
            .width(px2vp(48 * 3.5))
            .height(px2vp(48 * 3.5))
          Text(item.title)
            .fontSize(px2vp(16 * 3.5))
            .fontColor(Color.White)
            .margin({ top: px2vp(8 * 3.5) })
        }
      }
      .onClick(() => {
        if (item.name) {
          buildRouterModel(RouterNameConstants.ENTRY_HAP,
            BuilderNameConstants.OFFICE + '_' + item.name)
        }
      })
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr 1fr 1fr')
  .columnsGap('12vp')
  .rowsGap('12vp')
  .padding({ top: '25vp' })
  .margin({ left: px2vp(15 * 3.5) })
}

@Builder
function ServiceGridBuilder() {
  Grid() {
    ForEach(mainViewModel.getSecondGridData(), (item: ItemData, index: number) => {
      GridItem() {
        Column() {
          Text(`${index + 1}`)
            .fontSize(px2vp(14 * 3.5))
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .width(px2vp(36 * 3.5))
            .height(px2vp(36 * 3.5))
            .backgroundColor('#FF6B35')
            .borderRadius(px2vp(18 * 3.5))
            .textAlign(TextAlign.Center)
          Text(item.title)
            .fontSize(px2vp(12 * 3.5))
            .margin({ top: '8vp' })
            .fontWeight(400)
            .maxLines(1)
        }
      }
      .onClick(() => {
        buildRouterModel(RouterNameConstants.ENTRY_HAP,
          BuilderNameConstants.OFFICE + '_' + 'ServiceDetail')
      })
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
  .rowsTemplate('1fr 1fr')
  .columnsGap('4vp')
  .rowsGap('12vp')
  .height('130vp')
  .padding({ top: '12vp', bottom: '12vp', left: '8vp', right: '8vp' })
  .backgroundColor(Color.White)
}

@Builder
function ThirdGridBuilder(items: ItemData[]) {
  Grid() {
    ForEach(mainViewModel.getThirdGridData(), (thirdItem: ItemData, idx: number) => {
      GridItem() {
        Column() {
          Image(thirdItem.img)
            .width(px2vp(165 * 3.5))
            .height(px2vp(105 * 3.5))
            .borderRadius(px2vp(14 * 3.5))
            .margin({ top: px2vp(10 * 3.5) })
          Text(thirdItem.title)
            .fontSize(px2vp(18 * 3.5))
            .fontWeight(500)
            .margin({ top: px2vp(10 * 3.5) })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .onClick(() => {
        if (thirdItem.name) {
          AppStorage.setOrCreate('policySection', idx)
          buildRouterModel(RouterNameConstants.ENTRY_HAP,
            BuilderNameConstants.OFFICE + '_' + thirdItem.name)
        }
      })
      .margin({ right: px2vp(4 * 3.5), left: px2vp(10 * 3.5) })
    }, (secondItem: ItemData, index: number) => JSON.stringify(secondItem))
  }
  .height(px2vp(300 * 3.5))
  .columnsTemplate('1fr 1fr')
  .rowsTemplate('1fr 1fr')
  .columnsGap('8vp')
  .rowsGap('12vp')
  .margin({ top: px2vp(4 * 3.5), right: px2vp(10 * 3.5) })
}

@Builder
function TextBuilder(title: string, fSize: string = '18fp', fWeight: FontWeight = FontWeight.Medium,
  fColor: string = '#000000') {
  Text(title)
    .fontSize(fSize ? fSize : '18fp')
    .fontWeight(fWeight)
    .width(CommonConstants.FULL_PARENT)
    .margin({ top: px2vp(24 * 3.5), left: '15vp' })
    .fontColor(fColor)
    .fontWeight(FontWeight.Bold)
}


@Component
export struct OfficePage {
  private homePageStack: NavPathStack = new NavPathStack();
  @StorageLink('topRectHeight') topRectHeight: number = 0
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Column() {
            Row() {
              SearchBuilder()
            }
            .margin({ top: this.topRectHeight })

            Row() {
              FirstGridBuilder(mainViewModel.getFirstGridData())
            }
          }

          Column() {
            TextBuilder('灵活办公')
            ServiceGridBuilder()
            TextBuilder('最新政策')
            ThirdGridBuilder(mainViewModel.getThirdGridData())
          }
          .alignItems(HorizontalAlign.Start)
          .height('100%')
          .margin({ top: px2vp(28 * 3.5) })
          .backgroundColor(Color.White)
        }
      }
      .height(CommonConstants.FULL_PARENT)
      .scrollBar(BarState.Off)
    }
    .hideTitleBar(true)
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize(ImageSize.Contain)
    .backgroundColor(Color.Blue)
  }
}
