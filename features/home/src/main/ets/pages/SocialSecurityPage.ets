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
import { promptAction } from '@kit.ArkUI'
import { BuilderNameConstants, RouterModule } from 'RouterModule'

@Builder
export function SocialSecurityBuilder() {
  SocialSecurityPage()
}

@Builder
function HeadBuilder(socialSecurityData: SocialSecurityData) {
  Column() {
    Row() {
      Row() {
        Text(`${socialSecurityData.name}`)
          .fontSize(px2vp(18 * 3.5))
          .fontWeight(600)
          .fontColor(Color.White)
        Text(' | ')
          .fontSize(px2vp(18 * 3.5))
          .fontWeight(600)
          .fontColor(Color.White)
          .fontColor(Color.White)
          .margin({ left: '10vp' })
        Text(`${socialSecurityData.Company}`)
          .fontColor(Color.White)
          .fontSize(px2vp(18 * 3.5))
          .fontWeight(600)
          .fontColor(Color.White)
          .margin({ left: '10vp' })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: px2vp(20 * 3.5), left: px2vp(102 * 3.5) })

    }.justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_PARENT)

    Flex({
      justifyContent: FlexAlign.SpaceEvenly,
      direction: FlexDirection.Row
    }) {
      Row() {
        Column() {
          Text('账户状态')
            .fontSize(px2vp(12 * 3.5))
            .fontWeight(700)
            .fontColor(Color.White)
          Text(`${socialSecurityData.status ? '正常' : '停用'}`)
            .fontSize(px2vp(14 * 3.5))
            .fontWeight(400)
            .fontColor(Color.White)
            .margin({ top: '8vp' })
        }
        .margin({ top: px2vp(8 * 3.5), left: px2vp(50 * 3.5) })

        Column() {
          Text('个人账户')
            .fontSize(px2vp(12 * 3.5))
            .fontWeight(700)
            .fontColor(Color.White)
          Text(`${socialSecurityData.account}`)
            .fontSize(px2vp(14 * 3.5))
            .fontWeight(400)
            .fontColor(Color.White)
            .margin({ top: '8vp' })
        }
        .margin({ top: px2vp(8 * 3.5), right: px2vp(20 * 3.5) })

      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: '20vp' })
      .width(CommonConstants.FULL_PARENT)
    }

  }
  .onClick(() => {
    promptAction.showToast({
      message: '功能还在开发中'
    })
  })
  .width(CommonConstants.FULL_PARENT)
  .height('150vp')

}

@Builder
function CenterBuilder(categories: Category[]) {
  Column() {
    ForEach(categories, (item: Category) => {
      Row() {
        Row() {
          Image(item.icon)
            .width(px2vp(22 * 3.5))
            .height(px2vp(22 * 3.5))
            .margin({ left: px2vp(12 * 3.5) })

          Text(`${item.title}`)
            .fontSize(px2vp(16 * 3.5))
            .fontWeight(500)
            .margin({ left: px2vp(18 * 3.5) })
        }
        .margin({ top: px2vp(8 * 3.5) })
        .justifyContent(FlexAlign.Start)

        Row() {
          Text(`${item.money}`)
            .fontSize(px2vp(14 * 3.5))
            .fontWeight(400)
          Image($r('app.media.ic_public_arrow_right'))
            .width('22vp')
            .height('22vp')
        }
        .opacity(0.5)
        .margin({ top: px2vp(8 * 3.5) })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PARENT)
      .height('50vp')
      .onClick(() => {
        promptAction.showToast({
          message: '功能还在开发中'
        })
      })
    }, (item: Category) => JSON.stringify(item))
  }
  .justifyContent(FlexAlign.Start)
  .width(px2vp(328 * 3.5))
  .height(px2vp(104 * 3.5))
  .margin({ top: px2vp(21 * 3.5) })
  .backgroundColor(Color.White)
  .borderRadius(px2vp(12 * 3.5))
}

@Builder
function TitleBuilder(title: string) {
  Text(title)
    .fontSize(px2vp(20 * 3.5))
    .width(CommonConstants.FULL_PARENT)
    .margin({ top: px2vp(14.5 * 3.5), left: px2vp(8 * 3.5) })
    .fontColor(Color.White)
    .fontWeight(700)
    .opacity(0.9)
}


@Component
struct SocialSecurityPage {
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column() {
        HeadBuilder(SocialSecurityModel.getBillsData())
        CenterBuilder(SocialSecurityModel.getBillsData().categories)
      }
      .margin({top:30})
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .backgroundColor('#F1F3F5')
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize({ width: px2vp(360 * 3.5), height: px2vp(235 * 3.5) })

  }
}


const builderName = BuilderNameConstants.SocialSecurity;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SocialSecurityBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
