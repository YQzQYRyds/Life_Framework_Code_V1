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

interface CityData {
  name: string;
  pinyin: string;
}

interface GroupedCity {
  letter: string;
  cities: CityData[];
}

const hotCities: CityData[] = [
  { name: '北京', pinyin: 'beijing' },
  { name: '上海', pinyin: 'shanghai' },
  { name: '广州', pinyin: 'guangzhou' },
  { name: '深圳', pinyin: 'shenzhen' },
  { name: '杭州', pinyin: 'hangzhou' },
  { name: '成都', pinyin: 'chengdu' },
  { name: '武汉', pinyin: 'wuhan' },
  { name: '南京', pinyin: 'nanjing' },
  { name: '西安', pinyin: 'xian' },
  { name: '重庆', pinyin: 'chongqing' },
  { name: '天津', pinyin: 'tianjin' },
  { name: '苏州', pinyin: 'suzhou' },
  { name: '郑州', pinyin: 'zhengzhou' },
  { name: '长沙', pinyin: 'changsha' },
  { name: '青岛', pinyin: 'qingdao' },
  { name: '宁波', pinyin: 'ningbo' },
  { name: '东莞', pinyin: 'dongguan' },
  { name: '厦门', pinyin: 'xiamen' },
  { name: '合肥', pinyin: 'hefei' },
  { name: '佛山', pinyin: 'foshan' }
];

const allCities: CityData[] = [
  { name: '北京', pinyin: 'beijing' },
  { name: '上海', pinyin: 'shanghai' },
  { name: '广州', pinyin: 'guangzhou' },
  { name: '深圳', pinyin: 'shenzhen' },
  { name: '杭州', pinyin: 'hangzhou' },
  { name: '成都', pinyin: 'chengdu' },
  { name: '武汉', pinyin: 'wuhan' },
  { name: '南京', pinyin: 'nanjing' },
  { name: '西安', pinyin: 'xian' },
  { name: '重庆', pinyin: 'chongqing' },
  { name: '天津', pinyin: 'tianjin' },
  { name: '苏州', pinyin: 'suzhou' },
  { name: '郑州', pinyin: 'zhengzhou' },
  { name: '长沙', pinyin: 'changsha' },
  { name: '青岛', pinyin: 'qingdao' },
  { name: '宁波', pinyin: 'ningbo' },
  { name: '东莞', pinyin: 'dongguan' },
  { name: '厦门', pinyin: 'xiamen' },
  { name: '合肥', pinyin: 'hefei' },
  { name: '福州', pinyin: 'fuzhou' },
  { name: '无锡', pinyin: 'wuxi' },
  { name: '济南', pinyin: 'jinan' },
  { name: '沈阳', pinyin: 'shenyang' },
  { name: '大连', pinyin: 'dalian' },
  { name: '昆明', pinyin: 'kunming' },
  { name: '南宁', pinyin: 'nanning' },
  { name: '哈尔滨', pinyin: 'haerbin' },
  { name: '长春', pinyin: 'changchun' },
  { name: '石家庄', pinyin: 'shijiazhuang' },
  { name: '南昌', pinyin: 'nanchang' },
  { name: '海口', pinyin: 'haikou' },
  { name: '三亚', pinyin: 'sanya' },
  { name: '银川', pinyin: 'yinchuan' },
  { name: '西宁', pinyin: 'xining' },
  { name: '乌鲁木齐', pinyin: 'wulumuqi' },
  { name: '太原', pinyin: 'taiyuan' },
  { name: '呼和浩特', pinyin: 'huhehaote' },
  { name: '兰州', pinyin: 'lanzhou' },
  { name: '贵阳', pinyin: 'guiyang' },
  { name: '拉萨', pinyin: 'lasa' },
  { name: '温州', pinyin: 'wenzhou' },
  { name: '绍兴', pinyin: 'shaoxing' },
  { name: '嘉兴', pinyin: 'jiaxing' },
  { name: '金华', pinyin: 'jinhua' },
  { name: '台州', pinyin: 'taizhou' },
  { name: '徐州', pinyin: 'xuzhou' },
  { name: '南通', pinyin: 'nantong' },
  { name: '扬州', pinyin: 'yangzhou' },
  { name: '惠州', pinyin: 'huizhou' },
  { name: '中山', pinyin: 'zhongshan' },
  { name: '珠海', pinyin: 'zhuhai' },
  { name: '桂林', pinyin: 'guilin' },
  { name: '柳州', pinyin: 'liuzhou' },
  { name: '烟台', pinyin: 'yantai' },
  { name: '潍坊', pinyin: 'weifang' },
  { name: '淄博', pinyin: 'zibo' },
  { name: '临沂', pinyin: 'linyi' },
  { name: '鞍山', pinyin: 'anshan' },
  { name: '抚顺', pinyin: 'fushun' },
  { name: '吉林', pinyin: 'jilin' },
  { name: '四平', pinyin: 'siping' },
  { name: '齐齐哈尔', pinyin: 'qiqihar' },
  { name: '牡丹江', pinyin: 'mudanjiang' },
  { name: '佳木斯', pinyin: 'jiamusi' },
  { name: '大庆', pinyin: 'daqing' },
  { name: '香港', pinyin: 'xianggang' },
  { name: '澳门', pinyin: 'aomen' }
];

const letters: string[] = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'];

function getPinyinFirstLetter(pinyin: string): string {
  if (!pinyin || pinyin.length === 0) {
    return '#';
  }
  let firstChar = pinyin.charAt(0).toUpperCase();
  if (letters.includes(firstChar)) {
    return firstChar;
  }
  return '#';
}

function groupCities(cities: CityData[]): GroupedCity[] {
  let groups: Record<string, CityData[]> = {};
  letters.forEach(letter => {
    groups[letter] = [];
  });
  groups['#'] = [];

  cities.forEach(city => {
    let letter = getPinyinFirstLetter(city.pinyin);
    if (groups[letter]) {
      groups[letter].push(city);
    }
  });

  let result: GroupedCity[] = [];
  groups['#'].sort((a, b) => a.name.localeCompare(b.name, 'zh-CN'));
  if (groups['#'].length > 0) {
    result.push({ letter: '#', cities: groups['#'] });
  }

  letters.forEach(letter => {
    groups[letter].sort((a, b) => a.name.localeCompare(b.name, 'zh-CN'));
    if (groups[letter].length > 0) {
      result.push({ letter: letter, cities: groups[letter] });
    }
  });

  return result;
}

@Component
export struct CityPicker {
  @Link isShow: boolean;
  @State searchText: string = '';
  onSelect: (city: string) => void = () => {};

  private getFilteredCities(): CityData[] {
    const keyword: string = this.searchText.trim().toLowerCase();
    if (keyword.length === 0) {
      return allCities;
    }
    return allCities.filter((city: CityData) => {
      return city.name.includes(keyword) || city.pinyin.includes(keyword);
    });
  }

  build() {
    if (this.isShow) {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
          .onClick(() => {
            this.isShow = false;
          })

        Column() {
          Column() {
            Row() {
              Text('选择城市')
                .fontSize('20fp')
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              Blank()
              Text('×')
                .fontSize('28fp')
                .fontColor('#999999')
                .width('40vp')
                .height('40vp')
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.isShow = false;
                })
            }
            .padding({ left: '20vp', right: '20vp', top: '16vp', bottom: '16vp' })
            .width('100%')

            Search({ value: this.searchText, placeholder: '搜索城市' })
              .width('100%')
              .height('48vp')
              .margin({ left: '16vp', right: '16vp', bottom: '16vp' })
              .onChange((value: string) => {
                this.searchText = value;
              })
          }
          .backgroundColor(Color.White)

          Scroll() {
            Column() {
              if (this.searchText.length === 0) {
                Column() {
                  Text('热门城市')
                    .fontSize('16fp')
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#333333')
                    .width('100%')
                    .padding({ left: '20vp', top: '20vp', bottom: '12vp' })

                  Flex({ wrap: FlexWrap.Wrap }) {
                    ForEach(hotCities, (city: CityData) => {
                      Text(city.name)
                        .fontSize('14fp')
                        .fontColor('#666666')
                        .padding({ left: '20vp', right: '20vp', top: '8vp', bottom: '8vp' })
                        .backgroundColor('#f5f5f5')
                        .borderRadius('20vp')
                        .margin({ right: '12vp', bottom: '12vp' })
                        .onClick(() => {
                          this.onSelect(city.name);
                          this.isShow = false;
                        })
                    }, (city: CityData) => city.name)
                  }
                  .padding({ left: '20vp' })
                }
                .margin({ bottom: '20vp' })
              }

              ForEach(groupCities(this.getFilteredCities()), (group: GroupedCity) => {
                Column() {
                  Text(group.letter)
                    .fontSize('14fp')
                    .fontColor('#999999')
                    .width('100%')
                    .padding({ left: '20vp', top: '12vp', bottom: '8vp' })
                    .backgroundColor('#f9f9f9')

                  Column() {
                    ForEach(group.cities, (city: CityData) => {
                      Column() {
                        Text(city.name)
                          .fontSize('16fp')
                          .fontColor('#333333')
                          .width('100%')
                          .padding({ left: '20vp', top: '16vp', bottom: '16vp' })
                        Divider()
                          .strokeWidth('1vp')
                          .color('#eeeeee')
                      }
                      .onClick(() => {
                        this.onSelect(city.name);
                        this.isShow = false;
                      })
                    }, (city: CityData) => city.name)
                  }
                }
              }, (group: GroupedCity) => group.letter)

              if (this.getFilteredCities().length === 0) {
                Text('未找到匹配的城市')
                  .fontSize('15fp')
                  .fontColor('#999999')
                  .width('100%')
                  .textAlign(TextAlign.Center)
                  .padding({ top: '48vp', bottom: '48vp' })
              }
            }
          }
          .flexGrow(1)
          .backgroundColor(Color.White)
        }
        .width('100%')
        .height('80%')
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: '24vp', topRight: '24vp' })
        .alignSelf(ItemAlign.End)
      }
      .width('100%')
      .height('100%')
    }
  }
}
