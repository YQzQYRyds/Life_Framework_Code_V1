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

import { TABINFO } from '../model/TabBarData';
import { TabBarDataType } from '../model/DataType';
import { HomePage } from '@ohos/home'
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'RouterModule';
import { OfficePage } from '@ohos/office';
import { MessagePage } from '@ohos/MessagePage/src/main/ets/pages/MessagePage';
import { LoginManager, MyPage } from '@ohos/mine';
import { AppStorageKeys } from 'common';

const HOME_TAB_BAR_INDEX: number = 0; // 初始化社区的tab下标

@Builder
export function TabViewBuilder() {
  NavDestination() {
    TabView();
  }.hideTitleBar(true)
}


@Entry
@Component
export struct TabView {
  @Provide selectedIndex: number = 0; // 初始化被选定的tabBar下标
  @StorageLink('switchToMineTab') @Watch('onSwitchToMineTab') switchToMineTab: boolean = false;
  private pageStack: NavPathStack = new NavPathStack();
  @State iconOffset: number = 0
  private controller: TabsController = new TabsController(); // 初始化Tab控制器
  aboutToAppear(): void {
    if (!this.pageStack) {
      this.pageStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.pageStack);
  }

  onSwitchToMineTab(): void {
    if (this.switchToMineTab) {
      this.selectedIndex = 3;
      AppStorage.setOrCreate(AppStorageKeys.SWITCH_TO_MINE_TAB, false);
    }
  }

  @Builder
  routerMap(builderName: string, param: object) {
    if (RouterModule.hasBuilder(builderName)) {
      RouterModule.getBuilder(builderName).builder(param);
    } else {
      Column({ space: 16 }) {
        Text($r('app.string.route_load_failed'))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        Text(builderName)
          .fontSize(12)
          .fontColor('#666666')
        Button($r('app.string.route_back'))
          .onClick(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
  };

  build() {
    Column() {
      Navigation(this.pageStack) {
        Tabs({ index: this.selectedIndex, barPosition: BarPosition.End, controller: this.controller }) {
          // 首页模块
          TabContent() {
            Column() {
              HomePage({
                homePageStack: this.pageStack
              })
            }
          }

          // 办事模块
          TabContent() {
            Column() {
              OfficePage()
            }
          }

          // 互动模块
          TabContent() {
            MessagePage()
          }

          // 我的模块
          TabContent() {
            MyPage();
          }
        }
        .vertical(false)
        .scrollable(false)
        .layoutWeight(1)
        .barHeight($r('app.integer.custom_tab_common_size_0'))
        .barBackgroundColor('#F1F3F5')
        .onChange((index: number) => {
          if (index != 3) {
            this.selectedIndex = index;
          }
        })

        // 自定义TabBar组件
        CustomTabBar({ selectedIndex: $selectedIndex })
      }
      .hideTitleBar(true)
      .navDestination(this.routerMap)
    }.width($r('app.string.custom_tab_full_size'))
    .height($r('app.string.custom_tab_full_size'))
  }

  @Builder
  customTabbar(tabIndex: number) {
    TabItem({
      iconOffset: this.iconOffset,
      tabBarIndex: tabIndex,
      selectedIndex: $selectedIndex,
    })
  }
}

@Component
struct CustomTabBar {
  @Link selectedIndex: number; // 初始化被选定的tabBar下标
  @State iconOffset: number = 0; // 初始化tabBar图片的偏移量
  @StorageLink('bottomRectHeight') bottomRectHeight: number = 0;

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
      // 数据量比较少的情况下推荐使用ForEach，遇到数据量比较多的场景，如列表场景、瀑布流场景等，推荐使用LazyForEach(https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/quick-start/arkts-rendering-control-lazyforeach.md/)
      ForEach(TABINFO, (item: TabBarDataType, tabIndex: number) => {
        // 单独一个TabBar组件
        TabItem({
          iconOffset: this.iconOffset,
          tabBarIndex: tabIndex,
          selectedIndex: $selectedIndex,
        })
      })
    }
    .padding({ bottom: this.bottomRectHeight })
    .height($r('app.integer.custom_tab_height_size'))
  }
}

/**
 * 场景1：TabBar中间页面如何实现有一圈圆弧外轮廓
 * 场景2：TabBar页签点击之后会改变图标显示，并有一小段动画效果
 * 改变图标显示可以声明一个变量selectedIndex，此变量代表被选定的tabBar下标，点击的时候将当前tabBar的下标值进行赋值。
 * 通过当前被选中的tabBar下标值和tabBar的默认下标值进行判断来达到点击之后改变图标显示的效果。
 * 动画效果可以将Image添加一个offset属性和animation属性，offset属性可以控制组件的横向和纵向偏移量；
 * animation在组件的某些通用属性变化时，可以通过属性动画animation实现过渡效果。
 * 点击TabBar页签，改变offset的属性值，自动触发animation属性动画。
 * animation参考文档:
 * https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/reference/arkui-ts/ts-animatorproperty.md/
 */
@Component
struct TabItem {
  @Prop iconOffset: number; // 初始化tabBar图片的偏移量
  @Prop tabBarIndex: number; // tabBar下标
  @Link selectedIndex: number; // 初始化被选定的tabBar下标

  build() {
    Column() {
      Stack() {
        Column() {
          // 通过被选中的tabBar下标值和tabBar的默认下标值来改变图片显示
          Image(this.selectedIndex === this.tabBarIndex ? TABINFO[this.tabBarIndex].selectedIcon :
          TABINFO[this.tabBarIndex].defaultIcon)// TODO：知识点：使用interpolation属性对图片进行插值，使图片显示得更清晰
            .interpolation(ImageInterpolation.High)
            .size(this.selectedIndex === this.tabBarIndex ?
              { width: $r('app.integer.custom_tab_image_size'), height: $r('app.integer.custom_tab_image_size') } :
              {
                width: $r('app.integer.custom_tab_image_size'),
                height: $r('app.integer.custom_tab_image_size')
              })// TODO：知识点：通过offset控制图片的纵向偏移。
            .offset({
              y: (this.selectedIndex === this.tabBarIndex && this.selectedIndex) ?
              this.iconOffset : $r('app.integer.custom_tab_common_size_0')
            })// TODO：知识点：组件的某些通用属性变化时，可以通过属性动画animation实现过渡效果。本示例的动画效果是tabBar的图片向上偏移一小段距离
            .animation({
              duration: 400,
              curve: Curve.Ease,
              iterations: 1,
              playMode: PlayMode.Normal
            })
        }
        .width(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
        $r('app.integer.custom_tab_community_image_size') : $r('app.integer.custom_tab_image_container_size'))
        .height(this.selectedIndex === HOME_TAB_BAR_INDEX && this.selectedIndex === this.tabBarIndex ?
        $r('app.integer.custom_tab_community_image_size') : $r('app.integer.custom_tab_image_container_size'))
        .justifyContent(FlexAlign.Center)
      }

      Text(TABINFO[this.tabBarIndex].title)
        .fontSize($r('app.integer.custom_tab_text_font_size'))
        .fontWeight(500)
        .fontColor(this.selectedIndex === this.tabBarIndex ? $r('app.color.custom_tab_selected_text_color') :
        Color.Black)
    }
    .width($r('app.integer.custom_tab_height_size'))
    .onClick(() => {
      // 更新被选中的tabBar下标
      if (this.tabBarIndex == 3) {
        if (!LoginManager.isLoggedIn()) {
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LoginPage);
        } else {
          this.selectedIndex = this.tabBarIndex;
        }
      } else {
        this.selectedIndex = this.tabBarIndex;
      }
      // 此处控制tabBar的Image图片向上偏移
      this.iconOffset = -3;
    })
  }
}


