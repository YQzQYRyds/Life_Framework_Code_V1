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

export default class BillsData {
  img: Resource;
  name: string
  tag: string
  date: string
  price: string
  detail: string

  constructor(img: Resource, name: string, tag: string, date: string, price: string, detail: string) {
    this.img = img;
    this.name = name;
    this.tag = tag;
    this.date = date;
    this.price = price;
    this.detail = detail;
  }
}