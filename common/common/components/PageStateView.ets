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

import { PageStatus } from '../model/AppState';

/**
 * Optional shared loading/empty/error view. Feature pages keep control of the
 * success UI and can adopt this component without changing their data layer.
 */
@Component
export struct PageStateView {
  @Prop status: PageStatus = PageStatus.IDLE;
  @Prop message: string = '';
  onRetry: () => void = () => {};

  build() {
    Column({ space: 12 }) {
      if (this.status === PageStatus.LOADING) {
        LoadingProgress()
          .width(32)
          .height(32)
        Text($r('app.string.common_state_loading'))
          .fontSize(14)
          .fontColor('#666666')
      } else if (this.status === PageStatus.EMPTY) {
        Text(this.message.length > 0 ? this.message : $r('app.string.common_state_empty'))
          .fontSize(14)
          .fontColor('#666666')
      } else if (this.status === PageStatus.ERROR) {
        Text(this.message.length > 0 ? this.message : $r('app.string.common_state_error'))
          .fontSize(14)
          .fontColor('#C64040')
        Button($r('app.string.common_state_retry'))
          .height(36)
          .onClick(() => {
            this.onRetry();
          })
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}
