import { RouteParams } from "./MessagePage"
import { promptAction } from "@kit.ArkUI"

// TravelServicePage.ets
@Component
export struct TravelServicePage {
  @Prop params: RouteParams
  @State cities: SelectOption[] = [
    { value: '北京' },
    { value: '上海' },
    { value: '广州' },
    { value: '深圳' },
    { value: '杭州' },
    { value: '成都' }
  ]
  @State selectedCity: string = '北京'

  build() {
    Column() {
      Text('出行服务')
        .fontSize(20)
        .fontWeight(700)
        .margin({ top: 16, bottom: 16 })

      // 城市选择
      Row() {
        Text('目的地: ')
          .fontSize(16)
          .margin({ right: 8 })
        Select(this.cities)
          .selected(this.cities.findIndex((item: SelectOption) => item.value === this.selectedCity))
          .value(this.selectedCity)
          .width(120)
          .onSelect((index: number) => {
            if (index >= 0 && index < this.cities.length) {
              this.selectedCity = this.cities[index].value as string
            }
          })
      }
      .width('90%')
      .margin({ bottom: 16 })
      .justifyContent(FlexAlign.Start)

      // 行程卡片
      List() {
        ForEach(['航班信息', '酒店预订', '当地交通', '景点推荐'], (item: string) => {
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
                  promptAction.showToast({ message: `查看${item}` })
                })
            }
            .height(50)
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(8)
            .margin({ bottom: 8 })
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