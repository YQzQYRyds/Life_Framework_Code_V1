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

import RentingHouseData from './RentingHouseData';

export class BillsModel {
  getHouseData(): Array<RentingHouseData> {
    let getHouseData: RentingHouseData[] = [
      new RentingHouseData($r('app.media.house1'), '整租', '大别野', '三居室', '140平', '3200'),
      new RentingHouseData($r('app.media.house2'), '整租', '大别野', '三居室', '140平', '3200'),
      new RentingHouseData($r('app.media.house3'), '整租', '大别野', '三居室', '140平', '3200'),
      new RentingHouseData($r('app.media.house4'), '整租', '大别野', '三居室', '140平', '3200'),
      new RentingHouseData($r('app.media.house5'), '整租', '大别野', '三居室', '140平', '3200'),
    ];
    return getHouseData;
  }
}

export default new BillsModel();