import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

// SelfServicePage.ets
@Component
export struct SelfServicePage {
  @Prop params: RouteParams
  @State services: string[] = ['账号管理', '密码重置', '信息修改', '绑定管理']

  build() {
    Column() {
      Text('自助服务')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 服务网格
      Grid() {
        ForEach(this.services, (item: string) => {
          GridItem() {
            Column() {
              Text('📋')
                .fontSize(32)
              Text(item)
                .fontSize(14)
                .margin({ top: 8 })
            }
            .width('100%')
            .height(100)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              promptAction.showToast({ message: `进入${item}` })
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('92%')
      .layoutWeight(1)
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}