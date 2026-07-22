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
import { LoginManager } from '../main/ets/modle/LoginManager';

export default function localUnitTest() {
  describe('LoginManagerValidation', () => {
    it('acceptsOnlyElevenDigitPhone', 0, () => {
      expect(LoginManager.isValidPhone('13800138000')).assertEqual(true);
      expect(LoginManager.isValidPhone('1380013800')).assertEqual(false);
      expect(LoginManager.isValidPhone('1380013800a')).assertEqual(false);
    });

    it('validatesPasswordBoundaryAndCharacters', 0, () => {
      expect(LoginManager.isValidPassword('abc123')).assertEqual(true);
      expect(LoginManager.isValidPassword('abc12')).assertEqual(false);
      expect(LoginManager.isValidPassword('密码123456')).assertEqual(false);
    });

    it('filtersAndMasksSensitiveInput', 0, () => {
      expect(LoginManager.filterDigits('13a8-0013 8000')).assertEqual('13800138000');
      expect(LoginManager.filterPassword('abc密码123')).assertEqual('abc123');
      expect(LoginManager.maskPhone('13800138000')).assertEqual('138****8000');
    });
  });
}
