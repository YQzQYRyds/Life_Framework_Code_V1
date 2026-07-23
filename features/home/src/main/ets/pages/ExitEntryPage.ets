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
import { promptAction } from '@kit.ArkUI'

interface ServiceItem {
  icon: Resource
  title: string
  desc: string
}

@Builder
export function ExitEntryBuilder() {
  ExitEntryPage()
}

@Component
export struct ExitEntryPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0

  private services: ServiceItem[] = [
    { icon: $r('app.media.huzhao'), title: '护照办理', desc: '首次申领/换发/补发' } as ServiceItem,
    { icon: $r('app.media.gangao'), title: '港澳通行证', desc: '签注申请/续签' } as ServiceItem,
    { icon: $r('app.media.taiwan'), title: '台湾通行证', desc: '个人游/团队游签注' } as ServiceItem,
    { icon: $r('app.media.qianzheng'), title: '签证办理', desc: '出国签证在线预约' } as ServiceItem,
    { icon: $r('app.media.churu'), title: '出入境记录', desc: '查询个人出入境记录' } as ServiceItem,
    { icon: $r('app.media.bianjian'), title: '边检公告', desc: '口岸通关指引及政策' } as ServiceItem,
  ]

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width('24vp')
            .height('24vp')
            .fillColor(Color.Black)
            .margin({ left: '16vp' })
            .onClick(() => this.pathStack.pop())

          Text('出入境')
            .fontSize('20vp')
            .fontWeight(700)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .margin({ right: '40vp' })
        }
        .width('100%')
        .height('56vp')
        .backgroundColor(Color.White)

        Scroll() {
          Column() {
            ForEach(this.services, (item: ServiceItem, index: number) => {
              Row() {
                Image(item.icon)
                  .width(px2vp(40 * 3.5))
                  .height(px2vp(40 * 3.5))
                  .margin({ left: px2vp(16 * 3.5) })

                Column() {
                  Text(item.title)
                    .fontSize(px2vp(16 * 3.5))
                    .fontWeight(500)
                    .fontColor('#333333')
                  Text(item.desc)
                    .fontSize(px2vp(12 * 3.5))
                    .fontColor(Color.Gray)
                    .margin({ top: px2vp(4 * 3.5) })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: px2vp(16 * 3.5) })
                .layoutWeight(1)

                Image($r('app.media.arrow'))
                  .width(px2vp(7 * 3.5))
                  .height(px2vp(14 * 3.5))
                  .margin({ right: px2vp(16 * 3.5) })
              }
              .width('100%')
              .height(px2vp(76 * 3.5))
              .backgroundColor(Color.White)
              .border({
                width: { bottom: index < this.services.length - 1 ? 1 : 0 },
                color: '#F0F0F0',
                style: BorderStyle.Solid
              })
              .onClick(() => {
                promptAction.showToast({ message: `${item.title}功能开发中` })
              })
            })
          }
          .width('100%')
          .margin({ top: px2vp(16 * 3.5) })
        }
        .layoutWeight(1)
        .backgroundColor('#F1F3F5')
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = BuilderNameConstants.HOMEPAGE + '_ExitEntry'
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ExitEntryBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
