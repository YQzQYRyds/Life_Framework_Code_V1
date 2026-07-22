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
import { promptAction } from '@kit.ArkUI'

/**
 * 搜索结果数据模型
 */
class SearchResultData {
  title: string
  category: string
  desc: string
  icon: Resource

  constructor(title: string, category: string, desc: string, icon: Resource) {
    this.title = title
    this.category = category
    this.desc = desc
    this.icon = icon
  }
}

/**
 * 模拟服务数据
 */
function getAllServices(): SearchResultData[] {
  return [
    new SearchResultData('社保查询', '社保服务', '查询个人社保缴纳记录和账户余额', $r('app.media.spot_light')),
    new SearchResultData('公积金提取', '公积金', '在线办理公积金提取业务', $r('app.media.square_and_pencil')),
    new SearchResultData('身份证办理', '户籍办理', '居民身份证申领、换领、补领', $r('app.media.person_text_rectangle_fill')),
    new SearchResultData('护照办理', '出入境', '普通护照首次申请、换发、补发', $r('app.media.notice_1')),
    new SearchResultData('违章查询', '交通出行', '机动车交通违法记录查询', $r('app.media.walk')),
    new SearchResultData('养老金认证', '养老服务', '退休人员养老金领取资格认证', $r('app.media.elderly_care')),
    new SearchResultData('不动产登记', '房产服务', '不动产登记信息查询与办理', $r('app.media.house')),
    new SearchResultData('结婚登记预约', '婚姻登记', '在线预约结婚登记办理时间', $r('app.media.marriage')),
    new SearchResultData('个税申报', '税务服务', '个人所得税年度汇算清缴', $r('app.media.card')),
    new SearchResultData('学籍查询', '教育服务', '学籍信息在线查询', $r('app.media.guideline')),
    new SearchResultData('驾照换证', '交通出行', '机动车驾驶证期满换证', $r('app.media.walk')),
    new SearchResultData('居住证办理', '户籍办理', '居住证申领、续签办理', $r('app.media.person_text_rectangle_fill')),
  ]
}

@Builder
export function ServiceSearchBuilder(param: object) {
  ServiceSearchPage()
}

@Builder
function SearchTopBar(searchText: string, onChange: (value: string) => void, onSearch: () => void) {
  Row() {
    Search({ placeholder: '输入服务名称搜索...', value: searchText })
      .placeholderColor('#999999')
      .searchIcon({ src: $r('app.media.ic_public_input_search') })
      .width(px2vp(280 * 3.5))
      .height(px2vp(40 * 3.5))
      .borderRadius(px2vp(20 * 3.5))
      .backgroundColor('#F5F5F5')
      .onChange((value: string) => {
        onChange(value)
      })
      .onSubmit((value: string) => {
        onChange(value)
        onSearch()
      })

    Text('取消')
      .fontSize(px2vp(16 * 3.5))
      .fontColor('#333333')
      .margin({ left: px2vp(12 * 3.5) })
      .onClick(() => {
        RouterModule.pop(RouterNameConstants.ENTRY_HAP)
      })
  }
  .width(CommonConstants.FULL_PARENT)
  .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5) })
}

@Builder
function HotSearchBuilder(onTagClick: (tag: string) => void) {
  Column() {
    Row() {
      Text('热门搜索')
        .fontSize(px2vp(16 * 3.5))
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
    }
    .width(CommonConstants.FULL_PARENT)
    .margin({ left: px2vp(12 * 3.5), top: px2vp(16 * 3.5) })

    Grid() {
      GridItem() {
        Text('社保')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('社保') })
      }
      GridItem() {
        Text('公积金')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('公积金') })
      }
      GridItem() {
        Text('身份证')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('身份证') })
      }
      GridItem() {
        Text('护照')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('护照') })
      }
      GridItem() {
        Text('违章')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('违章') })
      }
      GridItem() {
        Text('结婚')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('结婚') })
      }
      GridItem() {
        Text('个税')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('个税') })
      }
      GridItem() {
        Text('驾照')
          .fontSize(px2vp(14 * 3.5))
          .fontColor('#666666')
          .backgroundColor('#F0F0F0')
          .borderRadius(px2vp(16 * 3.5))
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(6 * 3.5), bottom: px2vp(6 * 3.5) })
          .onClick(() => { onTagClick('驾照') })
      }
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(px2vp(8 * 3.5))
    .rowsGap(px2vp(8 * 3.5))
    .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5), top: px2vp(8 * 3.5) })
  }
  .width(CommonConstants.FULL_PARENT)
}

@Builder
function SearchResultItem(item: SearchResultData, index: number) {
  Row() {
    Text(`${index + 1}`)
      .fontSize(px2vp(14 * 3.5))
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .width(px2vp(32 * 3.5))
      .height(px2vp(32 * 3.5))
      .backgroundColor('#FF6B35')
      .borderRadius(px2vp(16 * 3.5))
      .textAlign(TextAlign.Center)
      .margin({ left: px2vp(12 * 3.5) })
    Column() {
      Text(item.title)
        .fontSize(px2vp(16 * 3.5))
        .fontWeight(500)
        .fontColor('#333333')
      Row() {
        Text(item.category)
          .fontSize(px2vp(11 * 3.5))
          .fontColor('#FF6B35')
          .backgroundColor('#FFF0E8')
          .borderRadius(px2vp(3 * 3.5))
          .padding({ left: '6vp', right: '6vp', top: '1vp', bottom: '1vp' })
        Text(item.desc)
          .fontSize(px2vp(12 * 3.5))
          .fontColor('#999999')
          .margin({ left: '8vp' })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .margin({ top: '3vp' })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ left: px2vp(10 * 3.5) })
    .layoutWeight(1)

    Image($r('app.media.spot_light'))
      .width(px2vp(14 * 3.5))
      .height(px2vp(14 * 3.5))
      .margin({ right: px2vp(16 * 3.5) })
      .opacity(0.3)
  }
  .width(CommonConstants.FULL_PARENT)
  .height(px2vp(56 * 3.5))
  .backgroundColor(Color.White)
  .borderRadius(px2vp(8 * 3.5))
  .onClick(() => {
    buildRouterModel(RouterNameConstants.ENTRY_HAP,
      BuilderNameConstants.OFFICE + '_' + 'ServiceDetail')
  })
}

@Component
struct ServiceSearchPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  @State searchText: string = ''
  @State searchResults: SearchResultData[] = []
  @State hasSearched: boolean = false
  private allServices: SearchResultData[] = getAllServices()

  /**
   * 执行搜索
   */
  doSearch(keyword: string): void {
    if (!keyword || keyword.trim().length === 0) {
      this.hasSearched = false
      this.searchResults = []
      return
    }
    this.hasSearched = true
    const keywordLower = keyword.trim().toLowerCase()
    this.searchResults = this.allServices.filter((item: SearchResultData) => {
      return item.title.toLowerCase().includes(keywordLower) ||
        item.category.toLowerCase().includes(keywordLower) ||
        item.desc.toLowerCase().includes(keywordLower)
    })
  }

  onTagClick(tag: string): void {
    this.searchText = tag
    this.doSearch(tag)
  }

  build() {
    NavDestination() {
      Column() {
        // 顶部搜索栏
        Row() {
          SearchTopBar(this.searchText,
            (value: string) => {
              this.searchText = value
              if (value.length === 0) {
                this.hasSearched = false
                this.searchResults = []
              }
            },
            () => {
              this.doSearch(this.searchText)
            })
        }
        .margin({ top: px2vp(8 * 3.5) + this.topRectHeight })

        if (this.hasSearched && this.searchResults.length > 0) {
          // 搜索结果
          Row() {
            Text(`找到 ${this.searchResults.length} 个相关服务`)
              .fontSize(px2vp(14 * 3.5))
              .fontColor('#666666')
              .margin({ left: px2vp(12 * 3.5) })
          }
          .width(CommonConstants.FULL_PARENT)
          .margin({ top: px2vp(12 * 3.5), bottom: px2vp(8 * 3.5) })

          List({ space: px2vp(6 * 3.5) }) {
            ForEach(this.searchResults, (item: SearchResultData, index: number) => {
              ListItem() {
                SearchResultItem(item, index)
              }
            }, (item: SearchResultData) => item.title)
          }
          .width(CommonConstants.FULL_PARENT)
          .layoutWeight(1)
          .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5) })
        } else if (this.hasSearched && this.searchResults.length === 0) {
          // 无搜索结果
          Column() {
            Image($r('app.media.ic_search'))
              .width(px2vp(60 * 3.5))
              .height(px2vp(60 * 3.5))
              .opacity(0.4)
              .margin({ top: px2vp(60 * 3.5) })
            Text('未找到相关服务')
              .fontSize(px2vp(16 * 3.5))
              .fontColor('#999999')
              .margin({ top: px2vp(16 * 3.5) })
            Text('请尝试其他关键词')
              .fontSize(px2vp(14 * 3.5))
              .fontColor('#CCCCCC')
              .margin({ top: px2vp(8 * 3.5) })
          }
          .width(CommonConstants.FULL_PARENT)
          .layoutWeight(1)
        } else {
          // 热门搜索
          HotSearchBuilder((tag: string) => {
            this.onTagClick(tag)
          })

          // 历史搜索
          Column() {
            Row() {
              Text('全部服务')
                .fontSize(px2vp(16 * 3.5))
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .margin({ left: px2vp(12 * 3.5) })
            }
            .width(CommonConstants.FULL_PARENT)
            .margin({ top: px2vp(20 * 3.5) })

            List({ space: px2vp(6 * 3.5) }) {
              ForEach(this.allServices.slice(0, 8), (item: SearchResultData, index: number) => {
                ListItem() {
                  SearchResultItem(item, index)
                }
              }, (item: SearchResultData) => item.title)
            }
            .width(CommonConstants.FULL_PARENT)
            .layoutWeight(1)
            .padding({ left: px2vp(12 * 3.5), right: px2vp(12 * 3.5) })
          }
          .width(CommonConstants.FULL_PARENT)
          .layoutWeight(1)
        }
      }
      .width(CommonConstants.FULL_PARENT)
      .height(CommonConstants.FULL_PARENT)
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
  }
}

const builderName = BuilderNameConstants.ServiceSearch;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ServiceSearchBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
