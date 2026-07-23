/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { BuilderNameConstants, RouterModule } from 'RouterModule'
import { promptAction } from '@kit.ArkUI'

// 城市分组
interface CityGroup {
  letter: string
  cities: string[]
}

// 电影数据
class Movie {
  img: Resource = $r('app.media.liulang')
  name: string = ''
  score: string = ''
  price: string = ''
  desc: string = ''

  constructor(img: Resource, name: string, score: string, price: string, desc: string) {
    this.img = img
    this.name = name
    this.score = score
    this.price = price
    this.desc = desc
  }
}

@Builder
export function TicketBuilder() {
  TicketPage()
}

@Component
struct TicketPage {
  pathStack: NavPathStack = new NavPathStack()
  @StorageLink('topRectHeight') topRectHeight: number = 0
  @State selectedCity: string = ''
  @State showCityPicker: boolean = false
  @State touchedLetter: string = ''
  private scroller: Scroller = new Scroller()
  // 每个字母分组在 List 中的起始 flat index（header=1 + cities）
  private letterStartIndices: number[] = []

  // A–Z 完整城市数据
  private cityGroups: CityGroup[] = [
    { letter: 'A', cities: ['阿克苏', '安阳', '安庆', '安康', '鞍山', '澳门'] },
    { letter: 'B', cities: ['北京', '保定', '包头', '宝鸡', '北海', '蚌埠', '本溪', '滨州', '巴中', '白城', '亳州'] },
    { letter: 'C', cities: ['成都', '重庆', '长沙', '长春', '常州', '滁州', '沧州', '郴州', '潮州', '池州', '赤峰', '承德', '常德', '朝阳', '崇左'] },
    { letter: 'D', cities: ['大连', '东莞', '大庆', '大同', '大理', '丹东', '德州', '德阳', '达州', '东营', '定西', '儋州'] },
    { letter: 'E', cities: ['鄂尔多斯', '恩施', '鄂州'] },
    { letter: 'F', cities: ['福州', '佛山', '抚顺', '阜阳', '抚州', '防城港'] },
    { letter: 'G', cities: ['广州', '贵阳', '桂林', '赣州', '广元', '广安', '贵港', '甘孜', '果洛'] },
    { letter: 'H', cities: ['杭州', '合肥', '哈尔滨', '海口', '呼和浩特', '湖州', '惠州', '邯郸', '衡阳', '淮安', '黄山', '河源', '怀化', '汉中', '菏泽', '黄石', '鹤壁', '淮南', '黄冈', '葫芦岛'] },
    { letter: 'J', cities: ['济南', '嘉兴', '金华', '济宁', '吉林', '荆州', '九江', '锦州', '佳木斯', '焦作', '揭阳', '晋中', '荆门', '景德镇', '酒泉', '济源'] },
    { letter: 'K', cities: ['昆明', '开封', '喀什', '克拉玛依', '库尔勒'] },
    { letter: 'L', cities: ['兰州', '洛阳', '柳州', '拉萨', '丽江', '临汾', '廊坊', '临沂', '连云港', '泸州', '乐山', '六安', '聊城', '龙岩', '辽阳', '丽水', '莱芜', '林芝'] },
    { letter: 'M', cities: ['绵阳', '马鞍山', '茂名', '梅州', '牡丹江', '眉山'] },
    { letter: 'N', cities: ['南京', '南宁', '南昌', '宁波', '南通', '南阳', '宁德', '内江', '南充', '那曲'] },
    { letter: 'P', cities: ['盘锦', '平顶山', '莆田', '萍乡', '普洱', '攀枝花', '濮阳'] },
    { letter: 'Q', cities: ['青岛', '泉州', '秦皇岛', '齐齐哈尔', '清远', '曲靖', '衢州', '庆阳', '黔东南', '黔南', '黔西南'] },
    { letter: 'R', cities: ['日照'] },
    { letter: 'S', cities: ['上海', '深圳', '沈阳', '石家庄', '苏州', '绍兴', '汕头', '三亚', '十堰', '宿迁', '三明', '上饶', '商丘', '随州', '邵阳', '汕尾', '遂宁', '宿州', '三门峡', '韶关', '石河子'] },
    { letter: 'T', cities: ['天津', '太原', '台州', '泰州', '泰安', '唐山', '天水', '铁岭', '通化', '铜陵', '铜川', '天门'] },
    { letter: 'W', cities: ['武汉', '无锡', '温州', '乌鲁木齐', '芜湖', '潍坊', '威海', '渭南', '梧州', '乌兰察布', '武威', '吴忠'] },
    { letter: 'X', cities: ['西安', '厦门', '西宁', '徐州', '襄阳', '湘潭', '咸阳', '新乡', '许昌', '邢台', '孝感', '忻州', '湘西'] },
    { letter: 'Y', cities: ['银川', '烟台', '扬州', '宜昌', '岳阳', '盐城', '宜宾', '运城', '延安', '玉林', '永州', '阳江', '益阳', '玉溪', '雅安', '义乌'] },
    { letter: 'Z', cities: ['郑州', '珠海', '淄博', '遵义', '镇江', '中山', '漳州', '枣庄', '肇庆', '舟山', '自贡', '张家界', '周口', '驻马店', '资阳', '湛江'] }
  ]

  private movies: Movie[] = [
    new Movie($r('app.media.liulang'), '流浪地球3', '9.2', '39.9起', '科幻/冒险 | 172分钟'),
    new Movie($r('app.media.fengshen2'), '封神第二部', '8.8', '35.9起', '神话/史诗 | 148分钟'),
    new Movie($r('app.media.nezha'), '哪吒之魔童闹海', '9.5', '42.9起', '动画/奇幻 | 110分钟'),
    new Movie($r('app.media.rela'), '热辣滚烫2', '8.5', '29.9起', '喜剧/励志 | 132分钟'),
    new Movie($r('app.media.feichi'), '飞驰人生3', '8.0', '33.9起', '喜剧/赛车 | 128分钟'),
    new Movie($r('app.media.xiongchumo'), '熊出没·重启未来', '8.7', '25.9起', '动画/冒险 | 95分钟'),
  ]

  aboutToAppear(): void {
    // 预计算每个字母分组在 flat list 中的起始索引
    let idx = 0
    for (let i = 0; i < this.cityGroups.length; i++) {
      this.letterStartIndices[i] = idx
      // 1 个 header + 该组城市数量
      idx += 1 + this.cityGroups[i].cities.length
    }
  }

  // 跳转到指定字母分组
  jumpToLetter(letter: string): void {
    for (let i = 0; i < this.cityGroups.length; i++) {
      if (this.cityGroups[i].letter === letter) {
        this.scroller.scrollToIndex(this.letterStartIndices[i])
        break
      }
    }
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          // 顶部标题栏
          Row() {
            Image($r('app.media.ic_public_back'))
              .width('24vp')
              .height('24vp')
              .fillColor(Color.White)
              .margin({ left: '16vp' })
              .onClick(() => this.pathStack.pop())

            Text('淘票票')
              .fontSize('20vp')
              .fontWeight(700)
              .fontColor(Color.White)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .margin({ right: '40vp' })
          }
          .width('100%')
          .height('56vp')
          .backgroundColor('#E84026')

          Scroll() {
            Column() {
              // 城市选择区域
              Row() {
                Image($r('app.media.ic_public_gps'))
                  .width('18vp')
                  .height('18vp')
                  .fillColor('#333333')

                Text(this.selectedCity ? this.selectedCity : '请选择城市')
                  .fontSize('16vp')
                  .fontWeight(500)
                  .fontColor(this.selectedCity ? '#333333' : Color.Gray)
                  .margin({ left: '6vp' })

                Image($r('app.media.arrow'))
                  .width('12vp')
                  .height('12vp')
                  .margin({ left: '4vp' })
                  .fillColor('#999999')
              }
              .padding({ left: px2vp(16 * 3.5), right: px2vp(16 * 3.5) })
              .width('100%')
              .height(px2vp(48 * 3.5))
              .backgroundColor(Color.White)
              .onClick(() => { this.showCityPicker = true })

              // 电影列表 — 选了城市才显示
              if (this.selectedCity) {
                // 当前城市热映
                Row() {
                  Text(`${this.selectedCity} · 正在热映`)
                    .fontSize(px2vp(18 * 3.5))
                    .fontWeight(700)
                    .fontColor('#333333')
                }
                .width('100%')
                .padding({ left: px2vp(16 * 3.5), right: px2vp(16 * 3.5) })
                .margin({ top: px2vp(20 * 3.5) })

                ForEach(this.movies, (movie: Movie, index: number) => {
                  Row() {
                    Image(movie.img)
                      .width(px2vp(78 * 3.5))
                      .height(px2vp(108 * 3.5))
                      .borderRadius(px2vp(8 * 3.5))
                      .objectFit(ImageFit.Cover)

                    Column() {
                      Row() {
                        Text(movie.name)
                          .fontSize(px2vp(17 * 3.5))
                          .fontWeight(600)
                          .fontColor('#333333')
                          .maxLines(1)
                          .layoutWeight(1)

                        Text(movie.score)
                          .fontSize(px2vp(15 * 3.5))
                          .fontWeight(700)
                          .fontColor('#E84026')
                          .margin({ left: '8vp' })
                      }
                      .width('100%')

                      Text(movie.desc)
                        .fontSize(px2vp(12 * 3.5))
                        .fontColor(Color.Gray)
                        .margin({ top: px2vp(4 * 3.5) })
                        .width('100%')

                      Row() {
                        Text(movie.price)
                          .fontSize(px2vp(16 * 3.5))
                          .fontWeight(700)
                          .fontColor('#E84026')
                          .layoutWeight(1)

                        Button('购票')
                          .fontSize(px2vp(13 * 3.5))
                          .fontColor(Color.White)
                          .backgroundColor('#E84026')
                          .borderRadius(px2vp(14 * 3.5))
                          .height(px2vp(28 * 3.5))
                          .width(px2vp(60 * 3.5))
                          .onClick(() => {
                            promptAction.showToast({ message: `已选择《${movie.name}》，请前往影院选座` })
                          })
                      }
                      .width('100%')
                      .margin({ top: px2vp(8 * 3.5) })
                    }
                    .alignItems(HorizontalAlign.Start)
                    .margin({ left: px2vp(16 * 3.5) })
                    .layoutWeight(1)
                  }
                  .width('100%')
                  .padding({ top: px2vp(16 * 3.5), bottom: px2vp(16 * 3.5), left: px2vp(16 * 3.5), right: px2vp(16 * 3.5) })
                  .border({
                    width: { bottom: index < this.movies.length - 1 ? 1 : 0 },
                    color: '#F0F0F0',
                    style: BorderStyle.Solid
                  })
                })
              } else {
                // 未选城市提示
                Column() {
                  Image($r('app.media.ic_public_gps'))
                    .width(px2vp(60 * 3.5))
                    .height(px2vp(60 * 3.5))
                    .fillColor('#CCCCCC')
                    .margin({ top: px2vp(60 * 3.5) })

                  Text('请先选择城市')
                    .fontSize(px2vp(16 * 3.5))
                    .fontColor(Color.Gray)
                    .margin({ top: px2vp(16 * 3.5) })

                  Text('选择城市后将为您展示当地热映影片')
                    .fontSize(px2vp(13 * 3.5))
                    .fontColor('#BBBBBB')
                    .margin({ top: px2vp(8 * 3.5) })
                }
                .width('100%')
              }
            }
            .width('100%')
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)
          .backgroundColor('#F5F5F5')
        }
        .width('100%')
        .height('100%')

        // ============= 城市选择浮层 =============
        if (this.showCityPicker) {
          Column() {
            // 头部：标题 + 关闭
            Row() {
              Text('城市选择')
                .fontSize('18vp')
                .fontWeight(700)
                .fontColor('#333333')
                .layoutWeight(1)

              Text('✕')
                .fontSize('20vp')
                .fontColor('#999999')
                .padding('8vp')
                .onClick(() => { this.showCityPicker = false })
            }
            .width('100%')
            .height('48vp')
            .padding({ left: '16vp', right: '12vp' })
            .backgroundColor(Color.White)

            // 主体：List + 右侧索引
            Stack({ alignContent: Alignment.End }) {
              // 城市 List
              List({ scroller: this.scroller }) {
                ForEach(this.cityGroups, (group: CityGroup) => {
                  ListItem() {
                    Text(group.letter)
                      .fontSize('14vp')
                      .fontWeight(600)
                      .fontColor('#666666')
                      .width('100%')
                      .height('32vp')
                      .padding({ left: '16vp' })
                      .backgroundColor('#F5F5F5')
                  }

                  ForEach(group.cities, (city: string) => {
                    ListItem() {
                      Row() {
                        Text(city)
                          .fontSize('16vp')
                          .fontColor('#333333')
                          .layoutWeight(1)

                        if (this.selectedCity === city) {
                          Text('✓')
                            .fontSize('16vp')
                            .fontColor('#E84026')
                            .margin({ right: '16vp' })
                        }
                      }
                      .width('100%')
                      .height('48vp')
                      .padding({ left: '16vp' })
                      .backgroundColor(Color.White)
                    }
                    .onClick(() => {
                      this.selectedCity = city
                      this.showCityPicker = false
                    })
                  })
                })
              }
              .width('100%')
              .layoutWeight(1)
              .divider({
                strokeWidth: 0.5,
                color: '#F0F0F0',
                startMargin: '16vp',
                endMargin: '16vp'
              })
              .scrollBar(BarState.Off)

              // 右侧字母索引导航
              Column() {
                ForEach(this.cityGroups, (group: CityGroup) => {
                  Text(group.letter)
                    .fontSize('10vp')
                    .fontColor(this.touchedLetter === group.letter ? '#E84026' : '#666666')
                    .fontWeight(this.touchedLetter === group.letter ? 700 : 400)
                    .width('22vp')
                    .height('18vp')
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      this.jumpToLetter(group.letter)
                    })
                })
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .padding({ top: '6vp', bottom: '6vp', right: '2vp' })
              .backgroundColor(Color.White)
              .borderRadius('10vp')
              .margin({ right: '6vp' })
              .shadow({
                radius: 4,
                color: 0x15000000,
                offsetY: 1
              })
              .onTouch((event: TouchEvent) => {
                // 触摸坐标相对于 Column 组件
                let touchY = event.touches[0].y
                let columnHeight = event.target.area.height as number
                if (columnHeight > 0) {
                  let ratio = touchY / columnHeight
                  let idx = Math.floor(ratio * this.cityGroups.length)
                  if (idx < 0) { idx = 0 }
                  if (idx >= this.cityGroups.length) { idx = this.cityGroups.length - 1 }

                  if (event.type === TouchType.Down || event.type === TouchType.Move) {
                    if (this.touchedLetter !== this.cityGroups[idx].letter) {
                      this.touchedLetter = this.cityGroups[idx].letter
                      this.jumpToLetter(this.cityGroups[idx].letter)
                    }
                  } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
                    this.touchedLetter = ''
                  }
                }
              })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .height('85%')
          .backgroundColor(Color.White)
          .borderRadius({ topLeft: '12vp', topRight: '12vp' })
          .transition(TransitionEffect.OPACITY.animation({ duration: 250, curve: Curve.EaseOut }))
        }
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .padding({ top: this.topRectHeight })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

const builderName = BuilderNameConstants.HOMEPAGE + '_ticket'
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(TicketBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
