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

import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'RouterModule';
import { LoginInfo, LoginManager, LoginMethod } from '../../modle/LoginManager';

const TAG: string = 'SecurityCenter';

@Builder
export function SecurityCenterBuilder() {
  NavDestination() {
    SecurityCenter()
  }.hideTitleBar(true)
}

@Component
struct SecurityCenter {
  build() {
    Column() {
      this.titleBar()

      List() {
        ListItem() {
          this.sectionHeader('账户信息')
        }

        ListItem() {
          this.optionItem($r('app.media.ic_contacts_business_cards_filled'), '当前登录账号',
            this.getMaskedPhone(), () => {
              this.showSessionDialog();
            })
        }

        ListItem() {
          this.optionItem($r('app.media.ic_public_security_filled'), '重置登录密码',
            '进入本地模拟身份验证流程', () => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.ForgetPassPage);
            })
        }

        ListItem() {
          this.optionItem($r('app.media.ic_public_security'), '实名认证',
            '未接入真实实名认证服务', () => {
              this.showToast('课程演示项目未接入实名认证服务');
            })
        }

        ListItem() {
          this.sectionHeader('本地会话')
        }

        ListItem() {
          this.optionItem($r('app.media.ic_public_settings'), '登录方式',
            this.getLoginMethodText(), () => {
              this.showSessionDialog();
            })
        }

        ListItem() {
          this.optionItem($r('app.media.ic_public_todo'), '登录时间',
            this.getLoginTimeText(), () => {
              this.showSessionDialog();
            })
        }

        ListItem() {
          Text('本页面仅展示本机 Preferences 保存的脱敏模拟会话，不保存密码、验证码、Token 或完整手机号。')
            .fontSize(12)
            .fontColor('#777777')
            .padding({ left: 20, right: 20, top: 16, bottom: 8 })
            .width('100%')
        }

        ListItem() {
          this.sectionHeader('账户操作')
        }

        ListItem() {
          Button('退出登录')
            .fontSize(15)
            .fontWeight(500)
            .fontColor('#FA2A2D')
            .width('90%')
            .height(44)
            .backgroundColor('#FFF0F0')
            .borderRadius(22)
            .margin({ top: 16, bottom: 24 })
            .border({ width: 1, color: '#FCCCCC' })
            .onClick(() => {
              this.confirmLogout();
            })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  titleBar() {
    RelativeContainer() {
      Image($r('app.media.ic_public_arrow_left_filled'))
        .width(24)
        .height(24)
        .alignRules({
          left: { anchor: '__container__', align: HorizontalAlign.Start },
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
        .margin({ left: 16 })
        .onClick(() => {
          RouterModule.pop(RouterNameConstants.ENTRY_HAP);
        })
      Text('账户与安全')
        .fontSize(18)
        .fontWeight(700)
        .fontColor('#1A1A1A')
        .alignRules({
          middle: { anchor: '__container__', align: HorizontalAlign.Center },
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
    }
    .width('100%')
    .height(52)
    .backgroundColor(Color.White)
  }

  @Builder
  sectionHeader(title: string) {
    Text(title)
      .fontSize(13)
      .fontColor('#999999')
      .fontWeight(500)
      .padding({ left: 20, top: 20, bottom: 8 })
      .width('100%')
  }

  @Builder
  optionItem(icon: Resource, title: string, desc: string, action: () => void) {
    Row() {
      Image(icon)
        .width(22)
        .height(22)
        .margin({ left: 20, right: 12 })
      Column() {
        Text(title)
          .fontSize(15)
          .fontColor('#1A1A1A')
          .fontWeight(500)
        Text(desc)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 2 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.ic_public_arrow_right_filled'))
        .width(16)
        .height(16)
        .margin({ right: 20 })
        .fillColor('#CCCCCC')
    }
    .width('100%')
    .height(68)
    .backgroundColor(Color.White)
    .margin({ bottom: 1 })
    .onClick(() => {
      action();
    })
  }

  private getMaskedPhone(): string {
    const info: LoginInfo = LoginManager.getLoginInfo();
    return info.maskedPhone.length > 0 ? info.maskedPhone : '未登录';
  }

  private getLoginMethodText(): string {
    const info: LoginInfo = LoginManager.getLoginInfo();
    return info.loginMethod === LoginMethod.SMS ? '本地模拟验证码登录' : '本地模拟密码登录';
  }

  private getLoginTimeText(): string {
    const info: LoginInfo = LoginManager.getLoginInfo();
    if (info.loginTime <= 0) {
      return '暂无登录记录';
    }
    return new Date(info.loginTime).toLocaleString();
  }

  private showSessionDialog(): void {
    const message: string = '账号：' + this.getMaskedPhone() + '\n方式：' +
      this.getLoginMethodText() + '\n时间：' + this.getLoginTimeText();
    try {
      this.getUIContext().getPromptAction().showDialog({
        title: '本地模拟会话',
        message: message,
        buttons: [{ text: '知道了', color: '#0A59F7' }]
      }).catch((error: BusinessError) => {
        hilog.error(0x0000, TAG, 'Failed to show session dialog: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to open session dialog: %{public}s', err.message);
    }
  }

  private confirmLogout(): void {
    try {
      this.getUIContext().getPromptAction().showDialog({
        title: '退出登录',
        message: '确定清除本机保存的模拟登录状态吗？',
        buttons: [
          { text: '确定退出', color: '#FA2A2D' },
          { text: '取消', color: '#666666' }
        ]
      }).then((result) => {
        if (result.index === 0) {
          LoginManager.logout();
          RouterModule.clear(RouterNameConstants.ENTRY_HAP);
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
          this.showToast('已退出本地模拟登录');
        }
      }).catch((error: BusinessError) => {
        hilog.error(0x0000, TAG, 'Failed to show logout dialog: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to open logout dialog: %{public}s', err.message);
    }
  }

  private showToast(message: string): void {
    try {
      this.getUIContext().getPromptAction().showToast({ message: message });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to show toast: %{public}s', err.message);
    }
  }
}

const builderName: string = BuilderNameConstants.SecurityCenterPage;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SecurityCenterBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
