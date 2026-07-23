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

// 项目自定义路由框架
import { BuilderNameConstants, RouterModule } from 'RouterModule'

interface FAQItem {
  question: string;
  answer: string;
}

const FAQ_ITEMS: FAQItem[] = [
  { question: '如何办理社保卡？', answer: '可从首页进入“社保”，查看办理条件和所需材料。' },
  { question: '如何查询社保余额？', answer: '进入“社保”页面后，可查看各险种账户余额和缴费明细。' },
  { question: '如何挂失补办证件？', answer: '请先在对应证件服务中查看办理要求，再按提示准备身份证明材料。' },
  { question: '如何修改个人信息？', answer: '进入“我的”页面，在个人资料中修改可编辑的信息。' }
]

/**
 * 路由入口Builder包装函数
 * 供全局路由框架调用，跳转时渲染客服页面
 */
@Builder
export function CustomerServiceBuilder() {
  CustomerServicePage()
}

/**
 * 客服页面组件
 * 固定显示人工客服小艺为你服务
 */
@Component
struct CustomerServicePage {
  // 导航栈实例，用于页面回退、路由操作
  pathStack: NavPathStack = new NavPathStack()
  @State selectedQuestion: string = FAQ_ITEMS[0].question
  @State selectedAnswer: string = FAQ_ITEMS[0].answer

  build() {
    // Navigation官方路由页面容器
    NavDestination() {
      Column({ space: 20 }) {
        // 客服头像区域
        Column() {
          Image($r('app.media.ic_contacts_nickname'))
            .width(100)
            .height(100)
            .borderRadius(50)
            .backgroundColor('#E8F5E9')
          Text('小艺')
            .fontSize('18fp')
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ top: '16vp' })
        }
        .padding({ top: '60vp' })

        // 服务状态
        Text('智能客服小艺为你服务')
          .fontSize('18fp')
          .fontColor('#666666')
          .textAlign(TextAlign.Center)
          .padding({ left: '20vp', right: '20vp' })

        // 在线状态标识
        Row() {
          Blank()
          Row() {
            Image($r('app.media.ic_public_highlight_filled'))
              .width('12vp')
              .height('12vp')
              .fillColor('#4CAF50')
            Text('在线')
              .fontSize('14fp')
              .fontColor('#4CAF50')
              .margin({ left: '6vp' })
          }
          Blank()
        }

        // 常见问题区域
        Column() {
          Text('常见问题')
            .fontSize('16fp')
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: '16vp', left: '20vp' })
            .width('100%')

          Column() {
            ForEach(FAQ_ITEMS, (item: FAQItem) => {
              Row() {
                Text(item.question)
                  .fontSize('14fp')
                  .fontColor('#666666')
                Blank()
                Image($r('app.media.ic_public_arrow_right'))
                  .width('22vp')
                  .height('22vp')
              }
              .padding({ left: '20vp', right: '20vp', top: '16vp', bottom: '16vp' })
              .backgroundColor(Color.White)
              .width('100%')
              .borderRadius('8vp')
              .margin({ bottom: '8vp' })
              .onClick(() => {
                this.selectedQuestion = item.question
                this.selectedAnswer = item.answer
              })
            }, (item: FAQItem) => item.question)
          }
          .padding({ left: '16vp', right: '16vp' })

          Column() {
            Text(this.selectedQuestion)
              .fontSize('15fp')
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
            Text(this.selectedAnswer)
              .fontSize('14fp')
              .fontColor('#666666')
              .lineHeight('22vp')
              .width('100%')
              .margin({ top: '8vp' })
          }
          .width('100%')
          .padding('16vp')
          .backgroundColor('#E8F5E9')
          .borderRadius('8vp')
          .margin({ left: '16vp', right: '16vp', top: '8vp' })
        }
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    // 导航栏标题
    .title('客服中心')
    // 页面就绪回调，捕获导航上下文，获取导航栈
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

// ========== 路由自动注册逻辑 ==========
const builderName = BuilderNameConstants.CustomerService;
// 防止重复注册Builder
if (!RouterModule.getBuilder(builderName)) {
  // 将@Builder包装为路由框架要求的WrappedBuilder类型
  const builder: WrappedBuilder<[object]> = wrapBuilder(CustomerServiceBuilder);
  // 将页面注册至全局路由管理器，其他页面可通过路由名称跳转到此页面
  RouterModule.registerBuilder(builderName, builder);
}
