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


export { HomePage } from './src/main/ets/pages/HomePage'


export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.ChequeSheet:
      import("./src/main/ets/pages/ChequeSheetPage");
      break;
    case BuilderNameConstants.RentingHouse:
      import("./src/main/ets/pages/RentingHousePage");
      break;
    case BuilderNameConstants.ResidencePermit:
      import("./src/main/ets/pages/ResidencePermitPage");
      break;
    case BuilderNameConstants.SocialSecurity:
      import("./src/main/ets/pages/SocialSecurityPage");
      break;
    case BuilderNameConstants.Credentials:
      import("./src/main/ets/pages/CredentialsPage");
      break;
    case BuilderNameConstants.Code:
      import("./src/main/ets/pages/CodePage");
      break;
    default:
      break;
  }
}
