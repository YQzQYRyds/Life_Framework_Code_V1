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

// 上传材料数据
class UploadItem {
  label: string = ''       // 材料名称
  desc: string = ''        // 材料说明
  uploaded: boolean = false // 是否已上传
}

@Builder
export function ResidencePermitApplyBuilder() {
  ResidencePermitApplyPage()
}

@Component
struct ResidencePermitApplyPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0

  @State idItems: UploadItem[] = [
    { label: '身份证正面', desc: '请上传身份证人像面照片', uploaded: false } as UploadItem,
    { label: '身份证反面', desc: '请上传身份证国徽面照片', uploaded: false } as UploadItem,
  ]
  @State residenceItems: UploadItem[] = [
    { label: '租房合同', desc: '上传有效期内的房屋租赁合同', uploaded: false } as UploadItem,
    { label: '居住登记凭证', desc: '上传派出所出具的居住登记回执', uploaded: false } as UploadItem,
  ]
  @State photoItems: UploadItem[] = [
    { label: '证件照片', desc: '上传一寸白底免冠证件照', uploaded: false } as UploadItem,
  ]

  @State isSubmitting: boolean = false

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          // 顶部标题栏
          Row() {
            Image($r('app.media.ic_public_back'))
              .width('24vp')
              .height('24vp')
              .fillColor(Color.Black)
              .margin({ left: '16vp' })
              .onClick(() => this.pathStack.pop())

            Text('居住证申请')
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

          // 身份证明
          this.sectionCard('身份证明', '请提供有效的身份证件材料', this.idItems)

          // 居住时间证明
          this.sectionCard('居住时间证明', '请提供在本市连续居住的相关证明', this.residenceItems)

          // 证件照片
          this.sectionCard('证件照片', '请提供符合要求的证件照片', this.photoItems)

          // 申请按钮
          Button(this.isSubmitting ? '提交中...' : '申请居住证')
            .fontSize(px2vp(18 * 3.5))
            .fontWeight(600)
            .fontColor(Color.White)
            .backgroundColor(this.isSubmitting ? '#A0C4FF' : '#0A59F7')
            .borderRadius(px2vp(24 * 3.5))
            .width(px2vp(300 * 3.5))
            .height(px2vp(48 * 3.5))
            .margin({ top: px2vp(36 * 3.5), bottom: px2vp(40 * 3.5) })
            .enabled(!this.isSubmitting)
            .onClick(() => {
              this.submitApplication()
            })
        }
        .width('100%')
        .padding({ left: px2vp(16 * 3.5), right: px2vp(16 * 3.5) })
      }
      .scrollBar(BarState.Off)
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .backgroundColor('#F1F3F5')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }

  @Builder
  sectionCard(title: string, subtitle: string, items: UploadItem[]) {
    Column() {
      // 区块标题
      Row() {
        Text(title)
          .fontSize(px2vp(18 * 3.5))
          .fontWeight(700)
          .fontColor('#333333')
      }
      .width('100%')
      .margin({ bottom: px2vp(4 * 3.5) })

      Text(subtitle)
        .fontSize(px2vp(13 * 3.5))
        .fontColor(Color.Gray)
        .width('100%')
        .margin({ bottom: px2vp(16 * 3.5) })

      // 材料列表
      ForEach(items, (item: UploadItem, index: number) => {
        Row() {
          Column() {
            Text(item.label)
              .fontSize(px2vp(16 * 3.5))
              .fontWeight(500)
              .fontColor('#333333')
            Text(item.desc)
              .fontSize(px2vp(12 * 3.5))
              .fontColor(Color.Gray)
              .margin({ top: px2vp(4 * 3.5) })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text(item.uploaded ? '已上传 ✓' : '点击上传')
            .fontSize(px2vp(13 * 3.5))
            .fontColor(item.uploaded ? '#07C160' : '#0A59F7')
            .fontWeight(500)
            .padding({ left: px2vp(8 * 3.5), right: px2vp(8 * 3.5), top: px2vp(4 * 3.5), bottom: px2vp(4 * 3.5) })
            .backgroundColor(item.uploaded ? '#E8F8EF' : '#EBF2FF')
            .borderRadius(px2vp(4 * 3.5))
            .onClick(() => {
              // 模拟上传
              items[index].uploaded = true
              promptAction.showToast({ message: `${item.label}上传成功` })
            })
        }
        .width('100%')
        .padding({ top: px2vp(12 * 3.5), bottom: px2vp(12 * 3.5) })
        .border({
          width: { bottom: index < items.length - 1 ? 1 : 0 },
          color: '#F0F0F0',
          style: BorderStyle.Solid
        })
      })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(px2vp(16 * 3.5))
    .padding(px2vp(20 * 3.5))
    .margin({ top: px2vp(20 * 3.5) })
  }

  submitApplication(): void {
    // 检查是否全部上传
    let allUploaded: boolean = true
    for (let i = 0; i < this.idItems.length; i++) {
      if (!this.idItems[i].uploaded) {
        allUploaded = false
        break
      }
    }
    if (allUploaded) {
      for (let i = 0; i < this.residenceItems.length; i++) {
        if (!this.residenceItems[i].uploaded) {
          allUploaded = false
          break
        }
      }
    }
    if (allUploaded) {
      for (let i = 0; i < this.photoItems.length; i++) {
        if (!this.photoItems[i].uploaded) {
          allUploaded = false
          break
        }
      }
    }

    if (!allUploaded) {
      promptAction.showToast({ message: '请先上传所有必需材料' })
      return
    }

    this.isSubmitting = true
    // 模拟提交
    setTimeout(() => {
      this.isSubmitting = false
      promptAction.showToast({ message: '居住证申请已提交，请等待审核' })
      this.pathStack.pop()
    }, 1500)
  }
}

const builderName: string = CommonConstants.ResidencePermitApply
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ResidencePermitApplyBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
