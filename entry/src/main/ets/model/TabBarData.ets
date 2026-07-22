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

import { TabBarDataType } from './DataType';

// TarBar数据
export const TABINFO: TabBarDataType[] = [
  new TabBarDataType(0, $r('app.string.custom_tab_home'), $r('app.media.home_selected'),
    $r('app.media.ic_public_home_filled')),
  new TabBarDataType(1, $r('app.string.custom_tab_news'), $r('app.media.appstore_selected'),
    $r('app.media.ic_public_appstore_filled')),
  new TabBarDataType(2, $r('app.string.custom_tab_message'), $r('app.media.comments_selected'),
    $r('app.media.ic_public_comments_filled')),
  new TabBarDataType(3, $r('app.string.custom_tab_mine'), $r('app.media.mine_selected'), $r('app.media.mine')),
];