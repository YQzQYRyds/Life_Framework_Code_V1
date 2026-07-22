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
import { LoginManager } from '../../modle/LoginManager';
import { AppStorageKeys } from 'common';

interface RegisterForm {
  phone: string;
  code: string;
  password: string;
  confirmPassword: string;
  agreeTerms: boolean;
}

@Builder
export function RegisteringBuilder() {
  NavDestination() {
    RegisteringPage()
  }.hideTitleBar(true)
}

@Component
struct RegisteringPage {
  @State phoneInput: string = '';
  @State codeInput: string = '';
  @State currentVerifyCode: string = '';
  @State passwordInput: string = '';
  @State confirmPwdInput: string = '';
  @State agreeTerms: boolean = false;
  @State showPassword: boolean = false;
  @State showConfirmPwd: boolean = false;
  @State countdown: number = 0;
  @State isLoading: boolean = false;
  private countdownTimer: number = -1;

  aboutToDisappear(): void {
    if (this.countdownTimer !== -1) {
      clearInterval(this.countdownTimer);
    }
  }

  build() {
    Stack() {
      Column().width('100%').height('100%').backgroundColor('#F5F5F5')

      Column() {
        // Title bar
        Row() {
          Image($r('app.media.ic_public_arrow_left_filled'))
            .width(24).height(24)
            .onClick(() => {
              RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            })
          Text('注册账号')
            .fontSize(18)
            .fontWeight(700)
            .fontColor('#1A1A1A')
            .margin({ left: 12 })
        }
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 12 })
        .alignItems(VerticalAlign.Center)

        // Form area
        Scroll() {
          Column() {
            // Phone number
            this.inputField('手机号', '请输入手机号', $r('app.media.ic_contacts_business_cards_filled'),
              this.phoneInput, InputType.PhoneNumber, 11, (v: string) => { this.phoneInput = LoginManager.filterDigits(v); })

            // Verification code
            Row() {
              Image($r('app.media.ic_public_security_filled'))
                .width(20).height(20).margin({ left: 14, right: 8 })
              TextInput({ placeholder: '请输入验证码', text: this.codeInput })
                .fontSize(14).height(46).layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .maxLength(4).type(InputType.Number)
                .onChange((v: string) => { this.codeInput = LoginManager.filterDigits(v); })
              Button(this.countdown > 0 ? `${this.countdown}s后重发` : '发送验证码')
                .fontSize(12).height(32)
                .backgroundColor(this.countdown > 0 ? '#CCCCCC' : '#0A59F7')
                .fontColor(Color.White)
                .enabled(this.countdown === 0 && LoginManager.isValidPhone(this.phoneInput))
                .borderRadius(16).margin({ right: 4 })
                .onClick(() => { this.sendCode(); })
            }
            .width('92%').height(46)
            .backgroundColor('#F8F8F8').borderRadius(23)
            .margin({ bottom: 14 })

            // Password
            Row() {
              Image($r('app.media.ic_public_security_filled'))
                .width(20).height(20).margin({ left: 14, right: 8 })
              TextInput({ placeholder: '请设置密码（6-20位）', text: this.passwordInput })
                .fontSize(14).height(46).layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .maxLength(20).type(InputType.Password)
                .onChange((v: string) => { this.passwordInput = LoginManager.filterPassword(v); })
            }
            .width('92%').height(46)
            .backgroundColor('#F8F8F8').borderRadius(23)
            .margin({ bottom: 14 })

            // Confirm password
            Row() {
              Image($r('app.media.ic_public_security_filled'))
                .width(20).height(20).margin({ left: 14, right: 8 })
              TextInput({ placeholder: '请再次输入密码', text: this.confirmPwdInput })
                .fontSize(14).height(46).layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .maxLength(20).type(InputType.Password)
                .onChange((v: string) => { this.confirmPwdInput = LoginManager.filterPassword(v); })
            }
            .width('92%').height(46)
            .backgroundColor('#F8F8F8').borderRadius(23)
            .margin({ bottom: 14 })

            // Agreement
            Row() {
              Toggle({ type: ToggleType.Checkbox, isOn: this.agreeTerms })
                .width(16).height(16).selectedColor('#0A59F7')
                .onChange((v: boolean) => { this.agreeTerms = v; })
              Text('已阅读并同意')
                .fontSize(12).fontColor('#666666').margin({ left: 6 })
              Text('《用户服务协议》')
                .fontSize(12).fontColor('#0A59F7')
              Text('和')
                .fontSize(12).fontColor('#666666')
              Text('《隐私政策》')
                .fontSize(12).fontColor('#0A59F7')
            }
            .width('92%').margin({ top: 8 })

            Text('课程演示：注册信息仅用于创建本地模拟会话')
              .fontSize(11).fontColor('#999999').width('86%')
              .margin({ top: 16 })

            // Register button
            Button('注册')
              .fontSize(16).fontWeight(500).fontColor(Color.White)
              .width('86%').height(46).borderRadius(23)
              .backgroundColor(this.canRegister() ? '#0A59F7' : '#A0C4FF')
              .margin({ top: 28 })
              .enabled(this.canRegister())
              .onClick(() => { this.handleRegister(); })

            // Back to login
            Row() {
              Text('已有账号？')
                .fontSize(13).fontColor('#999999')
              Text('去登录')
                .fontSize(13).fontColor('#0A59F7').fontWeight(500)
                .onClick(() => {
                  RouterModule.pop(RouterNameConstants.ENTRY_HAP);
                })
            }
            .margin({ top: 16, bottom: 32 })
          }
          .width('100%').alignItems(HorizontalAlign.Center)
          .margin({ top: 16 })
        }
        .layoutWeight(1)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 20, topRight: 20 })
      }
    }
    .width('100%').height('100%')
  }

  @Builder
  inputField(label: string, placeholder: string, icon: Resource, value: string,
    inputType: InputType, maxLen: number, onChange: (v: string) => void) {
    Row() {
      Image(icon)
        .width(20).height(20).margin({ left: 14, right: 8 })
      TextInput({ placeholder: placeholder, text: value })
        .fontSize(14).height(46).layoutWeight(1)
        .backgroundColor(Color.Transparent)
        .maxLength(maxLen).type(inputType)
        .onChange(onChange)
    }
    .width('92%').height(46)
    .backgroundColor('#F8F8F8').borderRadius(23)
    .margin({ bottom: 14 })
  }

  canRegister(): boolean {
    return this.agreeTerms &&
      LoginManager.isValidPhone(this.phoneInput) &&
      this.codeInput.length === 4 &&
      LoginManager.isValidPassword(this.passwordInput) &&
      this.passwordInput === this.confirmPwdInput;
  }

  sendCode(): void {
    if (!LoginManager.isValidPhone(this.phoneInput)) {
      this.showToast('请输入正确的手机号');
      return;
    }
    let code = LoginManager.generateVerifyCode();
    this.currentVerifyCode = code;
    let phone = this.phoneInput;
    this.countdown = 60;
    this.countdownTimer = setInterval(() => {
      this.countdown--;
      if (this.countdown <= 0) {
        clearInterval(this.countdownTimer);
        this.countdownTimer = -1;
      }
    }, 1000);
    this.showMockCodeDialog(phone, code);
  }

  async handleRegister(): Promise<void> {
    if (!this.agreeTerms) {
      this.showToast('请先同意用户服务协议');
      return;
    }
    if (!LoginManager.isValidPhone(this.phoneInput)) {
      this.showToast('请输入正确的手机号');
      return;
    }
    if (this.codeInput.length !== 4) {
      this.showToast('请输入4位验证码');
      return;
    }
    if (this.codeInput !== this.currentVerifyCode) {
      this.showToast('验证码错误，请重新输入');
      return;
    }
    if (!LoginManager.isValidPassword(this.passwordInput)) {
      this.showToast('密码长度需为6-20位');
      return;
    }
    if (this.passwordInput !== this.confirmPwdInput) {
      this.showToast('两次输入的密码不一致');
      return;
    }
    // Simulate registration: same as login but with registration message
    try {
      let success = await LoginManager.login(this.phoneInput, this.passwordInput);
      if (success) {
        this.showToast('注册成功！已自动登录');
        AppStorage.setOrCreate(AppStorageKeys.SWITCH_TO_MINE_TAB, true);
        RouterModule.clear(RouterNameConstants.ENTRY_HAP);
      }
    } catch (err) {
      this.showToast('注册失败，请重试');
    }
  }
  private showToast(message: string): void {
    try {
      this.getUIContext().getPromptAction().showToast({ message: message });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, 'RegisterPage', 'Failed to show toast: %{public}s', err.message);
    }
  }

  private showMockCodeDialog(phone: string, code: string): void {
    try {
      this.getUIContext().getPromptAction().showDialog({
        title: '模拟验证码（仅本地演示）',
        message: `未发送真实短信。\n手机号：${LoginManager.maskPhone(phone)}\n本次验证码：${code}`,
        buttons: [{ text: '知道了', color: '#0A59F7' }]
      }).catch((error: BusinessError) => {
        hilog.error(0x0000, 'RegisterPage', 'Failed to show code dialog: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, 'RegisterPage', 'Failed to open code dialog: %{public}s', err.message);
    }
  }

}


const builderName = BuilderNameConstants.RegisterPage;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(RegisteringBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

