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

import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { AppStorageKeys } from 'common';

const TAG: string = 'LoginManager';
const PREFERENCES_NAME: string = 'loginStore';
const PREFERENCES_SESSION_KEY: string = 'loginInfo';

export enum LoginMethod {
  PASSWORD = 'password',
  SMS = 'sms'
}

/**
 * Local course-demo session. Only masked display information is persisted.
 * Passwords, verification codes, tokens and complete phone numbers are never stored.
 */
export interface LoginInfo {
  isLogin: boolean;
  userName: string;
  maskedPhone: string;
  loginTime: number;
  loginMethod: LoginMethod;
}

export class LoginManager {
  static readonly SMS_LOGIN_MARKER: string = 'sms_login';
  private static prefs: preferences.Preferences | null = null;

  static init(context: Context): void {
    AppStorage.setOrCreate(AppStorageKeys.LOGIN_STATE, LoginManager.createLoggedOutInfo());
    AppStorage.setOrCreate(AppStorageKeys.SWITCH_TO_MINE_TAB, false);
    try {
      LoginManager.prefs = preferences.getPreferencesSync(context, { name: PREFERENCES_NAME });
      LoginManager.restoreFromPreferences();
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to initialize local session storage: %{public}s', err.message);
    }
  }

  static createLoggedOutInfo(): LoginInfo {
    return {
      isLogin: false,
      userName: '未登录',
      maskedPhone: '',
      loginTime: 0,
      loginMethod: LoginMethod.PASSWORD
    };
  }

  private static restoreFromPreferences(): void {
    if (!LoginManager.prefs) {
      return;
    }
    try {
      const saved: string = LoginManager.prefs.getSync(PREFERENCES_SESSION_KEY, '') as string;
      if (saved.length === 0) {
        return;
      }
      const info: LoginInfo = JSON.parse(saved) as LoginInfo;
      if (info.isLogin && info.userName.length > 0 && info.maskedPhone.length > 0) {
        AppStorage.setOrCreate(AppStorageKeys.LOGIN_STATE, info);
      }
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to restore local session: %{public}s', err.message);
      LoginManager.clearPersistedSession();
    }
  }

  private static persist(info: LoginInfo): void {
    if (!LoginManager.prefs) {
      return;
    }
    try {
      LoginManager.prefs.putSync(PREFERENCES_SESSION_KEY, JSON.stringify(info));
      LoginManager.prefs.flush().catch((error: BusinessError) => {
        hilog.error(0x0000, TAG, 'Failed to flush local session: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to persist local session: %{public}s', err.message);
    }
  }

  private static clearPersistedSession(): void {
    if (!LoginManager.prefs) {
      return;
    }
    try {
      LoginManager.prefs.deleteSync(PREFERENCES_SESSION_KEY);
      LoginManager.prefs.flush().catch((error: BusinessError) => {
        hilog.error(0x0000, TAG, 'Failed to flush logout state: %{public}s', error.message);
      });
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(0x0000, TAG, 'Failed to clear local session: %{public}s', err.message);
    }
  }

  static getLoginInfo(): LoginInfo {
    const info = AppStorage.get<LoginInfo>(AppStorageKeys.LOGIN_STATE);
    return info ?? LoginManager.createLoggedOutInfo();
  }

  static isLoggedIn(): boolean {
    return LoginManager.getLoginInfo().isLogin;
  }

  static getDisplayName(): string {
    return LoginManager.getLoginInfo().userName;
  }

  /**
   * Creates a local simulated login session after input validation.
   * This project does not contact a real identity service.
   */
  static async login(account: string, credential: string): Promise<boolean> {
    if (!LoginManager.isValidPhone(account)) {
      return false;
    }
    const method: LoginMethod = credential === LoginManager.SMS_LOGIN_MARKER ?
      LoginMethod.SMS : LoginMethod.PASSWORD;
    if (method === LoginMethod.PASSWORD && !LoginManager.isValidPassword(credential)) {
      return false;
    }

    const maskedPhone: string = LoginManager.maskPhone(account);
    const info: LoginInfo = {
      isLogin: true,
      userName: maskedPhone,
      maskedPhone: maskedPhone,
      loginTime: Date.now(),
      loginMethod: method
    };
    AppStorage.setOrCreate(AppStorageKeys.LOGIN_STATE, info);
    LoginManager.persist(info);
    return true;
  }

  static logout(): void {
    AppStorage.setOrCreate(AppStorageKeys.LOGIN_STATE, LoginManager.createLoggedOutInfo());
    LoginManager.clearPersistedSession();
  }

  static maskPhone(phone: string): string {
    if (!LoginManager.isValidPhone(phone)) {
      return '';
    }
    return phone.substring(0, 3) + '****' + phone.substring(7);
  }

  static isValidPhone(phone: string): boolean {
    return /^[0-9]{11}$/.test(phone);
  }

  static isValidPassword(password: string): boolean {
    return password.length >= 6 && password.length <= 20 && /^[\x21-\x7e]+$/.test(password);
  }

  static filterDigits(input: string): string {
    return input.replace(/[^0-9]/g, '');
  }

  static filterPassword(input: string): string {
    return input.replace(/[^\x21-\x7e]/g, '');
  }

  static generateVerifyCode(): string {
    return String(Math.floor(1000 + Math.random() * 9000));
  }
}
