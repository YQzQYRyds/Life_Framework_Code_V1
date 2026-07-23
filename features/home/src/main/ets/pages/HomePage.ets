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

// 全局通用常量
import CommonConstants from 'common/constants/CommonConstants'
// 首页视图模型：提供各个网格入口的配置数据
import mainViewModel from '../viewmodle/MainViewModel'
// 服务入口单项数据实体类（图标、名称、标题、路由标识）
import ItemData from '../viewmodle/ItemData'
// 简易弹窗Toast工具
import { promptAction } from '@kit.ArkUI'
// 扫码ScanKit能力：扫码配置、扫码核心枚举
import { scanBarcode, scanCore } from '@kit.ScanKit';
// ImageKit图像模块，用于承载生成的二维码PixelMap
import { image } from '@kit.ImageKit';
// 日志打印工具、错误类型定义
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
// 项目自定义路由框架：路由常量、路由构建工具、路由注册管理器
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'RouterModule'
// 通用工具类：二维码生成方法
import { UtilTools } from '../Util/UtilTools'
// 全局上下文，跨页面传递PixelMap二维码图像
import { GlobalContext } from '../Util/GlobalContext'
import './TicketPage'
import './ExitEntryPage'
import './ShoppingPage'
// 城市选择器组件
import { CityPicker } from '../components/CityPicker'

/**
 * 路由入口Builder包装函数
 * 供全局路由框架调用，渲染首页组件
 */
@Builder
export function HomePageBuilder() {
  HomePage()
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
        if (item.name === 'More') {
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

/**
 * 第三网格【精选主题推荐区域】
 */
@Builder
function ThirdGridBuilder(items: ItemData[]) {
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

/**
 * 板块标题公共Builder，复用标题样式
 */
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

/**
 * 智慧首页主页面组件
 */
@Component
export struct HomePage {
  // 接收外部Navigation传入的导航栈
  @Prop homePageStack: NavPathStack
  // 全局持久化顶部状态栏高度，沉浸式布局适配
  @StorageLink('topRectHeight') topRectHeight: number = 0
  // 当前城市状态
  @State currentCity: string = '城市'
  // 城市选择器显示状态
  @State isCityPickerShow: boolean = false

  showCityPicker(): void {
    this.isCityPickerShow = true
  }

  onCitySelect(city: string): void {
    this.currentCity = city
    this.isCityPickerShow = false
    promptAction.showToast({ message: `已选择：${city}` })
  }

  @Builder
  FirstGridBuilder(items: ItemData[]) {
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
              scanBarcode.startScanForResult(getContext(this), options).then(() => {
                hilog.info(0x0001, '[Scan CPSample]', 'Scan completed successfully');
                promptAction.showToast({ message: '扫码成功' })
              }).catch((error: BusinessError) => {
                hilog.error(0x0001, '[Scan CPSample]',
                  `Failed to get ScanResult by promise with options. Code:${error.code}, message: ${error.message}`);
                promptAction.showToast({ message: '扫码已取消或失败' })
              });
              break;
            case 'Code':
              if (!canIUse('SystemCapability.Multimedia.Scan.GenerateBarcode')) {
                GlobalContext.getContext().deleteObject('px')
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
                promptAction.showToast({ message: '当前设备不支持动态生成，已显示演示身份码' })
                break
              }
              UtilTools.getIns().creatQR().then((px: image.PixelMap | undefined) => {
                if (!px) {
                  GlobalContext.getContext().deleteObject('px')
                  buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
                  promptAction.showToast({ message: '动态身份码生成失败，已显示演示身份码' })
                  return
                }
                GlobalContext.getContext().setObject('px', px)
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
              }).catch((error: BusinessError) => {
                hilog.error(0x0001, '[QRCode]',
                  `Failed to create QR code. Code:${error.code}, message:${error.message}`)
                GlobalContext.getContext().deleteObject('px')
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
                promptAction.showToast({ message: '动态身份码生成失败，已显示演示身份码' })
              })
              break
            case 'Credentials':
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HOMEPAGE + '_' + item.name)
              break
            case 'customer':
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

  build() {
    Stack() {
      Navigation(this.homePageStack) {
        Scroll() {
          Column() {
            // 顶部区域：定位搜索 + 智慧识别入口网格
            Column() {
              Row() {
                Row() {
                  Image($r('app.media.ic_public_gps'))
                    .width(px2vp(24 * 3.5))
                    .height(px2vp(24 * 3.5))
                  Text(this.currentCity)
                    .fontSize(px2vp(18 * 3.5))
                    .fontColor(Color.White)
                    .margin({ left: px2vp(2.11 * 3.5)})
                  Image($r('app.media.ic_public_arrow_right'))
                    .width(px2vp(16 * 3.5))
                    .height(px2vp(16 * 3.5))
                    .margin({ left: px2vp(4 * 3.5)})
                }
                .margin({ left: px2vp(16 * 3.5)})
                .onClick(() => {
                  this.showCityPicker()
                })
                .width(px2vp(100 * 3.5))

                Search({ placeholder: '搜索...' })
                  .placeholderColor(Color.White)
                  .searchIcon({ src: $r('app.media.ic_public_input_search') })
                  .width(px2vp(248 * 3.5))
                  .height(px2vp(40 * 3.5))
                  .margin({ left: px2vp(14 * 3.5)})
              }
              .margin({ top: this.topRectHeight})

              Row() {
                this.FirstGridBuilder(mainViewModel.getFirstGridData())
              }
            }

            // 下方白色区域：灵活办公、精选主题板块
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
          }
        }
        .height(CommonConstants.FULL_PARENT)
        .scrollBar(BarState.Off)
      }
      .hideTitleBar(true)
      .backgroundImage($r('app.media.background'))
      .backgroundImageSize(ImageSize.Contain)

      CityPicker({
        isShow: $isCityPickerShow,
        onSelect: (city: string) => {
          this.onCitySelect(city)
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}

// ===========路由自动注册===========
const builderName = BuilderNameConstants.HOMEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(HomePageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
