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

// 导入图像工具套件，用于PixelMap图片对象管理（二维码图像载体）
import { image } from '@kit.ImageKit';
// 全局上下文工具类，用于跨页面共享PixelMap二维码图像数据
import { GlobalContext } from '../Util/GlobalContext'
// 自定义路由框架：页面名称常量、路由注册管理器
import { BuilderNameConstants, RouterModule } from 'RouterModule';

/**
 * 路由入口Builder包装函数
 * 供全局路由框架调用，跳转时渲染身份码页面
 */
@Builder
export function CodeBuilder() {
  Code()
}

/**
 * 身份二维码展示页面组件
 * 功能：展示由其他页面预先生成的用户身份二维码图片
 */
@Component
export struct Code {
  // 全局持久化状态栏高度，实现沉浸式适配，页面顶部避开系统状态栏
  @StorageLink('topRectHeight') topRectHeight: number = 0
  // 从全局上下文读取预先生成好的二维码PixelMap图像对象
  @State pixelMap: image.PixelMap = GlobalContext.getContext().getObject('px') as image.PixelMap
  // 导航栈实例，用于页面回退、路由操作
  pathStack: NavPathStack = new NavPathStack()

  build() {
    // Navigation官方路由页面容器
    NavDestination() {
      // 垂直弹性布局，让二维码图片居中展示
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        // 渲染二维码图像，固定尺寸，保持图像原始比例
        Image(this.pixelMap).width(300).height(300).objectFit(ImageFit.Contain)
        // 渲染条形码图片，撑满横向宽度并居中
        Image($r('app.media.tiaoxingma'))
          .width('80%')
          .height(100)
          .objectFit(ImageFit.Cover)
      }
    }
    // 导航栏标题
    .title('身份码')
    // 页面就绪回调，捕获导航上下文，获取导航栈
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    // 顶部留出距离，避开系统状态栏
    .margin({top:this.topRectHeight})
  }
}

// ========== 路由自动注册逻辑 ==========
// 获取身份码页面唯一标识常量
const builderName = BuilderNameConstants.Code;
// 防止重复注册Builder
if (!RouterModule.getBuilder(builderName)) {
  // 将@Builder包装为路由框架要求的WrappedBuilder类型
  const builder: WrappedBuilder<[object]> = wrapBuilder(CodeBuilder);
  // 将页面注册至全局路由管理器，其他页面可通过路由名称跳转到此页面
  RouterModule.registerBuilder(builderName, builder);
}
