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

import { describe, it, expect } from '@ohos/hypium';
import { RouterModel } from '../main/ets/model/RouterModel';
import { RouterModule } from '../main/ets/utils/RouterModule';

export default function localUnitTest() {
  describe('routerContract', () => {
    it('extractsHarNameFromBuilderName', 0, () => {
      expect(RouterModule.getHarName('@ohos/home_ChequeSheet')).assertEqual('@ohos/home');
      expect(RouterModule.getHarName('network_webPage')).assertEqual('network');
    });

    it('rejectsInvalidBuilderName', 0, () => {
      expect(RouterModule.getHarName('MissingSeparator')).assertEqual('');
      expect(RouterModule.getHarName('_MissingModule')).assertEqual('');
    });

    it('createsCompatibleRouterModel', 0, () => {
      const model: RouterModel = new RouterModel('EntryHap_Router', '@ohos/mine_LoginPage');

      expect(model.routerName).assertEqual('EntryHap_Router');
      expect(model.builderName).assertEqual('@ohos/mine_LoginPage');
    });
  });
}
