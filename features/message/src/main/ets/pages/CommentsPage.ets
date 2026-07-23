import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

@Component
export struct CommentsPage {
  @Prop params: RouteParams
  @State comments: string[] = ['用户1: 服务很好', '用户2: 建议增加更多功能', '用户3: 响应速度很快']
  @State inputComment: string = ''

  build() {
    Column() {
      Text('留言板')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 留言列表
      List() {
        ForEach(this.comments, (item: string) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(14)
                .margin({ left: 16 })
            }
            .height(40)
            .width('100%')
            .borderRadius(8)
            .backgroundColor(Color.White)
            .margin({ bottom: 8 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      // 输入框
      Row() {
        TextInput({ placeholder: '请输入留言' })
          .onChange((value: string) => {
            this.inputComment = value
          })
          .layoutWeight(1)
          .height(40)
          .backgroundColor(Color.White)
          .borderRadius(8)

        Button('发送')
          .height(40)
          .margin({ left: 8 })
          .backgroundColor('#007AFF')
          .borderRadius(8)
          .onClick(() => {
            if (this.inputComment) {
              this.comments.push(`我: ${this.inputComment}`)
              this.inputComment = ''
              promptAction.showToast({ message: '留言成功' })
            }
          })
      }
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}