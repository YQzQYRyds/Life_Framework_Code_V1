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

export default class SocialSecurityData {
  name: string           // 姓名
  company: string        // 所在公司
  status: boolean        // 状态：正常/停用
  idCard: string         // 身份证号码/社保卡号
  city: string           // 参保城市
  baseAmount: number     // 社保缴费基数
  accountBalance: number // 社保个人账户余额
  categories: Array<Category>

  constructor(name: string, company: string, status: boolean, idCard: string, city: string, baseAmount: number, accountBalance: number, categories: Array<Category>) {
    this.name = name
    this.company = company
    this.status = status
    this.idCard = idCard
    this.city = city
    this.baseAmount = baseAmount
    this.accountBalance = accountBalance
    this.categories = categories
  }
}

export class Category {
  icon: Resource        // 图标
  title: string         // 险种名称
  money: number         // 当前余额/账户金额
  subMoney?: number     // 本月个人/单位缴存金额（扩展项）
  desc?: string         // 详细说明（如：单位12%，个人8%）

  constructor(icon: Resource, title: string, money: number, subMoney?: number, desc?: string) {
    this.icon = icon
    this.title = title
    this.money = money
    this.subMoney = subMoney
    this.desc = desc
  }
}