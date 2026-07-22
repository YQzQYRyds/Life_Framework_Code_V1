import { RouteParams } from "./MessagePage"
import { promptAction } from "@kit.ArkUI"

@Component
export struct GoldenIdeaPage {
  @Prop params: RouteParams
  @State ideas: string[] = ['智能客服优化', '界面美化建议', '功能模块整合']
  @State newIdea: string = ''

  build() {
    Column() {
      Text('金点子')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 点子列表
      List() {
        ForEach(this.ideas, (item: string) => {
          ListItem() {
            Row() {
              Text('💡')
                .fontSize(20)
                .margin({ right: 8 })
              Text(item)
                .fontSize(16)
                .layoutWeight(1)
              Text('点赞')
                .fontSize(14)
                .fontColor('#007AFF')
                .onClick(() => {
                  promptAction.showToast({ message: '点赞成功' })
                })
            }
            .height(50)
            .width('100%')
            .padding({ left: 16, right: 16 })
            .backgroundColor(Color.White)
            .borderRadius(8)
            .margin({ bottom: 8 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      // 提交点子
      Row() {
        TextInput({ placeholder: '分享你的金点子' })
          .onChange((value: string) => {
            this.newIdea = value
          })
          .layoutWeight(1)
          .height(40)
          .backgroundColor(Color.White)
          .borderRadius(8)

        Button('提交')
          .height(40)
          .margin({ left: 8 })
          .backgroundColor('#FF6B00')
          .borderRadius(8)
          .onClick(() => {
            if (this.newIdea) {
              this.ideas.push(this.newIdea)
              this.newIdea = ''
              promptAction.showToast({ message: '提交成功，感谢分享' })
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