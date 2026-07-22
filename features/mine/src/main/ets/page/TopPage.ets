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

import { LoginInfo, LoginManager } from '../modle/LoginManager';
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'RouterModule';

@Component
export struct TopPage {
  @StorageLink('login') @Watch('onLoginChanged') loginInfo: LoginInfo = LoginManager.createLoggedOutInfo();
  @State userName: string = '未登录';
  @State authStatus: string = '点击登录';
  @State isLoggedIn: boolean = false;

  aboutToAppear(): void {
    this.refreshUserInfo();
  }

  onLoginChanged(): void {
    this.refreshUserInfo();
  }

  refreshUserInfo(): void {
    const info: LoginInfo = this.loginInfo;
    if (info && info.isLogin) {
      this.isLoggedIn = true;
      this.userName = info.userName || '用户';
      this.authStatus = '已登录（本地模拟）';
    } else {
      this.isLoggedIn = false;
      this.userName = '未登录';
      this.authStatus = '点击登录';
    }
  }

  build() {
    Column() {
      // Row 1: avatar + user info (left) and icons (right)
      Row() {
        // Left: avatar + name + auth badge
        Row({ space: 12 }) {
          Image($rawfile('avatar.PNG'))
            .width(56).height(56).borderRadius(28)
          Column({ space: 6 }) {
            Text(this.userName)
              .fontSize(18).fontColor(Color.White).fontWeight(FontWeight.Bold)
            Row({ space: 6 }) {
              Image($rawfile('bg2.png')).width(16).height(16)
              Text(this.authStatus)
                .fontSize(12).fontColor(Color.White).opacity(0.85)
            }
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 4 })
        }

        Blank()

        // Right: message + settings icons
        Row({ space: 16 }) {
          Image($rawfile('ic_public_message_point_border.PNG'))
            .width(22).height(22)
          Image($rawfile('ic_public_setting_border.PNG'))
            .width(22).height(22)
            .onClick(() => {
              if (!this.isLoggedIn) {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
              } else {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SecurityCenterPage);
              }
            })
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12 })

      // Row 2: operation cards
      Row() {
        Column() {
          Image($rawfile('bg3.png')).width(36).height(36)
          Text('我的账号').fontSize(13).fontColor('#333').margin({ top: 6 })
        }.onClick(() => {
          if (!this.isLoggedIn) {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
          } else {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SecurityCenterPage);
          }
        })

        Divider().vertical(true).height(36).color('#E0E0E0').margin({ left: 8, right: 8 })

        Column() {
          Image($rawfile('bg4.png')).width(36).height(36)
          Text('安全中心').fontSize(13).fontColor('#333').margin({ top: 6 })
        }.onClick(() => {
          if (!this.isLoggedIn) {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
          } else {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SecurityCenterPage);
          }
        })
      }
      .backgroundColor(Color.White)
      .width('88%').height(80)
      .borderRadius(12)
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 24 })
    }
    .width('100%')
    .padding({ top: 20, bottom: 24 })
    .backgroundImage($rawfile('bg.jpg'))
    .backgroundImageSize({ width: '100%', height: '100%' })
  }
}
