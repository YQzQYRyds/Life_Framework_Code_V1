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

import { webview } from '@kit.ArkWeb'
import { BuilderNameConstants, RouterModule } from 'RouterModule'

@Builder
export function ResidencePermitBuilder() {
  ResidencePermitPage()
}

@Component
export struct ResidencePermitPage {
  @StorageLink('topRectHeight') topRectHeight: number = 0
  pathStack: NavPathStack = new NavPathStack()
  webController: webview.WebviewController = new webview.WebviewController()
  build() {
    NavDestination() {
      Column(){
        Row(){
          Image($r('app.media.pic1'))
            .width(px2vp(82 * 3.5))
            .height(px2vp(52 * 3.5))
            .borderRadius(px2vp(8 * 3.5))
            .margin({left:px2vp(12 * 3.5)})
          Text('居住证办理管理')
            .fontSize(px2vp(16 * 3.5))
            .fontWeight(500)
            .margin({left:px2vp(16 * 3.5)})
          Image($r('app.media.arrow'))
            .width(px2vp(6.87 * 3.5))
            .height(px2vp(14.18 * 3.5))
            .margin({left:90})
        }
        .width(px2vp(328 * 3.5))
        .height(px2vp(84* 3.5))
        .borderRadius(px2vp(16 * 3.5))
        .margin({top:px2vp(30 * 3.5)})
        .backgroundColor('#FFFFFF')
        Text('办理服务')
          .fontSize(px2vp(18 * 3.5))
          .fontWeight(700)
          .margin({top:px2vp(24 * 3.5)})

        Row(){
          Image($r('app.media.pic2'))
            .width(px2vp(82 * 3.5))
            .height(px2vp(52 * 3.5))
            .borderRadius(px2vp(8 * 3.5))
            .margin({left:px2vp(12 * 3.5)})
          Text('居住登记')
            .fontSize(px2vp(16 * 3.5))
            .fontWeight(500)
            .margin({left:px2vp(16 * 3.5)})
          Image($r('app.media.arrow'))
            .width(px2vp(6.87 * 3.5))
            .height(px2vp(14.18 * 3.5))
            .margin({left:144})
        }
        .width(px2vp(328 * 3.5))
        .height(px2vp(84* 3.5))
        .borderRadius(px2vp(16 * 3.5))
        .margin({top:px2vp(8 * 3.5)})
        .backgroundColor('#FFFFFF')

        Row(){
          Image($r('app.media.pic3'))
            .width(px2vp(82 * 3.5))
            .height(px2vp(52 * 3.5))
            .borderRadius(px2vp(8 * 3.5))
            .margin({left:px2vp(12 * 3.5)})
          Text('其他办理')
            .fontSize(px2vp(16 * 3.5))
            .fontWeight(500)
            .margin({left:px2vp(16 * 3.5)})
          Image($r('app.media.arrow'))
            .width(px2vp(6.87 * 3.5))
            .height(px2vp(14.18 * 3.5))
            .margin({left:144})
        }
        .width(px2vp(328 * 3.5))
        .height(px2vp(84* 3.5))
        .borderRadius(px2vp(16 * 3.5))
        .margin({top:px2vp(12 * 3.5)})
        .backgroundColor('#FFFFFF')

      }
      .alignItems(HorizontalAlign.Start)
    }
    .backButtonIcon($r('app.media.ic_public_back'))
    .backgroundColor('#F1F3F5')
    .title('居住证办理')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .padding({top:this.topRectHeight})
  }
}

const builderName = BuilderNameConstants.ResidencePermit;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ResidencePermitBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

