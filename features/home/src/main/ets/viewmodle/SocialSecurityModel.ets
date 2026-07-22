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
    let getSocialSecurityDataData: SocialSecurityData = new SocialSecurityData('某某', 'xxxxxx公司', true, '1321231321',
      [new Category($r('app.media.ic_public_highlight_filled'), '公积金账户', 30000),
        new Category($r('app.media.ic_public_highlight_filled'), '住房补贴', 3000)])
    return getSocialSecurityDataData;
  }
}

export default new SocialSecurityModel();