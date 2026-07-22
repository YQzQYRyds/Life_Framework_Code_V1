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

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { AppStorageKeys } from 'common';
import { LoginManager } from '@ohos/mine';

export default class EntryAbility extends UIAbility {
  private mainWindow?: window.Window;
  private readonly avoidAreaChangeCallback = (data: window.AvoidAreaOptions): void => {
    this.updateAvoidArea(data.type, data.area);
  };

  private pxToVp(value: number): number {
    if (!this.mainWindow) {
      return 0;
    }
    try {
      return this.mainWindow.getUIContext().px2vp(value);
    } catch (err) {
      const error = err as BusinessError;
      hilog.error(0x0000, 'EntryAbility', 'Failed to convert safe-area size: %{public}s', error.message);
      return 0;
    }
  }

  private updateAvoidArea(type: window.AvoidAreaType, avoidArea: window.AvoidArea): void {
    if (type === window.AvoidAreaType.TYPE_SYSTEM) {
      AppStorage.setOrCreate(AppStorageKeys.TOP_SAFE_AREA, this.pxToVp(avoidArea.topRect.height));
    } else if (type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
      AppStorage.setOrCreate(AppStorageKeys.BOTTOM_SAFE_AREA, this.pxToVp(avoidArea.bottomRect.height));
    }
  }

  private initializeAvoidAreas(windowClass: window.Window): void {
    try {
      const navigationArea: window.AvoidArea =
        windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      this.updateAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR, navigationArea);

      const systemArea: window.AvoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.updateAvoidArea(window.AvoidAreaType.TYPE_SYSTEM, systemArea);
    } catch (err) {
      const error = err as BusinessError;
      hilog.error(0x0000, 'EntryAbility', 'Failed to read avoid areas: %{public}s', error.message);
    }
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    LoginManager.init(this.context);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    AppStorage.setOrCreate(AppStorageKeys.TOP_SAFE_AREA, 0);
    AppStorage.setOrCreate(AppStorageKeys.BOTTOM_SAFE_AREA, 0);
    AppStorage.setOrCreate(AppStorageKeys.WINDOW_STAGE, windowStage);

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
      const windowClass: window.Window = windowStage.getMainWindowSync(); // 获取应用主窗口
      this.mainWindow = windowClass;
      // 1. 设置窗口全屏
      const isLayoutFullScreen: boolean = true;
      windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
        hilog.info(0x0000, 'testTag', 'Succeeded in setting the window layout to full-screen mode.');
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, 'testTag',
          'Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
      });
      // 2. Read the initial safe areas and keep them updated while the window exists.
      this.initializeAvoidAreas(windowClass);
      windowClass.on('avoidAreaChange', this.avoidAreaChangeCallback);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    if (this.mainWindow) {
      this.mainWindow.off('avoidAreaChange', this.avoidAreaChangeCallback);
      this.mainWindow = undefined;
    }
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
