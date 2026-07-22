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
import { AppError, PageStatus } from '../../Index';

export default function localUnitTest() {
  describe('commonContract', () => {
    it('createsRetryableAppError', 0, () => {
      const error: AppError = new AppError('NETWORK_TIMEOUT', '请求超时', true);

      expect(error.code).assertEqual('NETWORK_TIMEOUT');
      expect(error.message).assertEqual('请求超时');
      expect(error.retryable).assertEqual(true);
    });

    it('keepsPageStateValuesStable', 0, () => {
      expect(PageStatus.IDLE).assertEqual(0);
      expect(PageStatus.LOADING).assertEqual(1);
      expect(PageStatus.SUCCESS).assertEqual(2);
      expect(PageStatus.EMPTY).assertEqual(3);
      expect(PageStatus.ERROR).assertEqual(4);
    });
  });
}
