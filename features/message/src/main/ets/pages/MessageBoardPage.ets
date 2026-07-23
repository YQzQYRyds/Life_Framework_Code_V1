import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

// MessageBoardPage.ets
interface GeneratedTypeLiteralInterface_1 {
  name: string;
  content: string;
}

interface GeneratedTypeLiteralInterface_2 {
  name: string;
  content: string;
}

@Component
export struct MessageBoardPage {
  @Prop params: RouteParams
  @State messages: GeneratedTypeLiteralInterface_1[] = [
    { name: '用户A', content: '这个功能很实用' },
    { name: '用户B', content: '希望能有更多选择' }
  ]
  @State inputContent: string = ''

  aboutToAppear() {
    // 检查是否有传递的留言
    if (this.params && this.params.message && this.params.userName) {
      // 添加新留言到列表
      this.messages.push({
        name: this.params.userName,
        content: this.params.message
      })
      // 显示提示
      promptAction.showToast({ message: '留言已发布' })
    }
  }


  build() {
    Column() {
      Text('留言板')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 留言列表
      List() {
        ForEach(this.messages, (item: GeneratedTypeLiteralInterface_2) => {
          ListItem() {
            Column() {
              Text(item.name)
                .fontSize(14)
                .fontWeight(500)
                .width('100%')
              Text(item.content)
                .fontSize(14)
                .fontColor('#666')
                .width('100%')
                .margin({ top: 4 })
            }
            .padding(12)
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(8)
            .margin({ bottom: 8 })
            .alignItems(HorizontalAlign.Start)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      // 输入区域
      Row() {
        TextInput({ placeholder: '写下你的留言...' })
          .onChange((value: string) => {
            this.inputContent = value
          })
          .layoutWeight(1)
          .height(40)
          .backgroundColor(Color.White)
          .borderRadius(8)

        Button('发布')
          .height(40)
          .margin({ left: 8 })
          .backgroundColor('#007AFF')
          .borderRadius(8)
          .onClick(() => {
            if (this.inputContent) {
              this.messages.push({
                name: '我',
                content: this.inputContent
              })
              this.inputContent = ''
              promptAction.showToast({ message: '发布成功' })
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