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

import { BuilderNameConstants } from 'RouterModule/Index';

// 预加载所有办事子页面，注册路由 Builder（import 必须在其他语句前）
import './src/main/ets/page/ServiceCategoryPage'
import './src/main/ets/page/ServiceSearchPage'
import './src/main/ets/page/ServiceDetailPage'
import './src/main/ets/page/WebServicePage'

export { OfficePage } from './src/main/ets/page/Office'


export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.ServiceCategory:
      import("./src/main/ets/page/ServiceCategoryPage");
      break;
    case BuilderNameConstants.ServiceSearch:
      import("./src/main/ets/page/ServiceSearchPage");
      break;
    case BuilderNameConstants.ServiceDetail:
      import("./src/main/ets/page/ServiceDetailPage");
      break;
    case BuilderNameConstants.WebService:
      import("./src/main/ets/page/WebServicePage");
      break;
    default:
      break;
  }
}
