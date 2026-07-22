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

import { image } from '@kit.ImageKit';
// 模拟器临时注释，真机再放开
// import { CallbackParam, CardRecognition, CardSide, CardType } from '@kit.VisionKit'
import fs, { ReadOptions } from '@ohos.file.fs';
import { BuilderNameConstants, RouterModule } from 'RouterModule';

const TAG: string = 'CardRecognitionPage'


@Builder
export function CredentialsBuilder() {
  CredentialsPage()
}

@Component
struct CredentialsPage {
  @State chooseImage: PixelMap | undefined = undefined;
  @State dataValues: string = '';
  @StorageLink('topRectHeight') topRectHeight: number = 0
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column() {
        // =========模拟器临时注释识别组件=========
        // CardRecognition({
        //   // 此处选择身份证类型作为示例 AUTO为自动识别
        //   supportType: CardType.CARD_ID,
        //   callback: (async (params: CallbackParam) => {

        //     let file = fs.openSync(params.cardInfo?.back.originalImageUri, fs.OpenMode.READ_ONLY)
        //     let imageSource = image.createImageSource(file.fd)
        //     this.chooseImage = await imageSource.createPixelMap()
        //   })
        // }).onDisAppear(() => {
        //   this.pathStack.pop()
        // })
        Text('证件扫描页面（模拟器不支持卡证识别，请真机测试）')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
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