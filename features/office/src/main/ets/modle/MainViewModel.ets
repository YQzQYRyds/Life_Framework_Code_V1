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

import ItemData from './ItemData';

/**
 * Binds data to components and provides interfaces.
 */
export class MainViewModel {


  /**
   * Get data of the first grid.
   *
   * @return {Array<PageResource>} firstGridData.
   */
  getFirstGridData(): Array<ItemData> {
    let gridFirstData: ItemData[] = [
      new ItemData($r('app.string.guide'), $r('app.media.spot_light'), 'ServiceCategory'),
      new ItemData($r('app.string.appoint'), $r("app.media.square_and_pencil"), 'WebService'),
      new ItemData($r('app.string.credentials'), $r('app.media.person_text_rectangle_fill'), 'ServiceDetail'),
      new ItemData($r('app.string.progress'), $r('app.media.notice_1'), 'ServiceSearch'),
    ];
    return gridFirstData;
  }

  /**
   * Get data of the first grid.
   *
   * @return {Array<PageResource>} firstGridData.
   */
  getSecondGridData(): Array<ItemData> {
    let secondGridData: ItemData[] = [
      new ItemData($r('app.string.service_social_security'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_fund'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_household'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_entry_exit'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_transport'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_elderly'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_property'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_marriage'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_tax'), $r('app.media.work_serives')),
      new ItemData($r('app.string.service_education'), $r('app.media.work_serives')),
    ];
    return secondGridData;
  }


  /**
   * Get data of the third grid.
   *
   * @return {Array<PageResource>} secondGridData.
   */
  getThirdGridData(): Array<ItemData> {
    let thirdGridData: ItemData[] = [
      new ItemData($r('app.string.mainPage_top'), $r('app.media.chusheng'), 'WebService'),
      new ItemData($r('app.string.mainPage_new'), $r('app.media.ruxue'), 'WebService'),
      new ItemData($r('app.string.mainPage_brand'), $r('app.media.gongzuo'), 'WebService'),
      new ItemData($r('app.string.mainPage_found'), $r('app.media.shenghuo'), 'WebService')
    ];
    return thirdGridData;
  }


}

export default new MainViewModel();
