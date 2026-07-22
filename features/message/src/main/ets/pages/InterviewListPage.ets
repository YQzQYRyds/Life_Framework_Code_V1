import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

// InterviewListPage.ets
@Component
export struct InterviewListPage {
  @Prop params: RouteParams
  @State interviews: string[] = ['企业数字化转型', '人工智能应用', '绿色发展之路']

  build() {
    Column() {
      Text('访谈列表')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      List() {
        ForEach(this.interviews, (item: string) => {
          ListItem() {
            Column() {
              Text(item)
                .fontSize(16)
                .fontWeight(500)
                .width('100%')
                .margin({ bottom: 8 })
              Text('2026-07-22')
                .fontSize(12)
                .fontColor('#999')
                .width('100%')
            }
            .padding(16)
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(8)
            .margin({ bottom: 8 })
            .alignItems(HorizontalAlign.Start)
            .onClick(() => {
              promptAction.showToast({ message: `进入: ${item}` })
            })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}