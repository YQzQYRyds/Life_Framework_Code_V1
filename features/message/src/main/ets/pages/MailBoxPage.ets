import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

// MailBoxPage.ets
@Component
export struct MailBoxPage {
  @Prop params: RouteParams
  @State inputValue: string = ''
  @State mailList: string[] = ['信访件1', '信访件2', '信访件3']

  build() {
    Column() {
      Text('寄信箱')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 搜索框
      TextInput({ placeholder: '搜索信件' })
        .onChange((value: string) => {
          this.inputValue = value
        })
        .margin({ left: 16, right: 16 })

      // 信件列表
      List() {
        ForEach(this.mailList, (item: string) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(16)
                .margin({ left: 16 })
              Blank()
              Text('查看')
                .fontSize(14)
                .fontColor('#007AFF')
                .margin({ right: 16 })
                .onClick(() => {
                  promptAction.showToast({ message: `查看: ${item}` })
                })
            }
            .height(50)
            .width('100%')
          }
        })
      }
      .width('100%')
      .layoutWeight(1)

      // 新建按钮
      Button('新建信件')
        .width('90%')
        .height(44)
        .backgroundColor('#007AFF')
        .borderRadius(8)
        .margin({ bottom: 16 })
        .onClick(() => {
          promptAction.showDialog({
            title: '新建信件',
            message: '请输入信件标题',
            buttons: [
              { text: '取消', color: '#999' },
              { text: '确定', color: '#007AFF' }
            ]
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}