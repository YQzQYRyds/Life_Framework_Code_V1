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
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'RouterModule'

/**
 * 服务详情步骤数据
 */
class ServiceStep {
  step: string
  title: string
  desc: string

  constructor(step: string, title: string, desc: string) {
    this.step = step
    this.title = title
    this.desc = desc
  }
}

/**
 * 必需材料
 */
class RequiredMaterial {
  name: string
  required: boolean

  constructor(name: string, required: boolean) {
    this.name = name
    this.required = required
  }
}

/**
 * 获取办理步骤
 */
function getServiceSteps(): ServiceStep[] {
  return [
    new ServiceStep('01', '准备材料', '根据服务要求准备相关证明材料'),
    new ServiceStep('02', '在线申请', '填写申请表单并上传材料照片'),
    new ServiceStep('03', '审核受理', '工作人员审核材料，1-3个工作日反馈'),
    new ServiceStep('04', '办理完成', '审核通过后完成办理，可在线查看结果'),
  ]
}

/**
 * 获取所需材料
 */
function getMaterials(): RequiredMaterial[] {
  return [
    new RequiredMaterial('本人身份证原件', true),
    new RequiredMaterial('户口簿或居住证', true),
    new RequiredMaterial('相关申请表格', true),
    new RequiredMaterial('证明材料（视具体业务）', false),
    new RequiredMaterial('近期免冠照片', false),
  ]
}

@Builder
export function ServiceDetailBuilder(param: object) {
  ServiceDetailPage()
}

@Builder
function DetailHeader(title: string, desc: string) {
  Column() {
    Text(title)
      .fontSize(px2vp(22 * 3.5))
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Black)
      .margin({ top: px2vp(16 * 3.5) })
    Text(desc)
      .fontSize(px2vp(14 * 3.5))
      .fontColor(Color.Black)
      .opacity(0.8)
      .margin({ top: px2vp(8 * 3.5) })
  }
  .width(CommonConstants.FULL_PARENT)
  .height(px2vp(100 * 3.5))
  .justifyContent(FlexAlign.Center)
}

@Builder
function InfoCard(title: string, content: string) {
  Column() {
    Row() {
      Text(title)
        .fontSize(px2vp(14 * 3.5))
        .fontColor('#666666')
    }
    .width(CommonConstants.FULL_PARENT)

    Text(content)
      .fontSize(px2vp(15 * 3.5))
      .fontColor('#333333')
      .fontWeight(500)
      .margin({ top: px2vp(6 * 3.5) })
  }
  .width(px2vp(152 * 3.5))
  .padding(px2vp(12 * 3.5))
  .backgroundColor('#F8F8F8')
  .borderRadius(px2vp(8 * 3.5))
}

@Builder
function SectionTitle(text: string) {
  Row() {
    Text(text)
      .fontSize(px2vp(18 * 3.5))
      .fontWeight(FontWeight.Bold)
      .fontColor('#333333')
  }
  .width(CommonConstants.FULL_PARENT)
  .margin({ left: px2vp(16 * 3.5), top: px2vp(16 * 3.5), bottom: px2vp(8 * 3.5) })
}

@Builder
function StepItem(step: ServiceStep, isLast: boolean) {
  Row() {
    Column() {
      Text(step.step)
        .fontSize(px2vp(14 * 3.5))
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .width(px2vp(28 * 3.5))
        .height(px2vp(28 * 3.5))
        .backgroundColor('#FF6B35')
        .borderRadius(px2vp(14 * 3.5))
        .textAlign(TextAlign.Center)
        .shadow({ radius: px2vp(4 * 3.5), color: '#FF6B3520' })
      if (!isLast) {
        Divider()
          .vertical(true)
          .height(px2vp(24 * 3.5))
          .color('#FF6B35')
          .strokeWidth(1)
          .margin({ top: px2vp(2 * 3.5), bottom: px2vp(2 * 3.5) })
      }
    }
    .alignItems(HorizontalAlign.Center)

    Column() {
      Text(step.title)
        .fontSize(px2vp(16 * 3.5))
        .fontWeight(500)
        .fontColor('#333333')
      Text(step.desc)
        .fontSize(px2vp(12 * 3.5))
        .fontColor('#999999')
        .margin({ top: px2vp(3 * 3.5) })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ left: px2vp(12 * 3.5) })
  }
  .width(CommonConstants.FULL_PARENT)
  .margin({ left: px2vp(24 * 3.5) })
  .alignItems(VerticalAlign.Top)
}

@Builder
function MaterialItem(material: RequiredMaterial) {
  Row() {
    Text(material.required ? '●' : '○')
      .fontSize(px2vp(12 * 3.5))
      .fontColor(material.required ? '#FF6B35' : '#CCCCCC')
    Text(material.name)
      .fontSize(px2vp(15 * 3.5))
      .fontColor('#333333')
      .margin({ left: px2vp(8 * 3.5) })
    if (material.required) {
      Text('必需')
        .fontSize(px2vp(10 * 3.5))
        .fontColor(Color.White)
        .backgroundColor('#FF6B35')
        .borderRadius(px2vp(3 * 3.5))
        .padding({ left: '5vp', right: '5vp', top: '1vp', bottom: '1vp' })
        .margin({ left: '6vp' })
    } else {
      Text('选交')
        .fontSize(px2vp(10 * 3.5))
        .fontColor('#999999')
        .backgroundColor('#F0F0F0')
        .borderRadius(px2vp(3 * 3.5))
        .padding({ left: '5vp', right: '5vp', top: '1vp', bottom: '1vp' })
        .margin({ left: '6vp' })
    }
  }
  .width(CommonConstants.FULL_PARENT)
  .height(px2vp(32 * 3.5))
  .padding({ left: px2vp(16 * 3.5) })
}

@Component
struct ServiceDetailPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  private steps: ServiceStep[] = getServiceSteps()
  private materials: RequiredMaterial[] = getMaterials()

  build() {
    NavDestination() {
      Column() {
        Scroll() {
          Column() {
            // 顶部图片
            Image($r('app.media.officbackground'))
              .width(px2vp(360 * 3.5))
              .height(px2vp(140 * 3.5))

            // 头部
            DetailHeader('服务详情', '在线办理，方便快捷')

            // 基本信息卡片
            SectionTitle('基本信息')
            Row() {
              InfoCard('服务部门', '市行政服务中心')
              InfoCard('办理时限', '3-5个工作日')
            }
            .width(CommonConstants.FULL_PARENT)
            .justifyContent(FlexAlign.SpaceAround)
            .margin({ top: px2vp(8 * 3.5) })

            Row() {
              InfoCard('办理方式', '线上/线下均可')
              InfoCard('收费标准', '免费办理')
            }
            .width(CommonConstants.FULL_PARENT)
            .justifyContent(FlexAlign.SpaceAround)
            .margin({ top: px2vp(8 * 3.5) })

            // 办理步骤
            SectionTitle('办理步骤')
            Column() {
              ForEach(this.steps, (item: ServiceStep, index: number) => {
                StepItem(item, index === this.steps.length - 1)
              })
            }
            .width(CommonConstants.FULL_PARENT)
            .backgroundColor(Color.White)
            .borderRadius(px2vp(12 * 3.5))
            .padding({ top: px2vp(12 * 3.5), bottom: px2vp(12 * 3.5) })
            .margin({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5) })

            // 所需材料
            SectionTitle('所需材料')
            Column() {
              ForEach(this.materials, (item: RequiredMaterial) => {
                MaterialItem(item)
              })
            }
            .width(CommonConstants.FULL_PARENT)
            .backgroundColor(Color.White)
            .borderRadius(px2vp(12 * 3.5))
            .padding({ top: px2vp(8 * 3.5), bottom: px2vp(8 * 3.5) })
            .margin({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5) })

          }
          .width(CommonConstants.FULL_PARENT)
        }
        .width(CommonConstants.FULL_PARENT)
        .layoutWeight(1)
        .scrollBar(BarState.Auto)
      }
      .width(CommonConstants.FULL_PARENT)
      .height(CommonConstants.FULL_PARENT)
      .backgroundColor('#F1F3F5')
      .margin({ top: this.topRectHeight })
    }
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
  }
}

const builderName = BuilderNameConstants.ServiceDetail;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ServiceDetailBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
