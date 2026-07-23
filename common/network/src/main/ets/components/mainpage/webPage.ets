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

import { webview } from '@kit.ArkWeb';
import { BuilderNameConstants, RouterModule, RouterNameConstants } from 'RouterModule';


@Builder
export function webPageBuilder(value: object) {
  NavDestination() {
    WebPage({url:value["url"]})
  }.hideTitleBar(true).onBackPressed(()=>{
    RouterModule.popToName(RouterNameConstants.ENTRY_HAP,BuilderNameConstants.WebPage)
    return false;
  })
}


@Component
 struct WebPage{
  url:string="";
  private webController:WebviewController = new webview.WebviewController();
  build() {
    Flex(){
      Web({
        controller:this.webController,
        src:this.url
      }).onControllerAttached(()=>{
        this.webController.loadUrl(this.url)
      })
    }.width("100%").height("100%")
  }
}

let builderName: string = BuilderNameConstants.WebPage;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(webPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
