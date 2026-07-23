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
import SocialSecurityData, { Category } from '../viewmodle/SocialSecurityData'
import SocialSecurityModel from '../viewmodle/SocialSecurityModel'
import { BuilderNameConstants, RouterModule } from 'RouterModule'
import './SocialSecurityDetailPage'

@Builder
export function SocialSecurityBuilder() {
  SocialSecurityPage()
}

@Builder
function HeadBuilder(socialSecurityData: SocialSecurityData, pathStack: NavPathStack) {
  Column() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width('24vp')
        .height('24vp')
        .fillColor(Color.White)
        .margin({ left: '16vp' })
        .onClick(() => pathStack.pop())

      Row() {
        Text(`${socialSecurityData.name}`)
          .fontSize('22vp')
          .fontWeight(600)
          .fontColor(Color.White)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(' | ')
          .fontSize('22vp')
          .fontWeight(600)
          .fontColor(Color.White)
          .margin({ left: '8vp', right: '8vp' })
        Text(`${socialSecurityData.company}`)
          .fontSize('22vp')
          .fontWeight(600)
          .fontColor(Color.White)
          .margin({ left: '8vp' })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .margin({ right: '16vp' })
    }
    .width(CommonConstants.FULL_PARENT)
    .margin({ top: '16vp' })

    Column() {
      Row() {
        Text('参保城市：').fontSize('14vp').fontColor(Color.White).fontWeight(500)
        Text(`${socialSecurityData.city}`).fontSize('14vp').fontColor(Color.White).fontWeight(400).margin({ left: '4vp' })
        Text(' | ').fontSize('14vp').fontColor(Color.White).margin({ left: '8vp', right: '8vp' })
        Text('缴费基数：').fontSize('14vp').fontColor(Color.White).fontWeight(500)
        Text(`${socialSecurityData.baseAmount.toFixed(2)}`).fontSize('14vp').fontColor(Color.White).fontWeight(400).margin({ left: '4vp' })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: '16vp' })

      Row() {
        Text('账户状态：').fontSize('14vp').fontColor(Color.White).fontWeight(500)
        Text(`${socialSecurityData.status ? '正常 ✔' : '停用'}`).fontSize('14vp').fontColor(Color.White).fontWeight(400).margin({ left: '4vp' })
        Text(' | ').fontSize('14vp').fontColor(Color.White).margin({ left: '8vp', right: '8vp' })
        Text('社保账号：').fontSize('14vp').fontColor(Color.White).fontWeight(500)
        Text(`${socialSecurityData.idCard}`).fontSize('14vp').fontColor(Color.White).fontWeight(400).margin({ left: '4vp' })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: '12vp' })
    }
    .width(CommonConstants.FULL_PARENT)
    .margin({ top: '20vp', bottom: '16vp' })
    .padding({ left: '16vp', right: '16vp' })

  }
  .width(CommonConstants.FULL_PARENT)
}

@Builder
function CenterBuilder(categories: Category[], pathStack: NavPathStack, baseAmount: number) {
  Column() {
    Scroll() {
      Column() {
        ForEach(categories, (item: Category) => {
          Row() {
            Image(item.icon)
              .width('48vp')
              .height('48vp')
              .margin({ left: '16vp' })
              .fillColor('#FF8C00')

            Column() {
              Text(`${item.title}`)
                .fontSize('18vp')
                .fontWeight(500)
              if (item.desc) {
                Text(`${item.desc}`)
                  .fontSize('13vp')
                  .fontColor(Color.Gray)
                  .margin({ top: '6vp' })
              }
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: '16vp' })
            .layoutWeight(1)

            Column() {
              Text(`${item.money.toFixed(2)}`)
                .fontSize('20vp')
                .fontColor('#333333')
                .fontWeight(600)
              if (item.subMoney) {
                Text(`本月存缴: +${item.subMoney.toFixed(2)}`)
                  .fontSize('12vp')
                  .fontColor('#FF8C00')
                  .margin({ top: '4vp' })
              }
            }
            .alignItems(HorizontalAlign.End)
            .margin({ right: '8vp' })

            Image($r('app.media.ic_public_arrow_right'))
              .width('20vp')
              .height('20vp')
              .opacity(0.5)
          }
          .width('100%')
          .height('72vp')
          .padding({ left: '8vp', right: '8vp' })
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            // 使用普通对象字面量传参，避免类实例序列化丢失数据
            let params: Record<string, Object> = {
              'title': item.title,
              'money': item.money,
              'subMoney': item.subMoney || 0,
              'desc': item.desc || '',
              'baseAmount': baseAmount
            };
            pathStack.pushPathByName(CommonConstants.SocialSecurityDetail, params);
          })
        }, (item: Category) => JSON.stringify(item))
      }
      .width('100%')
      .padding({ top: '10vp', bottom: '20vp' })
    }
    .scrollBar(BarState.Off)
  }
  .width('95%')
  .margin({ top: px2vp(21 * 3.5) })
  .backgroundColor(Color.White)
  .borderRadius(px2vp(12 * 3.5))
}

@Component
struct SocialSecurityPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0

  build() {
    NavDestination() {
      Column() {
        HeadBuilder(SocialSecurityModel.getBillsData(), this.pathStack)
        CenterBuilder(SocialSecurityModel.getBillsData().categories, this.pathStack,
          SocialSecurityModel.getBillsData().baseAmount)
      }
      .width('100%')
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .backgroundColor('#F1F3F5')
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize({ width: '100%', height: px2vp(235 * 3.5) })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = BuilderNameConstants.SocialSecurity;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SocialSecurityBuilder);
  RouterModule.registerBuilder(builderName, builder);
}