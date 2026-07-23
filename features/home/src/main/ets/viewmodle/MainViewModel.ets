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
      new ItemData($r('app.string.scan'), $r('app.media.scan'), 'scan'),
      new ItemData($r('app.string.code'), $r('app.media.id'), 'Code'),
      new ItemData($r('app.string.credentials'), $r('app.media.cards_filled'), 'Credentials'),
      new ItemData($r('app.string.customer_serive'), $r('app.media.serive'), 'customer'),
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
      new ItemData($r('app.string.Social_security'), $r('app.media.social'), 'SocialSecurity'),
      new ItemData($r('app.string.cheque_sheet'), $r('app.media.sheet'), 'ChequeSheet'),
      new ItemData($r('app.string.residence_permit'), $r('app.media.permit'), 'ResidencePermit'),
      new ItemData($r('app.string.ticket'), $r('app.media.ic_public_notes'), 'ticket'),
      new ItemData($r('app.string.house'), $r('app.media.house'), 'RentingHouse'),
      new ItemData($r('app.string.Exit_Entry'), $r('app.media.exit'), 'ExitEntry'),
      new ItemData($r('app.string.Shopping'), $r('app.media.shop'), 'Shopping'),
      new ItemData($r('app.string.More'), $r('app.media.more'), 'More')
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
