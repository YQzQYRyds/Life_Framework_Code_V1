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
import mainViewModel from '../viewmodle/MainViewModel'
import ItemData from '../viewmodle/ItemData'
import { promptAction } from '@kit.ArkUI'
import { scanBarcode, scanCore } from '@kit.ScanKit';
import { image } from '@kit.ImageKit';
// 导入默认界面需要的日志模块和错误码模块
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'RouterModule'
import { UtilTools } from '../Util/UtilTools'
import { GlobalContext } from '../Util/GlobalContext'

let homePageContext: Context | null = null;

@Builder
export function HomePageBuilder() {
  HomePage()
}

@Builder
function SearchBuilder() {
  Row() {
    Image($r('app.media.ic_public_gps'))
      .width(px2vp(24 * 3.5))
      .height(px2vp(24 * 3.5))
      .margin({ left: px2vp(16 * 3.5)})
    Text('城市')
      .fontSize(px2vp(18 * 3.5))
      .fontColor(Color.White)
      .margin({ left: px2vp(2.11 * 3.5)},)

    Search({ placeholder: '搜索...' })
      .placeholderColor(Color.White)
      .searchIcon({ src: $r('app.media.ic_public_input_search') })
      .width(px2vp(248 * 3.5))
      .height(px2vp(40 * 3.5))
      .margin({ left: px2vp(14 * 3.5)})


  }
  .width(CommonConstants.FULL_PARENT)
}

@Builder
function FirstGridBuilder(items: ItemData[]) {
  Grid() {
    ForEach(items, (item: ItemData) => {
      GridItem() {
        Column() {
          Image(item.img)
            .width(px2vp(48 * 3.5))
            .height(px2vp(48 * 3.5))
          Text(item.title)
            .fontSize(px2vp(16 * 3.5))
            .fontColor(Color.White)
            .margin({ top: px2vp(8 * 3.5) })
        }
      }
      .onClick(() => {
        switch (item.name) {
          case 'scan':
            let options: scanBarcode.ScanOptions = {
              scanTypes: [scanCore.ScanType.ALL],
              enableMultiMode: true,
              enableAlbum: true
            };
            // 可调用getContext接口获取当前页面关联的UIAbilityContext
            scanBarcode.startScanForResult(homePageContext!, options).then((result: scanBarcode.ScanResult) => {
              // 收到扫码结果后返回
              hilog.info(0x0001, '[Scan CPSample]',
                `Succeeded in getting ScanResult by promise with options, result is ${JSON.stringify(result)}`);
            }).catch((error: BusinessError) => {
              hilog.error(0x0001, '[Scan CPSample]',
                `Failed to get ScanResult by promise with options. Code:${error.code}, message: ${error.message}`);
            });
            break;
          case 'Code':
            UtilTools.getIns().creatQR().then((px: image.PixelMap | undefined) => {
              if (px) {
                GlobalContext.getContext().setObject('px', px)
              }
            })
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
            break
          case 'Credentials':
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
            break
        }
      })
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr 1fr 1fr')
  .columnsGap('12vp')
  .rowsGap('12vp')
  .padding({ top: '25vp' })
  .margin({ left: px2vp(15 * 3.5) })
}

@Builder
function SecondGridBuilder(items: ItemData[]) {
  Grid() {
    ForEach(items, (item: ItemData) => {
      GridItem() {
        Column() {
          Image(item.img)
            .width(px2vp(24 * 3.5))
            .height(px2vp(24 * 3.5))
          Text(item.title)
            .fontSize(px2vp(12 * 3.5))
            .margin({ top: '8vp' })
            .fontWeight(400)
        }
      }
      .onClick(() => {
        if (item.name === 'More' || item.name === 'ticket' || item.name === 'Shopping' || item.name === 'ExitEntry') {
          promptAction.showToast({
            message: '功能还在开发中'
          })
        } else {
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
        }
      })
    }, (item: ItemData) => JSON.stringify(item))
  }
  .columnsTemplate('1fr 1fr 1fr 1fr')
  .rowsTemplate('1fr 1fr')
  .columnsGap('8vp')
  .rowsGap('12vp')
  .height('148vp')
  .padding({ top: '12vp', bottom: '12vp' })
  .backgroundColor(Color.White)
}

@Builder
function ThirdGridBuilder(items: ItemData[]) {
  // 网格
  Grid() {
    ForEach(items, (thirdItem: ItemData) => {
      GridItem() {
        Column() {
          Image(thirdItem.img)
            .width(px2vp(165 * 3.5))
            .height(px2vp(105 * 3.5))
            .borderRadius(px2vp(14 * 3.5))
            .margin({ top: px2vp(10 * 3.5) })
          Text(thirdItem.title)
            .fontSize(px2vp(14 * 3.5))
            .fontWeight(400)
            .margin({ top: px2vp(10 * 3.5) })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .margin({ right: px2vp(4 * 3.5), left: px2vp(10 * 3.5) })
    }, (secondItem: ItemData) => JSON.stringify(secondItem))
  }
  .height(px2vp(300 * 3.5))
  .columnsTemplate('1fr 1fr')
  .rowsTemplate('1fr 1fr')
  .columnsGap('8vp')
  .rowsGap('12vp')
  .margin({ top: px2vp(4 * 3.5), right: px2vp(10 * 3.5) })
}

@Builder
function TextBuilder(title: string, fSize: string = '18fp', fWeight: FontWeight = FontWeight.Medium,
  fColor: string = '#000000') {
  Text(title)
    .fontSize(fSize ? fSize : '18fp')
    .fontWeight(fWeight)
    .width(CommonConstants.FULL_PARENT)
    .margin({ top: px2vp(8 * 3.5), left: '15vp' })
    .fontColor(fColor)
    .fontWeight(FontWeight.Bold)
}


@Component
export struct HomePage {
  @Prop homePageStack: NavPathStack
  @StorageLink('topRectHeight') topRectHeight: number = 0

  aboutToAppear(): void {
    homePageContext = getContext(this);
  }

  build() {
    Navigation(this.homePageStack) {
      Scroll() {
        Column() {
          Column() {
            Row() {
              SearchBuilder()
            }
            .margin({ top: this.topRectHeight})

            Row() {
              FirstGridBuilder(mainViewModel.getFirstGridData())
            }
          }

          Column() {
            TextBuilder('灵活办公')
            SecondGridBuilder(mainViewModel.getSecondGridData())
            TextBuilder('精选主题')
            ThirdGridBuilder(mainViewModel.getThirdGridData())
          }
          .alignItems(HorizontalAlign.Start)
          .height('100%')
          .margin({ top: px2vp(28 * 3.5) })
          .backgroundColor(Color.White)
          // .borderRadius(px2vp(16 * 3.5))
        }
      }
      .height(CommonConstants.FULL_PARENT)
      .scrollBar(BarState.Off)
    }
    .hideTitleBar(true)
    .backgroundImage($r('app.media.background'))
    .backgroundImageSize(ImageSize.Contain)
  }
}


const builderName = BuilderNameConstants.HOMEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(HomePageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
