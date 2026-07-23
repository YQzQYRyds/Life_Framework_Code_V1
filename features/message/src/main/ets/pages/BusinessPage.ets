import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

// BusinessPage.ets
@Component
export struct BusinessPage {
  @Prop params: RouteParams = {}
  @State selectedTab: number = 0
  private tabs: string[] = ['全部', '热门', '最新']

  build() {
    Column() {
      Text('业务')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // Tab切换
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(16)
            .fontWeight(this.selectedTab === index ? 700 : 400)
            .fontColor(this.selectedTab === index ? '#007AFF' : '#666')
            .margin({ left: 20, right: 20 })
            .onClick(() => {
              this.selectedTab = index
            })
        })
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .backgroundColor(Color.White)

      // 业务列表
      List() {
        ForEach(['业务1', '业务2', '业务3', '业务4'], (item: string) => {
          ListItem() {
            Row() {
              Column() {
                Text(item)
                  .fontSize(16)
                  .fontWeight(500)
                Text('2026-07-22')
                  .fontSize(12)
                  .fontColor('#999')
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 16 })
              .layoutWeight(1)

              Text('查看详情')
                .fontSize(14)
                .fontColor('#007AFF')
                .margin({ right: 16 })
                .onClick(() => {
                  promptAction.showToast({ message: `查看${item}详情` })
                })
            }
            .height(60)
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(8)
            .margin({ bottom: 8 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}