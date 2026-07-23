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
import { BuilderNameConstants, RouterModule, RouterNameConstants } from 'RouterModule'
import { webview } from '@kit.ArkWeb'
import { promptAction } from '@kit.ArkUI'

@Builder
export function WebServiceBuilder(param: object) {
  NavDestination() {
    WebServicePage()
  }.hideTitleBar(true)
}

@Builder
function WebTopBar(title: string) {
  Row() {
    Image($r('app.media.spot_light'))
      .width(px2vp(20 * 3.5))
      .height(px2vp(20 * 3.5))
      .onClick(() => {
        RouterModule.pop(RouterNameConstants.ENTRY_HAP)
      })
      .margin({ left: px2vp(12 * 3.5) })

    Text(title)
      .fontSize(px2vp(18 * 3.5))
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .margin({ left: px2vp(8 * 3.5) })
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })

    Blank()

    Image($r('app.media.ic_public_input_search'))
      .width(px2vp(20 * 3.5))
      .height(px2vp(20 * 3.5))
      .margin({ right: px2vp(12 * 3.5) })
      .opacity(0.7)
  }
  .width(CommonConstants.FULL_PARENT)
  .height(px2vp(48 * 3.5))
  .backgroundColor('#FF6B35')
}

@Builder
function LoadingView() {
  Column() {
    LoadingProgress()
      .width(px2vp(36 * 3.5))
      .height(px2vp(36 * 3.5))
      .color('#FF6B35')
    Text('正在加载服务页面...')
      .fontSize(px2vp(14 * 3.5))
      .fontColor('#999999')
      .margin({ top: px2vp(12 * 3.5) })
  }
  .width(CommonConstants.FULL_PARENT)
  .height(CommonConstants.FULL_PARENT)
  .justifyContent(FlexAlign.Center)
}

@Component
struct WebServicePage {
  @StorageLink('topRectHeight') topRectHeight: number = 0
  private webController: WebviewController = new webview.WebviewController()
  @State isLoading: boolean = true
  @State loadError: boolean = false
  @State pageTitle: string = '在线办理'
  private loadUrl: string = 'https://www.gov.cn/fuwu/gongmin/'
  private doScroll: number = -1

  aboutToAppear(): void {
    let section: number = AppStorage.get('policySection') as number ?? -1
    if (section >= 0) {
      const titles: string[] = ['出生政策', '入学政策', '工作政策', '生活政策']
      const urls: string[] = [
        'https://www.gov.cn/fuwu/gongmin/chusheng/#1',
        'https://www.gov.cn/fuwu/gongmin/ruxue/#2',
        'https://www.gov.cn/fuwu/gongmin/gongzuo/#3',
        'https://www.gov.cn/fuwu/gongmin/shenghuo/#4'
      ]
      if (section < titles.length) {
        this.pageTitle = titles[section]
        this.loadUrl = urls[section]
        this.doScroll = section
      }
    }
  }

  build() {
    Column() {
      // 顶部栏
      WebTopBar(this.pageTitle)

      // WebView 内容区域
      Stack() {
        Web({
          controller: this.webController,
          src: this.loadUrl
        })
          .width(CommonConstants.FULL_PARENT)
          .height(CommonConstants.FULL_PARENT)
          .javaScriptAccess(true)
          .domStorageAccess(true)
          .onControllerAttached(() => {
            this.webController.loadUrl(this.loadUrl)
          })
          .onPageBegin(() => {
            this.isLoading = true
            this.loadError = false
          })
          .onPageEnd(() => {
            this.isLoading = false
            if (this.doScroll >= 0) {
              let section: number = this.doScroll
              this.doScroll = -1
              const positions: number[] = [0.55, 0.65, 0.75, 0.85]
              let pos: number = positions[section] ?? 0.6
              this.webController.runJavaScript(
                `setTimeout(() => { window.scrollTo(0, document.body.scrollHeight * ${pos}) }, 500)`)
            }
          })
          .onErrorReceive(() => {
            this.isLoading = false
            this.loadError = true
          })

        if (this.isLoading && !this.loadError) {
          LoadingView()
        }

        if (this.loadError) {
          Column() {
            Image($r('app.media.ic_search'))
              .width(px2vp(50 * 3.5))
              .height(px2vp(50 * 3.5))
              .opacity(0.4)

            Text('页面加载失败')
              .fontSize(px2vp(16 * 3.5))
              .fontColor('#999999')
              .margin({ top: px2vp(12 * 3.5) })

            Text('请检查网络连接后重试')
              .fontSize(px2vp(13 * 3.5))
              .fontColor('#CCCCCC')
              .margin({ top: px2vp(6 * 3.5) })

            Button('重新加载')
              .fontSize(px2vp(14 * 3.5))
              .fontColor(Color.White)
              .backgroundColor('#FF6B35')
              .borderRadius(px2vp(20 * 3.5))
              .width(px2vp(100 * 3.5))
              .height(px2vp(36 * 3.5))
              .margin({ top: px2vp(16 * 3.5) })
              .onClick(() => {
                this.loadError = false
                this.isLoading = true
                this.webController.loadUrl(this.loadUrl)
              })
          }
          .width(CommonConstants.FULL_PARENT)
          .height(CommonConstants.FULL_PARENT)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width(CommonConstants.FULL_PARENT)
      .layoutWeight(1)
    }
    .width(CommonConstants.FULL_PARENT)
    .height(CommonConstants.FULL_PARENT)
    .margin({ top: this.topRectHeight })
  }
}

const builderName = BuilderNameConstants.WebService;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(WebServiceBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
