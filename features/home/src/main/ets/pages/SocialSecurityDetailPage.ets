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

// 费率解析结果
class RateInfo {
  personalRate: number = 0;  // 个人比例(%)
  companyRate: number = 0;   // 单位比例(%)
  personalAmount: number = 0; // 个人缴存额
  companyAmount: number = 0;  // 单位缴存额
}

// 从desc解析比例，按本月存缴(subMoney)乘以各比例分配个人/单位金额
function parseRates(desc: string, subMoney: number): RateInfo {
  let info: RateInfo = new RateInfo();
  let companyMatch = desc.match(/单位[：:]\s*([\d.]+)%/);
  let personalMatch = desc.match(/个人[：:]\s*([\d.]+)%/);
  if (companyMatch) {
    info.companyRate = parseFloat(companyMatch[1]);
  }
  if (personalMatch) {
    info.personalRate = parseFloat(personalMatch[1]);
  }
  let totalRate: number = info.personalRate + info.companyRate;
  if (totalRate > 0) {
    info.personalAmount = subMoney * info.personalRate / totalRate;
    info.companyAmount = subMoney * info.companyRate / totalRate;
  }
  return info;
}

// 从 params 普通对象安全读取数值
function getNumber(val: Object | null | undefined, defaultVal: number): number {
  if (val !== null && val !== undefined) {
    return val as number;
  }
  return defaultVal;
}

function getString(val: Object | null | undefined, defaultVal: string): string {
  if (val !== null && val !== undefined) {
    return val as string;
  }
  return defaultVal;
}

@Builder
export function SocialSecurityDetailBuilder(params: object) {
  SocialSecurityDetailPage(params)
}

@Component
struct SocialSecurityDetailPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  @State title: string = ''
  @State money: number = 0
  @State subMoney: number = 0
  @State desc: string = ''
  @State baseAmount: number = 0
  @State personalRate: number = 0
  @State companyRate: number = 0
  @State personalAmount: number = 0
  @State companyAmount: number = 0

  constructor(params: object) {
    super();
    let p: Record<string, Object> = params as Record<string, Object>
    this.title = getString(p['title'], '');
    this.money = getNumber(p['money'], 0);
    this.subMoney = getNumber(p['subMoney'], 0);
    this.desc = getString(p['desc'], '');
    this.baseAmount = getNumber(p['baseAmount'], 0);
  }

  aboutToAppear(): void {
    let info: RateInfo = parseRates(this.desc, this.subMoney);
    this.personalRate = info.personalRate;
    this.companyRate = info.companyRate;
    this.personalAmount = info.personalAmount;
    this.companyAmount = info.companyAmount;
  }

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

            Text('缴费详情')
              .fontSize('20vp')
              .fontWeight(700)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .margin({ right: '40vp' })
          }
          .width('100%')
          .height('56vp')
          .backgroundColor(Color.White)

          // 险种标题卡片
          Column() {
            Text(this.title)
              .fontSize('22vp')
              .fontWeight(700)
              .fontColor('#333333')
              .width('100%')
              .textAlign(TextAlign.Center)

            Text(`缴费基数：${this.baseAmount.toFixed(2)} 元/月`)
              .fontSize('14vp')
              .fontColor(Color.Gray)
              .margin({ top: '8vp' })
          }
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius('16vp')
          .padding({ top: '24vp', bottom: '20vp', left: '20vp', right: '20vp' })
          .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
          .margin({ top: '20vp' })

          // 账户余额卡片
          Column() {
            Text('账户余额')
              .fontSize('13vp')
              .fontColor(Color.Gray)
              .width('100%')

            Text(`${this.money.toFixed(2)}`)
              .fontSize('36vp')
              .fontColor('#FF8C00')
              .fontWeight(700)
              .margin({ top: '8vp' })
              .width('100%')
          }
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius('16vp')
          .padding('20vp')
          .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
          .margin({ top: '16vp' })

          // 本月缴存拆解卡片
          Column() {
            Text('本月缴存明细')
              .fontSize('15vp')
              .fontWeight(600)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: '16vp' })

            // 个人缴存
            Row() {
              Column() {
                Text('个人缴存')
                  .fontSize('13vp')
                  .fontColor(Color.Gray)
                if (this.personalRate > 0) {
                  Text(`${this.personalRate.toFixed(1)}%`)
                    .fontSize('11vp')
                    .fontColor('#FF8C00')
                    .margin({ top: '2vp' })
                } else {
                  Text('个人不缴')
                    .fontSize('11vp')
                    .fontColor(Color.Gray)
                    .margin({ top: '2vp' })
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Text(`${this.personalAmount.toFixed(2)}`)
                .fontSize('18vp')
                .fontWeight(600)
                .fontColor('#333333')
            }
            .width('100%')
            .margin({ bottom: '12vp' })

            Divider().color('#F0F0F0')

            // 单位缴存
            Row() {
              Column() {
                Text('单位缴存')
                  .fontSize('13vp')
                  .fontColor(Color.Gray)
                if (this.companyRate > 0) {
                  Text(`${this.companyRate.toFixed(1)}%`)
                    .fontSize('11vp')
                    .fontColor('#FF8C00')
                    .margin({ top: '2vp' })
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Text(`${this.companyAmount.toFixed(2)}`)
                .fontSize('18vp')
                .fontWeight(600)
                .fontColor('#333333')
            }
            .width('100%')
            .margin({ bottom: '12vp' })

            Divider().color('#F0F0F0')

            // 合计 = 本月存缴
            Row() {
              Text('本月合计缴存')
                .fontSize('14vp')
                .fontWeight(600)
                .fontColor('#333333')

              Blank()

              Text(`+${this.subMoney.toFixed(2)}`)
                .fontSize('20vp')
                .fontWeight(700)
                .fontColor('#FF8C00')
            }
            .width('100%')
          }
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius('16vp')
          .padding('20vp')
          .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
          .margin({ top: '16vp' })

          // 缴费比例说明卡片
          Column() {
            Text('缴费比例说明')
              .fontSize('15vp')
              .fontWeight(600)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: '12vp' })

            Text(this.desc)
              .fontSize('14vp')
              .fontColor('#666666')
              .width('100%')
              .lineHeight(22)
          }
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius('16vp')
          .padding('20vp')
          .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
          .margin({ top: '16vp', bottom: '30vp' })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .backgroundColor('#F1F3F5')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = CommonConstants.SocialSecurityDetail;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SocialSecurityDetailBuilder);
  RouterModule.registerBuilder(builderName, builder);
}