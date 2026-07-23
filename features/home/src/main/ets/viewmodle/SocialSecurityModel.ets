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

import SocialSecurityData, { Category } from './SocialSecurityData';

export class SocialSecurityModel {
  getBillsData(): SocialSecurityData {
    // 真实社保数据模拟
    return new SocialSecurityData(
      '张某某',               // 姓名
      '某某互联网科技公司',    // 公司
      true,                  // 状态（true=正常）
      '320102199001011234',  // 社保卡号
      '广东省深圳市',         // 参保城市
      11000.00,              // 缴费基数
      38540.25,              // 个人账户总余额
      [
        new Category($r('app.media.ic_public_highlight_filled'), '养老保险', 18680.50, 880.00, '单位:16% 个人:8%'),
        new Category($r('app.media.ic_public_highlight_filled'), '医疗保险', 3852.50, 220.00, '单位:8% 个人:2%'),
        new Category($r('app.media.ic_public_highlight_filled'), '失业保险', 160.00, 33.00, '单位:0.7% 个人:0.3%'),
        new Category($r('app.media.ic_public_highlight_filled'), '工伤保险', 0.00, 0.00, '单位:0.2%, 个人不缴'),
        new Category($r('app.media.ic_public_highlight_filled'), '住房公积金', 35000.00, 1320.00, '单位:12% 个人:12%'),
        new Category($r('app.media.ic_public_highlight_filled'), '住房补贴', 6000.00, 264.00, '单位:12%, 用于补充公积金')
      ]
    );
  }
}

export default new SocialSecurityModel();