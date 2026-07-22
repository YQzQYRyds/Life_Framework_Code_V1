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
import { GlobalContext } from '../Util/GlobalContext'
import { BuilderNameConstants, RouterModule } from 'RouterModule';

@Builder
export function CodeBuilder() {
  Code()
}

@Component
export struct Code {
  @StorageLink('topRectHeight') topRectHeight: number = 0
  @State pixelMap: image.PixelMap = GlobalContext.getContext().getObject('px') as image.PixelMap
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        Image(this.pixelMap).width(300).height(300).objectFit(ImageFit.Contain)
      }
    }.title('身份码')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .margin({top:this.topRectHeight})

  }
}

const builderName = BuilderNameConstants.Code;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(CodeBuilder);
  RouterModule.registerBuilder(builderName, builder);
}