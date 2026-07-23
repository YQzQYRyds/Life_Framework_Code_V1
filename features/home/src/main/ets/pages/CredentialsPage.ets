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

import { CardRecognition, CardRecognitionResult, CardType } from '@kit.VisionKit'
import { BuilderNameConstants, RouterModule } from 'RouterModule';


@Builder
export function CredentialsBuilder() {
  CredentialsPage()
}

@Component
struct CredentialsPage {
  @StorageLink('topRectHeight') topRectHeight: number = 0
  pathStack: NavPathStack = new NavPathStack()

  private goBack(): void {
    try {
      this.pathStack.pop()
    } catch {
      // 路由栈尚未就绪或页面已退出时无需再次回退。
    }
  }

  private handleRecognitionResult(isSuccess: boolean): void {
    try {
      const message = isSuccess ? '证件识别完成' : '证件识别已取消或失败'
      this.getUIContext().getPromptAction().showToast({ message: message })
    } catch {
      // Toast 失败不应影响识别页安全退出。
    }
    this.goBack()
  }

  @Builder
  UnsupportedView() {
    Column({ space: 16 }) {
      Image($r('app.media.cards_filled'))
        .width(96)
        .height(96)
      Text('当前设备不支持证件识别')
        .fontSize('22fp')
        .fontWeight(FontWeight.Bold)
      Text('VisionKit 证件识别不支持模拟器，请在支持该能力的 HarmonyOS 真机上测试。')
        .fontSize('15fp')
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .lineHeight('22fp')
        .margin({ right: '28vp', left: '28vp' })
      Button('返回')
        .width('160vp')
        .height('44vp')
        .margin({ top: '8vp' })
        .onClick(() => {
          this.goBack()
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    NavDestination() {
      if (canIUse('SystemCapability.AI.Component.CardRecognition')) {
        CardRecognition({
          // 此处选择身份证类型作为示例 AUTO为自动识别
          supportType: CardType.CARD_ID,
          onResult: ((params: CardRecognitionResult) => {
            this.handleRecognitionResult(params.code === 0)
          })
        })
      } else {
        this.UnsupportedView()
      }
    }.title('扫描证件')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .margin({top:this.topRectHeight})
  }
}

const builderName = BuilderNameConstants.Credentials;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(CredentialsBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
