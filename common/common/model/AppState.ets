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

/** Common page states used by list, network and local-data pages. */
export enum PageStatus {
  IDLE,
  LOADING,
  SUCCESS,
  EMPTY,
  ERROR
}

/**
 * Error information that can safely cross module boundaries.
 * Do not put passwords, tokens or identity data in message.
 */
export class AppError {
  code: string;
  message: string;
  retryable: boolean;

  constructor(code: string, message: string, retryable: boolean = false) {
    this.code = code;
    this.message = message;
    this.retryable = retryable;
  }
}
