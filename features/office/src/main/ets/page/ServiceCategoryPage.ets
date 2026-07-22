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
 * 办事分类数据模型
 */
class ServiceCategoryData {
  title: string
  icon: Resource
  desc: string
  tag: string

  constructor(title: string, icon: Resource, desc: string, tag: string) {
    this.title = title
    this.icon = icon
    this.desc = desc
    this.tag = tag
  }
}

/**
 * 获取办事分类数据
 */
function getServiceCategories(): ServiceCategoryData[] {
  return [
    new ServiceCategoryData('社保服务', $r('app.media.work_serives'), '社保查询、参保登记、社保证明', '热门'),
    new ServiceCategoryData('公积金', $r('app.media.Rental_Service'), '公积金查询、提取、贷款办理', '常用'),
    new ServiceCategoryData('户籍办理', $r('app.media.startIcon'), '户口登记、迁移、身份证办理', '常用'),
    new ServiceCategoryData('出入境', $r('app.media.fig1'), '护照、港澳通行证、签证办理', '热门'),
    new ServiceCategoryData('交通出行', $r('app.media.walk'), '违章查询、驾驶证、车辆年检', '常用'),
    new ServiceCategoryData('养老服务', $r('app.media.elderly_care'), '养老金、老年证、养老服务', '推荐'),
    new ServiceCategoryData('房产服务', $r('app.media.house'), '房产登记、查询、交易过户', '常用'),
    new ServiceCategoryData('婚姻登记', $r('app.media.marriage'), '结婚登记、离婚、婚姻证明', '推荐'),
    new ServiceCategoryData('税务服务', $r('app.media.Rental_Service'), '个税申报、发票查询、税务登记', '常用'),
    new ServiceCategoryData('教育服务', $r('app.media.fig2'), '学籍查询、考试报名、学历认证', '推荐'),
  ]
}

@Builder
export function ServiceCategoryBuilder(param: object) {
  ServiceCategoryPage()
}

@Builder
function TitleBarBuilder() {
  Row() {
    Image($r('app.media.ic_public_gps'))
      .width(px2vp(20 * 3.5))
      .height(px2vp(20 * 3.5))
      .margin({ left: px2vp(12 * 3.5) })
    Text('办事分类')
      .fontSize(px2vp(20 * 3.5))
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Bold)
      .margin({ left: px2vp(8 * 3.5) })
  }
  .width(CommonConstants.FULL_PARENT)
  .height(px2vp(48 * 3.5))
}

@Builder
function CategoryListItem(item: ServiceCategoryData, index: number) {
  Row() {
    Text(`${index + 1}`)
      .fontSize(px2vp(16 * 3.5))
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .width(px2vp(36 * 3.5))
      .height(px2vp(36 * 3.5))
      .backgroundColor('#FF6B35')
      .borderRadius(px2vp(18 * 3.5))
      .textAlign(TextAlign.Center)
      .margin({ left: px2vp(12 * 3.5) })
    Column() {
      Row() {
        Text(item.title)
          .fontSize(px2vp(16 * 3.5))
          .fontWeight(500)
          .fontColor('#333333')
        Text(item.tag)
          .fontSize(px2vp(10 * 3.5))
          .fontColor(Color.White)
          .backgroundColor('#FF6B35')
          .borderRadius(px2vp(4 * 3.5))
          .padding({ left: '6vp', right: '6vp', top: '2vp', bottom: '2vp' })
          .margin({ left: '8vp' })
      }
      Text(item.desc)
        .fontSize(px2vp(12 * 3.5))
        .fontColor('#999999')
        .margin({ top: '4vp' })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ left: px2vp(12 * 3.5) })

    Blank()
    Image($r('app.media.ic_public_arrow_right'))
      .width('22vp')
      .height('22vp')
      .margin({ right: px2vp(16 * 3.5) })
      .opacity(0.5)
  }
  .width(CommonConstants.FULL_PARENT)
  .height(px2vp(60 * 3.5))
  .backgroundColor(Color.White)
  .borderRadius(px2vp(8 * 3.5))
  .onClick(() => {
    buildRouterModel(RouterNameConstants.ENTRY_HAP,
      BuilderNameConstants.OFFICE + '_' + 'ServiceDetail')
  })
}

@Component
struct ServiceCategoryPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  private categories: ServiceCategoryData[] = getServiceCategories()

  build() {
    NavDestination() {
      Column() {
        TitleBarBuilder()

        // 搜索入口
        Row() {
          Search({ placeholder: '搜索办事服务...' })
            .placeholderColor('#999999')
            .searchIcon({ src: $r('app.media.ic_public_input_search') })
            .width(px2vp(328 * 3.5))
            .height(px2vp(40 * 3.5))
            .borderRadius(px2vp(20 * 3.5))
            .backgroundColor('#F5F5F5')
            .onClick(() => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.ServiceSearch)
            })
        }
        .width(CommonConstants.FULL_PARENT)
        .justifyContent(FlexAlign.Center)
        .margin({ top: px2vp(12 * 3.5), bottom: px2vp(12 * 3.5) })

        // 全部分类标题
        Row() {
          Text('全部分类')
            .fontSize(px2vp(16 * 3.5))
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ left: px2vp(12 * 3.5) })
          Text(`共${this.categories.length}项`)
            .fontSize(px2vp(12 * 3.5))
            .fontColor('#999999')
            .margin({ left: '8vp' })
        }
        .width(CommonConstants.FULL_PARENT)
        .margin({ top: px2vp(8 * 3.5), bottom: px2vp(8 * 3.5) })

        // 分类列表
        List({ space: px2vp(8 * 3.5) }) {
          ForEach(this.categories, (item: ServiceCategoryData, index: number) => {
            ListItem() {
              CategoryListItem(item, index)
            }
          }, (item: ServiceCategoryData) => item.title)
        }
        .width(CommonConstants.FULL_PARENT)
        .layoutWeight(1)
        .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5) })
        .margin({ bottom: px2vp(12 * 3.5) })
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

const builderName = BuilderNameConstants.ServiceCategory;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ServiceCategoryBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
