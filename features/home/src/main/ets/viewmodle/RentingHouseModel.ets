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

export class RentingHouseModel {
  getHouseData(): Array<RentingHouseData> {
    let data: RentingHouseData[] = [
      // 整租
      new RentingHouseData($r('app.media.house1'), '整租', '翡翠海岸花园', '三居室', '128平', '5800', '精装'),
      new RentingHouseData($r('app.media.house2'), '整租', '阳光翠庭华府', '二居室', '89平', '3600', '精装'),
      new RentingHouseData($r('app.media.house3'), '整租', '碧海蓝天雅苑', '一居室', '45平', '2200', '简装'),
      new RentingHouseData($r('app.media.house4'), '整租', '金域华庭名邸', '四居室', '156平', '7200', '精装'),
      new RentingHouseData($r('app.media.house5'), '整租', '翠竹新苑小区', '二居室', '76平', '2800', '简装'),
      new RentingHouseData($r('app.media.house1'), '整租', '龙湖春江天玺', '三居室', '115平', '5000', '精装'),
      // 合租
      new RentingHouseData($r('app.media.house2'), '合租', '星河丹堤花园', '三居室', '26平', '1500', '精装'),
      new RentingHouseData($r('app.media.house3'), '合租', '中海锦城名都', '二居室', '20平', '1200', '简装'),
      new RentingHouseData($r('app.media.house4'), '合租', '万科金域蓝湾', '三居室', '30平', '1800', '精装'),
      new RentingHouseData($r('app.media.house5'), '合租', '保利天悦花园', '一居室', '18平', '900', '简装'),
      new RentingHouseData($r('app.media.house1'), '合租', '招商雍景湾', '二居室', '22平', '1100', '精装'),
      new RentingHouseData($r('app.media.house2'), '合租', '华润城润府', '四居室', '35平', '2000', '精装'),
      new RentingHouseData($r('app.media.house3'), '合租', '侨城馨苑公寓', '一居室', '15平', '750', '简装'),
    ];
    return data;
  }
}

export default new RentingHouseModel();