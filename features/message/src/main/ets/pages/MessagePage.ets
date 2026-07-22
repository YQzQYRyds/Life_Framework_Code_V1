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

import { promptAction } from '@kit.ArkUI'

@Extend(Row)
function onRowExtendClick() {
  .onClick(() => {
    promptAction.showToast({
      message: '功能还在开发中'
    })
  })
}

@Extend(Column)
function onColumnExtendClick() {
  .onClick(() => {
    promptAction.showToast({
      message: '功能还在开发中'
    })
  })
}

@Extend(Text)
function onTextExtendClick() {
  .onClick(() => {
    promptAction.showToast({
      message: '功能还在开发中'
    })
  })
}

@Component
export struct MessagePage {
  @State isRefreshing: boolean = false

  build() {
    Refresh({
      refreshing: $$this.isRefreshing
    }) {
      Column() {
        List() {
          this.mailBox();
          this.hotLine();
          this.service();
          this.interviewOnline();
        }
        .alignListItem(ListItemAlign.Center)
        .height('98%')
      }
      .height('100%')
      .backgroundImage($r('app.media.background_green'))
      .backgroundImageSize({ width: px2vp(360 * 3.5), height: px2vp(780 * 3.5) })
    }
    .onRefreshing(() => {
      setTimeout(() => {
        this.isRefreshing = false
      }, 2000)
    })
  }

  mailBoxSwiperCtr: SwiperController = new SwiperController();

  /*
   * 顶部滚动寄信箱
   * */
  @Builder
  mailBox() {
    Row() {
      Row() {
        Image($r('app.media.drive'))
          .width(px2vp(24 * 3.5))
          .height(px2vp(26 * 3.5))
          .margin({left:px2vp(27 * 3.5)})
        Text($r('app.string.shiweiBox'))
          .fontSize(px2vp(12 * 3.5))
          .fontWeight(500)
          .margin({left:px2vp(8 * 3.5)})
      }
      .onRowExtendClick()
      .backgroundColor(Color.White)
      .borderRadius(10)
      .height(px2vp(48 * 3.5))
      .width(px2vp(158 * 3.5))

      Row() {
        Image($r('app.media.comments'))
          .width(px2vp(24 * 3.5))
          .height(px2vp(27* 3.5))
          .margin({left:px2vp(27 * 3.5)})
        Text($r('app.string.shiweiBox'))
          .fontSize(px2vp(12 * 3.5))
          .fontWeight(500)
          .margin({left:px2vp(8 * 3.5)})
      }
      .onRowExtendClick()
      .backgroundColor(Color.White)
      .borderRadius(10)
      .height(px2vp(48 * 3.5))
      .width(px2vp(158 * 3.5))
      .margin({left:px2vp(12 * 3.5)})
    }
    .justifyContent(FlexAlign.SpaceAround)
    .margin({ top: px2vp(262 * 3.5) })
  }

  hotLineItemIcon: Array<Resource> =
    [$r('app.media.download'), $r('app.media.brightness'), $r('app.media.camera'),
      $r('app.media.more')]
  hotLineTitles: Array<string> = ['诉求提交', '金点子', '业务', '更多']

  /*
   * 热线专区
   * */
  @Builder
  hotLine() {
    ListItem() {
      Flex() {
        Column() {
          Text('12345专区')
            .width('100%')
            .fontSize(px2vp(18 * 3.5))
            .margin({ top: '20vp', left: '13vp' })
            .fontWeight(700)
          Blank(5)
          Grid() {
            ForEach([0, 1, 2, 3], (index: number) => {
              GridItem() {
                this.hotLineItem(this.hotLineItemIcon[index], this.hotLineTitles[index])
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .columnsGap('8vp')
          .rowsGap('12vp')
          .height('70vp')
          .padding({ top: '12vp', bottom: '12vp' })
        }
      }
      .padding({ left: '13vp'})
    }

  }

  @Builder
  hotLineItem(imageUrl: string | Resource, title: string) {
    Column() {
      Image(imageUrl)
        .width(px2vp(24 * 3.5))
        .height(px2vp(24 * 3.5))
      Text(title)
        .fontSize(px2vp(12 * 3.5))
        .fontWeight(400)
        .margin({ top: '5vp' })
    }
    .onColumnExtendClick()
  }

  @Builder
  service(){
    Row() {
      Column() {
        Image($r('app.media.fig1'))
          .width(px2vp(165 * 3.5))
          .height(px2vp(105 * 3.5))
          .borderRadius(px2vp(14 * 3.5))
          .margin({ top: px2vp(10 * 3.5) })
        Text('自助服务')
          .fontSize(px2vp(14 * 3.5))
          .fontWeight(400)
          .margin({ top: px2vp(10 * 3.5) })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({right:px2vp(10 * 3.5)})
      Column() {
        Image($r('app.media.fig2'))
          .width(px2vp(165 * 3.5))
          .height(px2vp(105 * 3.5))
          .borderRadius(px2vp(14 * 3.5))
          .margin({ top: px2vp(10 * 3.5) })
        Text('出行服务')
          .fontSize(px2vp(14 * 3.5))
          .fontWeight(400)
          .margin({ top: px2vp(10 * 3.5) })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .margin({bottom:px2vp(15* 3.5)})
  }

  /**
   * 在线访谈
   */
  @Builder
  interviewOnline() {
    ListItem() {
      Flex() {
        Column() {
          Row() {
            Text('在线访谈')
              .fontSize(px2vp(18 * 3.5))
              .margin({ left: '13vp' })
              .fontWeight(700)
            Row(){
              Text('更多')
                .fontSize(px2vp(14 * 3.5))
                .fontWeight(400)
                .opacity(0.6)
                .onTextExtendClick()
                .margin({ right: '8vp' })
              Image($r('app.media.arrow'))
                .width(px2vp(6 * 3.5))
                .height(px2vp(12 * 3.5))
                .margin({left:'6vp',right:'20vp'})
            }
          }.justifyContent(FlexAlign.SpaceBetween).width('100%')

          Row() {
            Image($r('app.media.interview'))
              .width(px2vp(110* 3.5))
              .height(px2vp(65 * 3.5))
              .borderRadius(10)
              .padding({left:px2vp(8 * 3.5)})
            Column() {
              Text('直播｜发布商业高频场景和分销新品，对合作伙伴表彰颁奖')
                .fontSize(px2vp(16* 3.5))
                .fontWeight(400)
            }
            .width(px2vp(166 * 3.5))
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .margin({ left: '10vp', right: '10vp' })
          }
          .width(px2vp(308 * 3.5))
          .height(px2vp(80 * 3.5))
          .margin({ top: '12vp',right:'18vp'})
          .backgroundColor(Color.White)
          .borderRadius(px2vp(8 * 3.5))
        }
        .width('100%')
      }.width('100%')
    }
  }
}
