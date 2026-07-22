# 便捷生活类行业实践

## 介绍
本示例为便捷生活类（一卡通、政务云）HarmonyOS应用架构设计实践，应用主要提供首页、办事、服务大厅、证件、社保、公积金、12345专区、身份码、账户设置等功能。
## 效果预览
![easyLife.gif](Screenshots%2FeasyLife.gif)

## 约束与限制
1. 本示例支持HarmonyOS 5.0.1 Release SDK及以上版本。
2. 本示例需要使用DevEco Studio 5.0.1 Release及以上版本进行编译运行。
3. 本示例支持设备：系统为HarmonyOS 5.0.1 Release及以上版本的华为手机。
## 使用说明
本篇代码非应用的全量代码，只包括应用的部分框架代码，开发者可根据需求自行开发应用功能。

框架代码中登录验证模块，只是UI能力，手机号位数满足条件，任意密码可登录，开发者需自行补齐相关校验。
## 实现思路
应用根据功能以及职责划分为首页，办事，互动，我的四个模块。
* 首页采用各类APP常用的页面导航布局，底部导航tab，中间是内容专区，顶部是常用的菜单。
* 首页提供了扫一扫，身份识别，社保，居住证等功能。
* 办事页面提供了出行，养老，房产，就业等功能。
* 我的页面提供账号密码中文登录，英文登录等功能。

 

## 工程目录
```
├── common                                          // 公共模块
│   ├── common/constants
│   │   └── CommonConstants.ets                     // 公共样式
│   └── network/src/main/ets/compoents/mainpage
│       └── webPage.ets                             // 加载网页
├── entry/src/main/ets                              // 主页面
│   ├── model
│   │   ├── DataType.ets                            // 底部导航栏model
│   │   └── TabBarData.ets                          // 底部导航栏数据
│   ├── pages
│   │   └── Index.ets                               // 程序主界面
│   └── entryability
│       └── EntryAbility.ets                        // 程序入口
└── features
    ├── home/src/main/ets                           // 首页
    │   ├── pages
    │   │  ├── ChequeSheetPage.ets                  // 账单页UI
    │   │  ├── CodePage.ets                         // 二维码生成
    │   │  ├── CredentialsPage.ets                  // 证件识别上传
    │   │  ├── ExitEntryPage.ets                    // 出入境界面
    │   │  ├── HomePage.ets                         // 首页UI
    │   │  ├── RentingHousePage.ets                 // 租房UI界面
    │   │  ├── ResidencePermitPage.ets              // 居住证界面
    │   │  └── SocialSecurityPage.ets               // 社保账户界面
    │   ├── Util                                    // 工具类
    │   │  ├── AssetStore.ets                       // 关键资产存储
    │   │  ├── GlobalContext.ets                    // 全局Map 存储数据
    │   │  └── UtilTools.ets                        // 扫码能力工具
    │   └── viewmodle
    │      ├── BillsData.ets                        // 账单数据
    │      ├── BillsModel.ets                       // 账单model
    │      ├── ButtonData.ets
    │      ├── ItemData.ets                         // 首页数据
    │      ├── MainViewModel.ets                    // 首页model
    │      ├── RentingHouseData.ets                 // 房屋出租数据
    │      ├── RentingHouseModel.ets                // 房屋出租model
    │      ├── SocialSecurityData.ets               // 社保账户数据
    │      └── SocialSecurityModel.ets              // 社保账户model
    ├── message/src/main/ets/pages                  // 消息
    │   └── MessagePage.ets                         // 消息首页
    ├── mine/src/main/ets                           // 我的
    │   ├── components
    │   │   └── mainpage
    │   │       ├── ForgetPassword.ets              // 忘记密码
    │   │       ├── loginPage.ets                   // 登录界面模型
    │   │       ├── myPage.ets                      // 我的界面
    │   │       ├── RegisteringPage.ets             // 注册界面
    │   │       └── SecurityCenter.ets              // 安全中心
    │   ├── modle
    │   │   ├── ItemData.ets
    │   │   └── MainViewModel.ets
    │   └── pages
    │      ├── myPage.ets                            // 登录信息页
    │      └── TopPage.ets
    ├── office/src/main/ets
    │   ├── modle
    │   │   ├── ItemData.ets                         // 办公首页数据
    │   │   └── MainViewModel.ets                    // 办公页model
    │   └── page
    │       └── Office.ets                           // 办公页UI
    └──RouterModule/src/main/ets
        ├── constants
        │   └── RouterConstants.ets                  // 定义页面常量
        ├── model
        │   └── RouterModel.ets                      // 路由类
        └── utils
            ├── Logger.ets                            // 日志信息
            └── RouterModule.ets                      // 路由公共方法
```
