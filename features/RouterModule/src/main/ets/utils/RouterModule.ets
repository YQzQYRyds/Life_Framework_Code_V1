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
import { RouterModel } from '../model/RouterModel';
import Logger from './Logger';
import { BusinessError } from '@kit.BasicServicesKit';

function callHarInit(ns: ESObject, router: RouterModel): void {
  ns.harInit(router.builderName);
}

export class RouterModule {
  static builderMap: Map<string, WrappedBuilder<[object]>> = new Map<string, WrappedBuilder<[object]>>();
  static routerMap: Map<string, NavPathStack> = new Map<string, NavPathStack>();

  // Registering a builder by name.
  public static registerBuilder(builderName: string, builder: WrappedBuilder<[object]>): void {
    if (builderName.length === 0) {
      Logger.error('Cannot register a builder with an empty name.');
      return;
    }
    RouterModule.builderMap.set(builderName, builder);
  }

  public static hasBuilder(builderName: string): boolean {
    return RouterModule.builderMap.has(builderName);
  }

  // Get builder by name.
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    const builder = RouterModule.builderMap.get(builderName);
    if (!builder) {
      Logger.info('not found builder ' + builderName);
    }
    return builder as WrappedBuilder<[object]>;
  }

  // Registering a router by name.
  public static createRouter(routerName: string, router: NavPathStack): void {
    if (routerName.length === 0) {
      Logger.error('Cannot register a route stack with an empty name.');
      return;
    }
    RouterModule.routerMap.set(routerName, router);
  }

  public static hasRouter(routerName: string): boolean {
    return RouterModule.routerMap.has(routerName);
  }

  // Get router by name.
  public static getRouter(routerName: string): NavPathStack {
    return RouterModule.routerMap.get(routerName) as NavPathStack;
  }

  // Jumping to a Specified Page by Obtaining the Page Stack.
  public static getHarName(builderName: string): string {
    const separatorIndex: number = builderName.indexOf('_');
    if (separatorIndex <= 0) {
      return '';
    }
    return builderName.substring(0, separatorIndex);
  }

  public static push(router: RouterModel): Promise<boolean> {
    const pageStack: NavPathStack | undefined = RouterModule.routerMap.get(router.routerName);
    if (!pageStack) {
      Logger.error('Route stack not found: ' + router.routerName);
      return Promise.resolve(false);
    }

    const harName: string = RouterModule.getHarName(router.builderName);
    if (harName.length === 0) {
      Logger.error('Invalid builder name: ' + router.builderName);
      return Promise.resolve(false);
    }

    // Dynamically import the page to be redirected to.
    return import(harName).then((ns: ESObject): boolean => {
      callHarInit(ns, router);
      pageStack.pushPath({ name: router.builderName, param: router.param });
      return true;
    }).catch((err: BusinessError): boolean => {
      Logger.error('Failed to load route ' + router.builderName + ': ' + err.message);
      return false;
    });
  }

  // Obtain the page stack and pop it.
  public static pop(routerName: string): void {
    const pageStack: NavPathStack | undefined = RouterModule.routerMap.get(routerName);
    if (!pageStack) {
      Logger.error('Cannot pop. Route stack not found: ' + routerName);
      return;
    }
    pageStack.pop();
  }

  // Get the page stack and clear it.
  public static clear(routerName: string): void {
    const pageStack: NavPathStack | undefined = RouterModule.routerMap.get(routerName);
    if (!pageStack) {
      Logger.error('Cannot clear. Route stack not found: ' + routerName);
      return;
    }
    pageStack.clear();
  }

  // Directly jump to the specified route.
  public static popToName(routerName: string, builderName: string): void {
    const pageStack: NavPathStack | undefined = RouterModule.routerMap.get(routerName);
    if (!pageStack) {
      Logger.error('Cannot pop to route. Route stack not found: ' + routerName);
      return;
    }
    pageStack.popToName(builderName);
  }
}
