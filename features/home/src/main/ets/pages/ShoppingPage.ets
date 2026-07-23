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

import { BuilderNameConstants, RouterModule } from 'RouterModule'
import { promptAction } from '@kit.ArkUI'

interface GoodsItem {
  img: Resource
  name: string
  price: string
  sold: string
  category: string
}

@Builder
export function ShoppingBuilder() {
  ShoppingPage()
}

@Component
export struct ShoppingPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  @State selectedCatIdx: number = 0
  @State filteredGoods: GoodsItem[] = []

  private categories: string[] = ['推荐', '食品', '日用品', '数码', '服饰', '美妆']

  private allGoods: GoodsItem[] = [
    { img: $r('app.media.youjidami'), name: '有机大米5kg装', price: '49.9', sold: '已售1.2万', category: '食品' } as GoodsItem,
    { img: $r('app.media.jianguo'), name: '坚果礼盒装', price: '68.0', sold: '已售1.8万', category: '食品' } as GoodsItem,
    { img: $r('app.media.chunniunai'), name: '进口牛奶整箱', price: '55.0', sold: '已售3.1万', category: '食品' } as GoodsItem,
    { img: $r('app.media.cunmian'), name: '纯棉四件套', price: '159.0', sold: '已售5600', category: '日用品' } as GoodsItem,
    { img: $r('app.media.xiyiye'), name: '洗衣液3kg装', price: '29.9', sold: '已售4.2万', category: '日用品' } as GoodsItem,
    { img: $r('app.media.lanyeerji'), name: '蓝牙降噪耳机', price: '199.0', sold: '已售8900', category: '数码' } as GoodsItem,
    { img: $r('app.media.yundongshouhuan'), name: '智能手环运动版', price: '89.9', sold: '已售2.3万', category: '数码' } as GoodsItem,
    { img: $r('app.media.yundongT'), name: '运动T恤男款', price: '79.0', sold: '已售1.5万', category: '服饰' } as GoodsItem,
    { img: $r('app.media.fanbuxie'), name: '休闲帆布鞋', price: '99.0', sold: '已售9800', category: '服饰' } as GoodsItem,
    { img: $r('app.media.hufupin'), name: '保湿护肤品套装', price: '128.0', sold: '已售9800', category: '美妆' } as GoodsItem,
    { img: $r('app.media.fangshaishuang'), name: '防晒霜SPF50', price: '69.0', sold: '已售1.1万', category: '美妆' } as GoodsItem,
  ]

  aboutToAppear(): void {
    this.applyFilter()
  }

  applyFilter(): void {
    if (this.selectedCatIdx === 0) {
      this.filteredGoods = this.allGoods
    } else {
      let cat: string = this.categories[this.selectedCatIdx]
      let result: GoodsItem[] = []
      for (let i = 0; i < this.allGoods.length; i++) {
        if (this.allGoods[i].category === cat) {
          result.push(this.allGoods[i])
        }
      }
      this.filteredGoods = result
    }
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width('24vp')
            .height('24vp')
            .fillColor(Color.Black)
            .margin({ left: '16vp' })
            .onClick(() => this.pathStack.pop())

          Text('购物')
            .fontSize('20vp')
            .fontWeight(700)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .margin({ right: '40vp' })
        }
        .width('100%')
        .height('56vp')
        .backgroundColor(Color.White)

        // 分类横滑
        Row() {
          ForEach(this.categories, (cat: string, index: number) => {
            Text(cat)
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(this.selectedCatIdx === index ? 600 : 400)
              .fontColor(this.selectedCatIdx === index ? '#E84026' : '#666666')
              .padding({ left: px2vp(8 * 3.5), right: px2vp(8 * 3.5) })
              .onClick(() => {
                this.selectedCatIdx = index
                this.applyFilter()
              })
          })
        }
        .width('100%')
        .height(px2vp(44 * 3.5))
        .backgroundColor(Color.White)
        .padding({ left: px2vp(12 * 3.5) })

        // 商品列表
        Scroll() {
          Column() {
            if (this.filteredGoods.length === 0) {
              Text('暂无该类商品')
                .fontSize(px2vp(15 * 3.5))
                .fontColor(Color.Gray)
                .width('100%')
                .textAlign(TextAlign.Center)
                .margin({ top: px2vp(60 * 3.5) })
            }
            Grid() {
              ForEach(this.filteredGoods, (item: GoodsItem) => {
                GridItem() {
                  Column() {
                    Image(item.img)
                      .width('100%')
                      .height(px2vp(110 * 3.5))
                      .borderRadius(px2vp(8 * 3.5))
                      .objectFit(ImageFit.Cover)

                    Text(item.name)
                      .fontSize(px2vp(14 * 3.5))
                      .fontWeight(500)
                      .fontColor('#333333')
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .width('100%')
                      .margin({ top: px2vp(8 * 3.5) })

                    Row() {
                      Text(`¥${item.price}`)
                        .fontSize(px2vp(16 * 3.5))
                        .fontWeight(700)
                        .fontColor('#E84026')

                      Text(item.sold)
                        .fontSize(px2vp(11 * 3.5))
                        .fontColor(Color.Gray)
                        .margin({ left: px2vp(6 * 3.5) })
                        .layoutWeight(1)

                      Image($r('app.media.ic_public_list_add_transparent'))
                        .width(px2vp(20 * 3.5))
                        .height(px2vp(20 * 3.5))
                        .onClick(() => {
                          promptAction.showToast({ message: `已加入购物车` })
                        })
                    }
                    .width('100%')
                    .margin({ top: px2vp(6 * 3.5) })
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .width('100%')
                  .padding(px2vp(8 * 3.5))
                  .backgroundColor(Color.White)
                  .borderRadius(px2vp(8 * 3.5))
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(px2vp(8 * 3.5))
            .rowsGap(px2vp(8 * 3.5))
            .width('100%')
            .padding(px2vp(16 * 3.5))
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F1F3F5')
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = BuilderNameConstants.HOMEPAGE + '_Shopping'
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ShoppingBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
