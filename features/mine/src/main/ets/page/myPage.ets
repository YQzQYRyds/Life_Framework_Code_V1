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
import ItemData from '../modle/ItemData'
import MainViewModel from '../modle/MainViewModel'
import { TopPage } from '../page/TopPage'
import { LoginManager } from '../modle/LoginManager';
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'RouterModule';

/**
 * Service grid: My Account / Security (2 items).
 */
@Builder
function ServiceGrid(items: ItemData[]) {
  Grid() {
    ForEach(items, (item: ItemData) => {
      GridItem() {
        Column({ space: 8 }) {
          Image(item.img).width(40).height(40)
          Text(item.title).fontSize(14).fontColor('#333')
        }
        .width('100%').height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .backgroundColor('#F8F9FA')
      .borderRadius(12)
      .onClick(() => {
        if (item.name === 'security') {
          if (!LoginManager.isLoggedIn()) {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
          } else {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SecurityCenterPage);
          }
        } else if (item.name === 'account') {
          if (!LoginManager.isLoggedIn()) {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
          } else {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SecurityCenterPage);
          }
        }
      })
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr')
  .columnsGap(12).rowsGap(12)
  .height(80)
  .padding({ left: 16, right: 16 })
}

/**
 * Data cards: social security, card case, credit (2 columns).
 */
@Builder
function DataCards() {
  Grid() {
    ForEach(MainViewModel.getThirdGridData(), (item: ItemData) => {
      GridItem() {
        Column() {
          Text(item.title)
            .fontSize(15).fontWeight(FontWeight.Medium).fontColor(Color.White)
            .margin({ top: 12, left: 12 })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .height(80).borderRadius(10)
      .backgroundImage(item.img).backgroundImageSize(ImageSize.Cover)
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr')
  .columnsGap(12).rowsGap(12)
  .padding({ left: 16, right: 16 })
  .height(180)
}

/**
 * Credential grid: ID card, driver license, marriage (3 columns).
 */
@Builder
function CredentialGrid(items: ItemData[]) {
  Grid() {
    ForEach(items, (item: ItemData) => {
      GridItem() {
        Column({ space: 6 }) {
          Image(item.img).width(36).height(36)
          Text(item.title).fontSize(12).fontColor('#666')
        }
        .width('100%').height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .backgroundColor('#F8F9FA')
      .borderRadius(10)
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr 1fr')
  .columnsGap(10).rowsGap(10)
  .height(100)
  .padding({ left: 16, right: 16 })
}

/**
 * Section title.
 */
@Builder
function SectionTitle(title: string, topMargin: number = 16) {
  Row() {
    Text(title)
      .fontSize(16).fontWeight(700).fontColor('#1A1A1A')
    Blank()
  }
  .width('100%')
  .padding({ left: 16, top: topMargin, bottom: 12 })
}

@Component
export struct MyPage {
  @StorageLink('topRectHeight') topRectHeight: number = 0
  private homePageStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.homePageStack) {
      List() {
        ListItem() {
          Column() {
            TopPage()
            SectionTitle('常用服务')
            ServiceGrid(MainViewModel.getFirstGridData())
            SectionTitle('我的数据', 8)
            DataCards()
            SectionTitle('我的证件', 8)
            CredentialGrid(MainViewModel.getFourthGridData())
          }
          .width('100%')
        }
        .margin({ bottom: 20 })
      }
      .height(CommonConstants.FULL_PARENT)
      .margin({ top: this.topRectHeight })
      .scrollBar(BarState.Off)
    }
    .backgroundColor('#F5F5F5')
    .hideTitleBar(true)
  }
}
