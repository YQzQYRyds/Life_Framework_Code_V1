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

import BillsModel from '../viewmodle/BillsModel'
import BillsData from '../viewmodle/BillsData'
import CommonConstants from 'common/constants/CommonConstants'
import { BuilderNameConstants, RouterModule } from 'RouterModule'

@Builder
export function ChequeSheetBuilder() {
  ChequeSheetPage()
}

@Builder
function ContainBuilder() {
  List() {
    ForEach(BillsModel.getBillsData(), (item: BillsData) => {
      ListItem() {
        Row() {
          Row() {
            Row() {
              Image(item.img)
                .width(px2vp(40 * 3.5))
                .height(px2vp(40 * 3.5))
            }
            .height(CommonConstants.FULL_PARENT)
            .margin({
              left: '10vp'
            })

            Column() {
              Row() {
                Text(item.name)
                  .fontSize(px2vp(16 * 3.5))
                  .fontWeight(500)
                Text(item.price)
                  .fontSize(px2vp(16 * 3.5))
                  .fontWeight(500)
                  .padding({ left: px2vp(115 * 3.5) })
                  .margin({ right: px2vp(20 * 3.5) })
              }

              Row() {
                Text(item.tag)
                  .fontSize(px2vp(14 * 3.5))
                  .fontColor(Color.Grey)
                Text(item.detail)
                  .fontSize(px2vp(14 * 3.5))
                  .margin({ right: px2vp(16 * 3.5) })
                  .padding({ left: px2vp(120 * 3.5) })
              }
              .margin({ top: px2vp(4 * 3.5) })

              Text(item.date)
                .fontSize(px2vp(14 * 3.5))
                .fontColor(Color.Grey)
                .margin({ top: px2vp(4 * 3.5) })

            }
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .margin({ left: '20vp' })
          }
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(CommonConstants.FULL_PARENT)
        .height('80vp')
        .padding('10vp')
      }
      .margin({ top: px2vp(25 * 3.5) })
      .width(CommonConstants.FULL_PARENT)
    })
  }
  .width(CommonConstants.FULL_PARENT)
}

@Component
export struct ChequeSheetPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  build() {
    NavDestination() {
      Column() {
        ContainBuilder()
      }.backgroundColor(Color.White)
    }.margin({top:this.topRectHeight})
    .title('账单详情')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = BuilderNameConstants.ChequeSheet;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ChequeSheetBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
