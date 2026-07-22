import { promptAction } from "@kit.ArkUI"
import { RouteParams } from "./MessagePage"

// LiveDetailPage.ets
@Component
export struct LiveDetailPage {
  @Prop params: RouteParams
  @State isPlaying: boolean = false
  @State likes: number = 0

  build() {
    Column() {
      Text('直播详情')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 模拟视频区域
      Column() {
        Text('📺')
          .fontSize(60)
        Text('直播画面')
          .fontSize(14)
          .fontColor('#666')
          .margin({ top: 8 })
      }
      .width('90%')
      .height(200)
      .backgroundColor('#333')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)

      // 信息区域
      Column() {
        Text('发布商业高频场景和分销新品')
          .fontSize(18)
          .fontWeight(500)
          .width('100%')
          .margin({ bottom: 8 })

        Row() {
          Text(`❤️ ${this.likes}`)
            .fontSize(16)
            .margin({ right: 20 })
            .onClick(() => {
              this.likes++
              promptAction.showToast({ message: '点赞+1' })
            })

          Text('💬 评论')
            .fontSize(16)
            .onClick(() => {
              promptAction.showToast({ message: '评论功能' })
            })
        }
        .width('100%')
        .margin({ bottom: 12 })

        Button(this.isPlaying ? '暂停' : '播放')
          .width('100%')
          .height(44)
          .backgroundColor(this.isPlaying ? '#FF6B00' : '#007AFF')
          .borderRadius(8)
          .onClick(() => {
            this.isPlaying = !this.isPlaying
            promptAction.showToast({ message: this.isPlaying ? '开始播放' : '已暂停' })
          })
      }
      .width('90%')
      .padding(16)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ top: 16 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Center)
  }
}