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
import { TabBarDataType } from '../main/ets/model/DataType';

export default function localUnitTest() {
  describe('appShellContract', () => {
    it('keepsTabMetadataTogether', 0, () => {
      const tab: TabBarDataType = new TabBarDataType(0, '首页', 'selected', 'default');

      expect(tab.id).assertEqual(0);
      expect(tab.title).assertEqual('首页');
      expect(tab.selectedIcon).assertEqual('selected');
      expect(tab.defaultIcon).assertEqual('default');
    });
  });
}
