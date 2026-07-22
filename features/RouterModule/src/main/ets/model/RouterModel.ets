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
import { RouterModule } from '../utils/RouterModule';

// Routing information.
export class RouterModel {
  // Route page alias, in the form：${bundleName}_${pageName}.
  builderName: string = "";
  // Routing Stack Name.
  routerName: string = "";
  // Parameters that need to be transferred to the page.
  param?: object = new Object();

  constructor(routerName: string = '', builderName: string = '', param?: object) {
    this.routerName = routerName;
    this.builderName = builderName;
    this.param = param;
  }
}

// Create routing information and put it into the routing stack table.
export function buildRouterModel(routerName: string, builderName: string, param?: object): Promise<boolean> {
  const router: RouterModel = new RouterModel(routerName, builderName, param);
  return RouterModule.push(router);
}

