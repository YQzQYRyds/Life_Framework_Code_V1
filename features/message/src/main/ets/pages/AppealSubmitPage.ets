import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

@Component
export struct AppealSubmitPage {
  @Prop params: RouteParams
  @State title: string = ''
  @State content: string = ''
  @State selectedType: string = '投诉'

  private types: SelectOption[] = [
    { value: '投诉' },
    { value: '建议' },
    { value: '咨询' },
    { value: '表扬' }
  ]

  build() {
    Column() {
      Text('诉求提交')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 诉求类型
      Row() {
        Text('诉求类型: ')
          .fontSize(16)
          .width(80)
        Select(this.types)
          .selected(this.types.findIndex((item: SelectOption) => item.value === this.selectedType))
          .value(this.selectedType)
          .width(120)
          .onSelect((index: number) => {
            if (index >= 0 && index < this.types.length) {
              this.selectedType = this.types[index].value as string
            }
          })
      }
      .width('90%')
      .margin({ bottom: 16 })

      // 标题输入
      TextInput({ placeholder: '请输入诉求标题' })
        .onChange((value: string) => {
          this.title = value
        })
        .width('90%')
        .height(40)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .margin({ bottom: 16 })

      // 内容输入
      TextArea({ placeholder: '请详细描述您的诉求' })
        .onChange((value: string) => {
          this.content = value
        })
        .width('90%')
        .height(200)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .margin({ bottom: 16 })
        .maxLength(500)

      // 提交按钮
      Button('提交诉求')
        .width('90%')
        .height(44)
        .backgroundColor('#007AFF')
        .borderRadius(8)
        .onClick(() => {
          if (!this.title || !this.content) {
            promptAction.showToast({ message: '请完整填写信息' })
            return
          }
          promptAction.showToast({ message: '提交成功' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}