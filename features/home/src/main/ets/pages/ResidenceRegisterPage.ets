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

import { RouterModule } from 'RouterModule'
import CommonConstants from 'common/constants/CommonConstants'
import { promptAction } from '@kit.ArkUI'

@Builder
export function ResidenceRegisterBuilder() {
  ResidenceRegisterPage()
}

@Component
struct ResidenceRegisterPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  @State address: string = ''
  @State phone: string = ''
  @State idCard: string = ''

  build() {
    NavDestination() {
      Column() {
        // 顶部标题栏
        Row() {
          Image($r('app.media.ic_public_back'))
            .width('24vp')
            .height('24vp')
            .fillColor(Color.Black)
            .margin({ left: '16vp' })
            .onClick(() => this.pathStack.pop())

          Text('居住登记')
            .fontSize('20vp')
            .fontWeight(700)
            .fontColor('#333333')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .margin({ right: '40vp' })
        }
        .width('100%')
        .height('56vp')
        .backgroundColor(Color.White)

        // 表单区域
        Column() {
          // 居住地址
          this.inputItem('居住地址', '请输入详细居住地址', this.address, InputType.Normal, (v: string) => { this.address = v })

          Divider().color('#F0F0F0').width('100%')

          // 电话号码
          this.inputItem('电话号码', '请输入联系电话', this.phone, InputType.PhoneNumber, (v: string) => { this.phone = v })

          Divider().color('#F0F0F0').width('100%')

          // 身份证号
          this.inputItem('身份证号', '请输入18位身份证号码', this.idCard, InputType.Normal, (v: string) => { this.idCard = v })
        }
        .width('100%')
        .backgroundColor(Color.White)
        .borderRadius(px2vp(16 * 3.5))
        .padding({ left: px2vp(20 * 3.5), right: px2vp(20 * 3.5), top: px2vp(8 * 3.5), bottom: px2vp(8 * 3.5) })
        .margin({ top: px2vp(24 * 3.5), left: px2vp(16 * 3.5), right: px2vp(16 * 3.5) })

        // 登记按钮
        Button('提交登记')
          .fontSize(px2vp(18 * 3.5))
          .fontWeight(600)
          .fontColor(Color.White)
          .backgroundColor('#0A59F7')
          .borderRadius(px2vp(24 * 3.5))
          .width(px2vp(300 * 3.5))
          .height(px2vp(48 * 3.5))
          .margin({ top: px2vp(48 * 3.5) })
          .onClick(() => {
            if (!this.address.trim()) {
              promptAction.showToast({ message: '请输入居住地址' })
              return
            }
            if (!this.phone.trim()) {
              promptAction.showToast({ message: '请输入电话号码' })
              return
            }
            if (!this.idCard.trim()) {
              promptAction.showToast({ message: '请输入身份证号' })
              return
            }
            if (this.idCard.trim().length !== 18) {
              promptAction.showToast({ message: '请输入正确的18位身份证号' })
              return
            }
            promptAction.showToast({ message: '居住登记提交成功' })
            this.pathStack.pop()
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }

  @Builder
  inputItem(label: string, placeholder: string, value: string, inputType: InputType, onChange: (v: string) => void) {
    Row() {
      Text(label)
        .fontSize(px2vp(16 * 3.5))
        .fontWeight(500)
        .fontColor('#333333')
        .width(px2vp(80 * 3.5))

      TextInput({ placeholder: placeholder, text: value })
        .fontSize(px2vp(15 * 3.5))
        .type(inputType)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .padding(0)
        .onChange(onChange)
    }
    .width('100%')
    .height(px2vp(56 * 3.5))
    .alignItems(VerticalAlign.Center)
  }
}

const builderName: string = CommonConstants.ResidenceRegister
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ResidenceRegisterBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
