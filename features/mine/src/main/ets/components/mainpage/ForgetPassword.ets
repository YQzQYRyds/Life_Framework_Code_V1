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
import { BuilderNameConstants, RouterModule, RouterNameConstants } from 'RouterModule';
import { LoginManager } from '../../modle/LoginManager';

enum ResetStep {
  INPUT_PHONE,   // Step 1: Enter phone + verification code
  SET_PASSWORD   // Step 2: Set new password
}

@Builder
export function ForgetPwdBuilder() {
  NavDestination() {
    ForgetPassword()
  }.hideTitleBar(true)
}

@Component
struct ForgetPassword {
  @State currentStep: ResetStep = ResetStep.INPUT_PHONE;
  @State phoneInput: string = '';
  @State codeInput: string = '';
  @State currentVerifyCode: string = '';
  @State newPassword: string = '';
  @State confirmPassword: string = '';
  @State showPassword: boolean = false;
  @State showConfirmPwd: boolean = false;
  @State countdown: number = 0;
  @State verifiedPhone: string = '';
  private countdownTimer: number = -1;

  aboutToDisappear(): void {
    if (this.countdownTimer !== -1) {
      clearInterval(this.countdownTimer);
    }
  }

  build() {
    Column() {
      // Title bar
      Row() {
        Image($r('app.media.ic_public_arrow_left_filled'))
          .width(24).height(24)
          .onClick(() => {
            if (this.currentStep === ResetStep.SET_PASSWORD) {
              this.currentStep = ResetStep.INPUT_PHONE;
            } else {
              RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            }
          })
        Text('忘记密码')
          .fontSize(18)
          .fontWeight(700)
          .fontColor('#1A1A1A')
          .margin({ left: 12 })
      }
      .width('100%')
      .padding({ left: 16, top: 16, bottom: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)

      // Step indicator
      Row() {
        // Step 1
        Column() {
          Text('1')
            .fontSize(14).fontColor(Color.White).fontWeight(700)
            .width(28).height(28)
            .borderRadius(14)
            .backgroundColor('#0A59F7')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 6 })
          Text('验证身份')
            .fontSize(13)
            .fontColor(this.currentStep === ResetStep.INPUT_PHONE ? '#0A59F7' : '#999999')
        }
        .alignItems(HorizontalAlign.Center)

        Divider().width(60).color(this.currentStep === ResetStep.SET_PASSWORD ? '#0A59F7' : '#DDDDDD')

        // Step 2
        Column() {
          Text('2')
            .fontSize(14)
            .fontColor(this.currentStep === ResetStep.SET_PASSWORD ? Color.White : '#CCCCCC')
            .fontWeight(700)
            .width(28).height(28)
            .borderRadius(14)
            .backgroundColor(this.currentStep === ResetStep.SET_PASSWORD ? '#0A59F7' : '#E8E8E8')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 6 })
          Text('重置密码')
            .fontSize(13)
            .fontColor(this.currentStep === ResetStep.SET_PASSWORD ? '#0A59F7' : '#999999')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding({ top: 24, bottom: 24 })
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)

      // Step content
      if (this.currentStep === ResetStep.INPUT_PHONE) {
        this.stepVerifyPhone()
      } else {
        this.stepResetPassword()
      }
    }
    .width('100%').height('100%')
    .backgroundColor('#F5F5F5')
  }

  /**
   * Step 1: Verify phone with verification code.
   */
  @Builder
  stepVerifyPhone() {
    Column() {
      Text('请输入绑定的手机号')
        .fontSize(15).fontColor('#666666')
        .margin({ top: 32, bottom: 24 })

      // Phone input
      Row() {
        Image($r('app.media.ic_contacts_business_cards_filled'))
          .width(20).height(20).margin({ left: 14, right: 8 })
        Text('+86').fontSize(15).fontColor('#333333').margin({ right: 8 })
        Divider().vertical(true).height(20).color('#DDDDDD').margin({ right: 8 })
        TextInput({ placeholder: '请输入手机号', text: this.phoneInput })
          .fontSize(14).height(46).layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(11).type(InputType.PhoneNumber)
          .onChange((v: string) => { this.phoneInput = LoginManager.filterDigits(v); })
      }
      .width('92%').height(46)
      .backgroundColor(Color.White).borderRadius(23)
      .margin({ bottom: 14 })

      // Verification code
      Row() {
        Image($r('app.media.ic_public_security_filled'))
          .width(20).height(20).margin({ left: 14, right: 8 })
        TextInput({ placeholder: '请输入验证码', text: this.codeInput })
          .fontSize(14).height(46).layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(4).type(InputType.Number)
          .onChange((v: string) => { this.codeInput = LoginManager.filterDigits(v); })
        Button(this.countdown > 0 ? `${this.countdown}s` : '获取验证码')
          .fontSize(12).height(32)
          .backgroundColor(this.countdown > 0 ? '#CCCCCC' : '#0A59F7')
          .fontColor(Color.White)
          .enabled(this.countdown === 0 && LoginManager.isValidPhone(this.phoneInput))
          .borderRadius(16).margin({ right: 4 })
          .onClick(() => { this.sendVerifyCode(); })
      }
      .width('92%').height(46)
      .backgroundColor(Color.White).borderRadius(23)
      .margin({ bottom: 28 })

      Button('下一步')
        .fontSize(16).fontWeight(500).fontColor(Color.White)
        .width('86%').height(46).borderRadius(23)
        .backgroundColor(this.canProceed() ? '#0A59F7' : '#A0C4FF')
        .enabled(this.canProceed())
        .onClick(() => { this.verifyAndProceed(); })
    }
    .width('92%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .margin({ top: 16, left: 16, right: 16 })
    .padding({ top: 8, bottom: 32 })
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * Step 2: Set new password.
   */
  @Builder
  stepResetPassword() {
    Column() {
      Text('请设置新的登录密码')
        .fontSize(15).fontColor('#666666')
        .margin({ top: 32, bottom: 24 })

      // New password
      Row() {
        Image($r('app.media.ic_public_security_filled'))
          .width(20).height(20).margin({ left: 14, right: 8 })
        TextInput({ placeholder: '请输入新密码（6-20位）', text: this.newPassword })
          .fontSize(14).height(46).layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(20).type(InputType.Password)
          .onChange((v: string) => { this.newPassword = LoginManager.filterPassword(v); })
      }
      .width('92%').height(46)
      .backgroundColor(Color.White).borderRadius(23)
      .margin({ bottom: 14 })

      // Confirm password
      Row() {
        Image($r('app.media.ic_public_security_filled'))
          .width(20).height(20).margin({ left: 14, right: 8 })
        TextInput({ placeholder: '请再次输入新密码', text: this.confirmPassword })
          .fontSize(14).height(46).layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .maxLength(20).type(InputType.Password)
          .onChange((v: string) => { this.confirmPassword = LoginManager.filterPassword(v); })
      }
      .width('92%').height(46)
      .backgroundColor(Color.White).borderRadius(23)
      .margin({ bottom: 28 })

      Text('课程演示：不会修改任何真实账户密码')
        .fontSize(11).fontColor('#999999')
        .margin({ bottom: 16 })

      Button('重置密码')
        .fontSize(16).fontWeight(500).fontColor(Color.White)
        .width('86%').height(46).borderRadius(23)
        .backgroundColor(this.canReset() ? '#0A59F7' : '#A0C4FF')
        .enabled(this.canReset())
        .onClick(() => { this.resetPassword(); })
    }
    .width('92%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .margin({ top: 16, left: 16, right: 16 })
    .padding({ top: 8, bottom: 32 })
    .alignItems(HorizontalAlign.Center)
  }

  canProceed(): boolean {
    return LoginManager.isValidPhone(this.phoneInput) && this.codeInput.length === 4;
  }

  canReset(): boolean {
    return LoginManager.isValidPassword(this.newPassword) &&
      this.newPassword === this.confirmPassword;
  }

  sendVerifyCode(): void {
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

  verifyAndProceed(): void {
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
    // Verification success
    this.verifiedPhone = this.phoneInput;
    this.currentStep = ResetStep.SET_PASSWORD;
    this.showToast('身份验证通过');
  }

  resetPassword(): void {
    if (!LoginManager.isValidPassword(this.newPassword)) {
      this.showToast('密码长度需为6-20位');
      return;
    }
    if (this.newPassword !== this.confirmPassword) {
      this.showToast('两次输入的密码不一致');
      return;
    }
    this.showToast('本地模拟重置完成，请重新登录');
    RouterModule.popToName(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
  }
  private showToast(message: string): void {
    try {
      this.getUIContext().getPromptAction().showToast({ message: message });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, 'ForgetPassword', 'Failed to show toast: %{public}s', err.message);
    }
  }

  private showMockCodeDialog(phone: string, code: string): void {
    try {
      this.getUIContext().getPromptAction().showDialog({
        title: '模拟验证码（仅本地演示）',
        message: `未发送真实短信。\n手机号：${LoginManager.maskPhone(phone)}\n本次验证码：${code}`,
        buttons: [{ text: '知道了', color: '#0A59F7' }]
      }).catch((error: BusinessError) => {
        hilog.error(0x0000, 'ForgetPassword', 'Failed to show code dialog: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, 'ForgetPassword', 'Failed to open code dialog: %{public}s', err.message);
    }
  }

}


const builderName = BuilderNameConstants.ForgetPassPage;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ForgetPwdBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

