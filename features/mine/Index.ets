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

import { BuilderNameConstants } from 'RouterModule';

export { MyPage } from './src/main/ets/page/myPage';
export { LoginInfo, LoginManager, LoginMethod } from './src/main/ets/modle/LoginManager';

/**
 * Registers the requested page builder while retaining the original dynamic
 * HAR-loading contract used by RouterModule on the API 13 project baseline.
 */
export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.LoginPage:
      import('./src/main/ets/components/mainpage/loginPage');
      break;
    case BuilderNameConstants.RegisterPage:
      import('./src/main/ets/components/mainpage/RegisteringPage');
      break;
    case BuilderNameConstants.ForgetPassPage:
      import('./src/main/ets/components/mainpage/ForgetPassword');
      break;
    case BuilderNameConstants.SecurityCenterPage:
      import('./src/main/ets/components/mainpage/SecurityCenter');
      break;
    default:
      break;
  }
}
