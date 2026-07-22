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

/**
 * Shared AppStorage keys. Existing key values are intentionally retained so
 * that feature modules can migrate from string literals without breaking data.
 */
export class AppStorageKeys {
  static readonly TOP_SAFE_AREA: string = 'topRectHeight';
  static readonly BOTTOM_SAFE_AREA: string = 'bottomRectHeight';
  static readonly WINDOW_STAGE: string = 'windowStage';
  static readonly LOGIN_STATE: string = 'login';
  static readonly SWITCH_TO_MINE_TAB: string = 'switchToMineTab';
}
