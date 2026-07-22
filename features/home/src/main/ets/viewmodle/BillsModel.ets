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

import BillsData from './BillsData';

export class BillsModel {
  getBillsData(): Array<BillsData> {
    let getBillsData: BillsData[] = [
      new BillsData($r('app.media.avatar'), '备份套餐', '文化休闲', '01-25 18:12', '-10.00', '自动续费成功'),
      new BillsData($r('app.media.avatar'), '备份套餐', '文化休闲', '01-25 18:12', '-10.00', '自动续费成功'),
      new BillsData($r('app.media.avatar'), '备份套餐', '文化休闲', '01-25 18:12', '-10.00', '自动续费成功'),
      new BillsData($r('app.media.avatar'), '备份套餐', '文化休闲', '01-25 18:12', '-10.00', '自动续费成功'),
      new BillsData($r('app.media.avatar'), '备份套餐', '文化休闲', '01-25 18:12', '-10.00', '自动续费成功'),
    ];
    return getBillsData;
  }
}

export default new BillsModel();