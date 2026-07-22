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
      new ItemData($r('app.string.account'), $r('app.media.ic_contacts_business_cards_filled'), 'account'),
      new ItemData($r('app.string.security'), $r("app.media.ic_public_security_filled"), 'security'),
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
      new ItemData($r('app.string.house'), $r("app.media.apartment_renta")),
      new ItemData($r('app.string.Hos'), $r("app.media.ic_contacts_Medical")),
      new ItemData($r('app.string.Car'), $r("app.media.Vehicle_management_office")),
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
      new ItemData($r('app.string.Social_security'), $r('app.media.My_Social_Security')),
      new ItemData($r('app.string.Card_case'), $r('app.media.My_Card_Case')),
      new ItemData($r('app.string.credit'), $r('app.media.credit_reporting')),
    ];
    return thirdGridData;
  }

  /**
   * Get data of the third grid.
   *
   * @return {Array<PageResource>} secondGridData.
   */
  getFourthGridData(): Array<ItemData> {
    let fourthGridData: ItemData[] = [
      new ItemData($r('app.string.ID_card'), $r('app.media.ic_bpit_id_square_bottom2')),
      new ItemData($r('app.string.driver'), $r("app.media.ic_public_car_square_bottom2")),
      new ItemData($r('app.string.marriage'), $r("app.media.ic_public_heart_square_bottom2")),
    ];
    return fourthGridData;
  }

}

export default new MainViewModel();
