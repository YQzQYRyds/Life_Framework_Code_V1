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

// Login mode enum
enum LoginMode {
  PASSWORD,   // Password login
  SMS         // SMS verification code login
}

@Builder
export function loginBuilder() {
  NavDestination() {
    LoginPage()
  }.hideTitleBar(true)
}

@Component
struct LoginPage {
  // UI state
  @State loginMode: LoginMode = LoginMode.PASSWORD;
  @State accountInput: string = '';
  @State passwordInput: string = '';
  @State smsCodeInput: string = '';
  @State currentVerifyCode: string = '';
  @State isAgree: boolean = false;
  @State showPassword: boolean = false;
  @State isLoading: boolean = false;

  // SMS countdown
  @State countdown: number = 0;
  private countdownTimer: number = -1;

  aboutToDisappear(): void {
    if (this.countdownTimer !== -1) {
      clearInterval(this.countdownTimer);
    }
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')

      // Main content card
      Column() {
        // Close button
        Row() {
          Image($r('app.media.ic_public_arrow_left_filled'))
            .width(24)
            .height(24)
            .onClick(() => {
              RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            })
        }
        .width('100%')
        .padding({ left: 16, top: 16 })
        .alignItems(VerticalAlign.Center)

        // Avatar and title
        Image($r('app.media.ic_avatar_outline'))
          .width(56)
          .height(56)
          .margin({ top: 12 })

        Text('欢迎登录便捷生活')
          .fontSize(22)
          .fontWeight(700)
          .fontColor('#1A1A1A')
          .margin({ top: 12, bottom: 32 })

        // Login mode tabs
        Row() {
          Text('密码登录')
            .fontSize(16)
            .fontWeight(this.loginMode === LoginMode.PASSWORD ? 700 : 400)
            .fontColor(this.loginMode === LoginMode.PASSWORD ? '#0A59F7' : '#999999')
            .padding({ bottom: 8 })
            .border({ width: { bottom: this.loginMode === LoginMode.PASSWORD ? 2 : 0 },
              color: '#0A59F7' })
            .onClick(() => { this.loginMode = LoginMode.PASSWORD; })
            .margin({ right: 32 })

          Text('短信验证码登录')
            .fontSize(16)
            .fontWeight(this.loginMode === LoginMode.SMS ? 700 : 400)
            .fontColor(this.loginMode === LoginMode.SMS ? '#0A59F7' : '#999999')
            .padding({ bottom: 8 })
            .border({ width: { bottom: this.loginMode === LoginMode.SMS ? 2 : 0 },
              color: '#0A59F7' })
            .onClick(() => { this.loginMode = LoginMode.SMS; })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 24 })

        // Password login form
        if (this.loginMode === LoginMode.PASSWORD) {
          this.passwordLoginForm()
        }

        // SMS login form
        if (this.loginMode === LoginMode.SMS) {
          this.smsLoginForm()
        }

        // Agreement checkbox
        Row() {
          Toggle({ type: ToggleType.Checkbox, isOn: this.isAgree })
            .width(16)
            .height(16)
            .selectedColor('#0A59F7')
            .onChange((value: boolean) => {
              this.isAgree = value;
            })

          Text('已阅读并同意')
            .fontSize(12)
            .fontColor('#666666')
            .margin({ left: 6 })
          Text('《用户服务协议》')
            .fontSize(12)
            .fontColor('#0A59F7')
          Text('和')
            .fontSize(12)
            .fontColor('#666666')
          Text('《隐私政策》')
            .fontSize(12)
            .fontColor('#0A59F7')
        }
        .width('100%')
        .padding({ left: 24 })
        .margin({ top: 16 })

        Text('课程演示：本页面使用本地模拟登录，不连接真实账户服务')
          .fontSize(11)
          .fontColor('#999999')
          .width('86%')
          .margin({ top: 14 })

        // Login button
        Button(this.loginMode === LoginMode.PASSWORD ? '登录' : '登录/注册')
          .fontSize(16)
          .fontWeight(500)
          .fontColor(Color.White)
          .width('86%')
          .height(46)
          .borderRadius(23)
          .backgroundColor(this.canLogin() ? '#0A59F7' : '#A0C4FF')
          .margin({ top: 20 })
          .enabled(this.canLogin())
          .onClick(() => {
            this.handleLogin();
          })

        // Bottom links (password mode only)
        if (this.loginMode === LoginMode.PASSWORD) {
          Row() {
            Text('注册账号')
              .fontSize(14)
              .fontColor('#0A59F7')
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.RegisterPage)
              })
              .margin({ right: 36 })

            Text('忘记密码')
              .fontSize(14)
              .fontColor('#0A59F7')
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.ForgetPassPage)
              })
          }
          .margin({ top: 18 })
        }

        Blank()
      }
      .width('100%')
      .height('94%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .position({ x: 0, y: '6%' })

      // Loading overlay
      if (this.isLoading) {
        Column() {
          LoadingProgress()
            .color('#0A59F7')
            .width(48)
            .height(48)
          Text('登录中...')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 12 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(255,255,255,0.9)')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }

  /**
   * Password login form.
   */
  @Builder
  passwordLoginForm() {
    Column() {
      // Account input
      Row() {
        Image($r('app.media.ic_contacts_business_cards_filled'))
          .width(20).height(20)
          .margin({ left: 12, right: 8 })
        TextInput({ placeholder: '请输入手机号/账号', text: this.accountInput })
          .fontSize(15)
          .height(48)
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(11)
          .type(InputType.PhoneNumber)
          .onChange((value: string) => { this.accountInput = LoginManager.filterDigits(value); })
      }
      .width('86%')
      .height(48)
      .backgroundColor('#F8F8F8')
      .borderRadius(24)
      .margin({ bottom: 12 })

      // Password input
      Row() {
        Image($r('app.media.ic_public_security_filled'))
          .width(20).height(20)
          .margin({ left: 12, right: 8 })
        TextInput({ placeholder: '请输入密码', text: this.passwordInput })
          .fontSize(15)
          .height(48)
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(20)
          .type(InputType.Password)
          .onChange((value: string) => { this.passwordInput = LoginManager.filterPassword(value); })
      }
      .width('86%')
      .height(48)
      .backgroundColor('#F8F8F8')
      .borderRadius(24)
    }
  }

  /**
   * SMS verification code login form.
   */
  @Builder
  smsLoginForm() {
    Column() {
      // Phone number input
      Row() {
        Image($r('app.media.ic_contacts_business_cards_filled'))
          .width(20).height(20)
          .margin({ left: 12, right: 8 })
        Text('+86')
          .fontSize(15)
          .fontColor('#333333')
          .margin({ right: 8 })
        Divider().vertical(true).height(20).color('#DDDDDD').margin({ right: 8 })
        TextInput({ placeholder: '请输入手机号', text: this.accountInput })
          .fontSize(15)
          .height(48)
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(11)
          .type(InputType.PhoneNumber)
          .onChange((value: string) => { this.accountInput = LoginManager.filterDigits(value); })
      }
      .width('86%')
      .height(48)
      .backgroundColor('#F8F8F8')
      .borderRadius(24)
      .margin({ bottom: 12 })

      // Verification code input
      Row() {
        Image($r('app.media.ic_public_security_filled'))
          .width(20).height(20)
          .margin({ left: 12, right: 8 })
        TextInput({ placeholder: '请输入4位验证码', text: this.smsCodeInput })
          .fontSize(15)
          .height(48)
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(4)
          .type(InputType.Number)
          .onChange((value: string) => { this.smsCodeInput = LoginManager.filterDigits(value); })
        Button(this.countdown > 0 ? `${this.countdown}s` : '获取验证码')
          .fontSize(12)
          .height(32)
          .backgroundColor(this.countdown > 0 ? '#CCCCCC' : '#0A59F7')
          .enabled(this.countdown === 0 && LoginManager.isValidPhone(this.accountInput))
          .borderRadius(16)
          .margin({ right: 4 })
          .onClick(() => { this.sendVerifyCode(); })
      }
      .width('86%')
      .height(48)
      .backgroundColor('#F8F8F8')
      .borderRadius(24)
    }
  }

  /**
   * Check if login button should be enabled.
   */
  canLogin(): boolean {
    if (!this.isAgree) return false;
    if (this.loginMode === LoginMode.PASSWORD) {
      return this.accountInput.length > 0 && this.passwordInput.length > 0;
    } else {
      return LoginManager.isValidPhone(this.accountInput) && this.smsCodeInput.length === 4;
    }
  }

  /**
   * Send verification code and start countdown.
   */
  sendVerifyCode(): void {
    if (!LoginManager.isValidPhone(this.accountInput)) {
      this.showToast('请输入正确的手机号');
      return;
    }
    // Generate 4-digit code and show dialog after 1 second
    let code = LoginManager.generateVerifyCode();
    this.currentVerifyCode = code;
    let phone = this.accountInput;
    this.countdown = 60;
    this.countdownTimer = setInterval(() => {
      this.countdown--;
      if (this.countdown <= 0) {
        clearInterval(this.countdownTimer);
        this.countdownTimer = -1;
      }
    }, 1000);
    // Show dialog after 1 second delay
    this.showMockCodeDialog(phone, code);
  }

  /**
   * Handle login action.
   */
  async handleLogin(): Promise<void> {
    if (!this.isAgree) {
      this.showToast('请先同意用户服务协议');
      return;
    }
    this.isLoading = true;

    try {
      if (this.loginMode === LoginMode.PASSWORD) {
        // Password login
        if (!LoginManager.isValidPhone(this.accountInput)) {
          this.showToast('请输入正确的11位手机号');
          this.isLoading = false;
          return;
        }
        if (!LoginManager.isValidPassword(this.passwordInput)) {
          this.showToast('密码长度需为6-20位');
          this.isLoading = false;
          return;
        }
        let success = await LoginManager.login(this.accountInput, this.passwordInput);
        if (success) {
          this.showToast('登录成功！');
          AppStorage.setOrCreate(AppStorageKeys.SWITCH_TO_MINE_TAB, true);
          RouterModule.clear(RouterNameConstants.ENTRY_HAP);
        }
      } else {
        // SMS login
        if (!LoginManager.isValidPhone(this.accountInput)) {
          this.showToast('请输入正确的手机号');
          this.isLoading = false;
          return;
        }
        if (this.smsCodeInput.length !== 4) {
          this.showToast('请输入4位验证码');
          this.isLoading = false;
          return;
        }
        if (this.smsCodeInput !== this.currentVerifyCode) {
          this.showToast('验证码错误，请重新输入');
          this.isLoading = false;
          return;
        }
        let success = await LoginManager.login(this.accountInput, LoginManager.SMS_LOGIN_MARKER);
        if (success) {
          this.showToast('登录成功！');
          AppStorage.setOrCreate(AppStorageKeys.SWITCH_TO_MINE_TAB, true);
          RouterModule.clear(RouterNameConstants.ENTRY_HAP);
        }
      }
    } catch (err) {
      this.showToast('登录失败，请重试');
    }
    this.isLoading = false;
  }
  private showToast(message: string): void {
    try {
      this.getUIContext().getPromptAction().showToast({ message: message });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, 'LoginPage', 'Failed to show toast: %{public}s', err.message);
    }
  }

  private showMockCodeDialog(phone: string, code: string): void {
    try {
      this.getUIContext().getPromptAction().showDialog({
        title: '模拟验证码（仅本地演示）',
        message: `未发送真实短信。\n手机号：${LoginManager.maskPhone(phone)}\n本次验证码：${code}`,
        buttons: [{ text: '知道了', color: '#0A59F7' }]
      }).catch((error: BusinessError) => {
        hilog.error(0x0000, 'LoginPage', 'Failed to show code dialog: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, 'LoginPage', 'Failed to open code dialog: %{public}s', err.message);
    }
  }

}


const builderName: string = BuilderNameConstants.LoginPage;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(loginBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

