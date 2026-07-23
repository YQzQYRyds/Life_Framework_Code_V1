
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

export default class RentingHouseData {
  img: Resource
  rentingTag: string     // 整租 / 合租
  roomName: string       // 小区名称
  roomType: string       // 一居室 / 二居室 / 三居室 / 四居室
  size: string           // 面积
  price: string          // 月租(元)d
  decoration: string     // 精装 / 简装 / 毛坯

  constructor(img: Resource, rentingTag: string, roomName: string, roomType: string,
    size: string, price: string, decoration: string) {
    this.img = img
    this.rentingTag = rentingTag
    this.roomName = roomName
    this.roomType = roomType
    this.size = size
    this.price = price
    this.decoration = decoration
  }
}