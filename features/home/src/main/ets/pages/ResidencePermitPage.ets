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

import { BuilderNameConstants, RouterModule } from 'RouterModule'
import CommonConstants from 'common/constants/CommonConstants'
import './ResidencePermitApplyPage'
import './ResidenceRegisterPage'

@Builder
export function ResidencePermitBuilder() {
  ResidencePermitPage()
}

@Component
export struct ResidencePermitPage {
  @StorageLink('topRectHeight') topRectHeight: number = 0
  pathStack: NavPathStack = new NavPathStack()
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          // 居住证办理管理 — 可点击跳转
          Row() {
            Image($r('app.media.pic1'))
              .width(px2vp(82 * 3.5))
              .height(px2vp(52 * 3.5))
              .borderRadius(px2vp(8 * 3.5))
              .margin({ left: px2vp(12 * 3.5) })
            Text('居住证办理管理')
              .fontSize(px2vp(16 * 3.5))
              .fontWeight(500)
              .margin({ left: px2vp(16 * 3.5) })
              .layoutWeight(1)
            Image($r('app.media.arrow'))
              .width(px2vp(7 * 3.5))
              .height(px2vp(14 * 3.5))
              .margin({ right: px2vp(16 * 3.5) })
          }
          .width('100%')
          .height(px2vp(84 * 3.5))
          .borderRadius(px2vp(16 * 3.5))
          .margin({ top: px2vp(30 * 3.5) })
          .backgroundColor('#FFFFFF')
          .onClick(() => {
            this.pathStack.pushPathByName(CommonConstants.ResidencePermitApply, undefined)
          })

          Text('办理服务')
            .fontSize(px2vp(18 * 3.5))
            .fontWeight(700)
            .margin({ top: px2vp(24 * 3.5) })

          // 居住登记
          Row() {
            Image($r('app.media.pic2'))
              .width(px2vp(82 * 3.5))
              .height(px2vp(52 * 3.5))
              .borderRadius(px2vp(8 * 3.5))
              .margin({ left: px2vp(12 * 3.5) })
            Text('居住登记')
              .fontSize(px2vp(16 * 3.5))
              .fontWeight(500)
              .margin({ left: px2vp(16 * 3.5) })
              .layoutWeight(1)
            Image($r('app.media.arrow'))
              .width(px2vp(7 * 3.5))
              .height(px2vp(14 * 3.5))
              .margin({ right: px2vp(16 * 3.5) })
          }
          .width('100%')
          .height(px2vp(84 * 3.5))
          .borderRadius(px2vp(16 * 3.5))
          .margin({ top: px2vp(8 * 3.5) })
          .backgroundColor('#FFFFFF')
          .onClick(() => {
            this.pathStack.pushPathByName(CommonConstants.ResidenceRegister, undefined)
          })

          // 其他办理
          Row() {
            Image($r('app.media.pic3'))
              .width(px2vp(82 * 3.5))
              .height(px2vp(52 * 3.5))
              .borderRadius(px2vp(8 * 3.5))
              .margin({ left: px2vp(12 * 3.5) })
            Text('其他办理')
              .fontSize(px2vp(16 * 3.5))
              .fontWeight(500)
              .margin({ left: px2vp(16 * 3.5) })
              .layoutWeight(1)
            Image($r('app.media.arrow'))
              .width(px2vp(7 * 3.5))
              .height(px2vp(14 * 3.5))
              .margin({ right: px2vp(16 * 3.5) })
          }
          .width('100%')
          .height(px2vp(84 * 3.5))
          .borderRadius(px2vp(16 * 3.5))
          .margin({ top: px2vp(12 * 3.5), bottom: px2vp(30 * 3.5) })
          .backgroundColor('#FFFFFF')
        }
        .width('100%')
        .padding({ left: px2vp(16 * 3.5), right: px2vp(16 * 3.5) })
      }
      .scrollBar(BarState.Off)
    }
    .backButtonIcon($r('app.media.ic_public_back'))
    .backgroundColor('#F1F3F5')
    .title('居住证办理')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .padding({ top: this.topRectHeight })
  }
}

const builderName = BuilderNameConstants.ResidencePermit;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ResidencePermitBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

