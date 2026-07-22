import { promptAction } from '@kit.ArkUI'
import { AppealSubmitPage } from './AppealSubmitPage';
import { BusinessPage } from './BusinessPage';
import { CommentsPage } from './CommentsPage';
import { GoldenIdeaPage } from './GoldenIdeaPage';
import { InterviewListPage } from './InterviewListPage';
import { LiveDetailPage } from './LiveDetailPage';
import { MailBoxPage } from './MailBoxPage';
import { MessageBoardPage } from './MessageBoardPage';
import { SelfServicePage } from './SelfServicePage';
import { TravelServicePage } from './TravelServicePage';

// 页面路由名称常量
interface GeneratedObjectLiteralInterface_1 {
  MAIL_BOX: string;
  COMMENTS: string;
  APPEAL_SUBMIT: string;
  GOLDEN_IDEA: string;
  BUSINESS: string;
  MESSAGE_BOARD: string;
  SELF_SERVICE: string;
  TRAVEL_SERVICE: string;
  INTERVIEW_LIST: string;
  LIVE_DETAIL: string;
}

export const ROUTE_NAMES: GeneratedObjectLiteralInterface_1 = {
  MAIL_BOX: 'MailBoxPage',
  COMMENTS: 'CommentsPage',
  APPEAL_SUBMIT: 'AppealSubmitPage',
  GOLDEN_IDEA: 'GoldenIdeaPage',
  BUSINESS: 'BusinessPage',
  MESSAGE_BOARD: 'MessageBoardPage',
  SELF_SERVICE: 'SelfServicePage',
  TRAVEL_SERVICE: 'TravelServicePage',
  INTERVIEW_LIST: 'InterviewListPage',
  LIVE_DETAIL: 'LiveDetailPage'
}

export  interface RouteParams {
  from?: string;
  serviceType?: string;
  title?: string | Resource;
  category?: string;
  type?: string;
  liveId?: number;
  message?: string;
  userName?: string;
}


interface GeneratedTypeLiteralInterface_1 {
  icon: Resource;
  title: Resource;
  routeName: string;
}

interface GeneratedTypeLiteralInterface_2 {
  icon: Resource;
  title: string;
  action: () => void;
}

interface GeneratedTypeLiteralInterface_3 {
  icon: Resource;
  title: Resource;
  routeName: string;
}

interface GeneratedTypeLiteralInterface_4 {
  icon: Resource;
  title: string;
  action: () => void;
}

@Component
export struct MessagePage {
  @State messageInput: string = ''
  @State isRefreshing: boolean = false
  @State currentMailIndex: number = 0

  dialogController: CustomDialogController = new CustomDialogController({
    builder: this.showMessageDialog.bind(this),
    autoCancel: true,
    alignment: DialogAlignment.Center
  })

  // Navigation 页面栈管理
  @Provide pageInfos: NavPathStack = new NavPathStack()

  // 寄信箱数据 - 改为使用 routeName
  private mailBoxData: Array<GeneratedTypeLiteralInterface_1> = [
    { icon: $r('app.media.drive'), title: $r('app.string.shiweiBox'), routeName: ROUTE_NAMES.MAIL_BOX },
    { icon: $r('app.media.comments'), title: $r('app.string.shiweiBox'), routeName: ROUTE_NAMES.COMMENTS }
  ]

  // 热线专区数据 - action 改为使用 Navigation 跳转
  private hotLineData: Array<GeneratedTypeLiteralInterface_2> = [
    {
      icon: $r('app.media.download'),
      title: '诉求提交',
      action: () => {
        this.pageInfos.pushPathByName(ROUTE_NAMES.APPEAL_SUBMIT, { from: 'message' } as RouteParams)
      }
    },
    {
      icon: $r('app.media.brightness'),
      title: '金点子',
      action: () => {
        this.pageInfos.pushPathByName(ROUTE_NAMES.GOLDEN_IDEA, { from: 'message' } as RouteParams)
      }
    },
    {
      icon: $r('app.media.camera'),
      title: '业务',
      action: () => {
        this.pageInfos.pushPathByName(ROUTE_NAMES.BUSINESS, { from: 'message' } as RouteParams)
      }
    },
    {
      icon: $r('app.media.more'),
      title: '更多',
      action: () => {
        promptAction.showActionMenu({
          title: '更多服务',
          buttons: [
            { text: '常见问题', color: '#007AFF' },
            { text: '意见反馈', color: '#007AFF' },
            { text: '帮助中心', color: '#007AFF' }
          ]
        }).then((result) => {
          if (result.index !== undefined) {
            const actions = ['常见问题', '意见反馈', '帮助中心']
            promptAction.showToast({ message: `进入${actions[result.index]}` })
          }
        })
      }
    }
  ]

  build() {
    // 使用 Navigation 包裹原有内容，不改变任何布局
    Navigation(this.pageInfos) {
      // 原有 Refresh 内容完全不变
      Refresh({
        refreshing: $$this.isRefreshing
      }) {
        Column() {
          List() {
            // 顶部滚动寄信箱 - 完全不变
            this.mailBox();
            // 热线专区 - 完全不变
            this.hotLine();
            // 服务卡片 - 完全不变
            this.service();
            // 在线访谈 - 完全不变
            this.interviewOnline();
          }
          .alignListItem(ListItemAlign.Center)
          .height('98%')
        }
        .height('100%')
        .backgroundImage($r('app.media.background_green'))
        .backgroundImageSize({ width: px2vp(360 * 3.5), height: px2vp(780 * 3.5) })
      }
      .onRefreshing(() => {
        this.isRefreshing = true
        this.currentMailIndex = (this.currentMailIndex + 1) % 2
        setTimeout(() => {
          this.isRefreshing = false
          promptAction.showToast({ message: '刷新成功' })
        }, 2000)
      })
    }
    // Navigation 配置 - 隐藏导航栏，使用自定义标题
    .title('')
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.navDestinationBuilder)
  }

  // Navigation 页面构建器 - 根据路由名称创建对应页面
  @Builder
  navDestinationBuilder(name: string, param: Object) {
    if (name === ROUTE_NAMES.MAIL_BOX) {
      NavDestination() {
        MailBoxPage({ params: param })
      }
      .title('寄信箱')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.COMMENTS) {
      NavDestination() {
        CommentsPage({ params: param })
      }
      .title('留言板')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.APPEAL_SUBMIT) {
      NavDestination() {
        AppealSubmitPage({ params: param })
      }
      .title('诉求提交')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.GOLDEN_IDEA) {
      NavDestination() {
        GoldenIdeaPage({ params: param })
      }
      .title('金点子')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.BUSINESS) {
      NavDestination() {
        BusinessPage({ params: param })
      }
      .title('业务')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.MESSAGE_BOARD) {
      NavDestination() {
        MessageBoardPage({ params: param })
      }
      .title('留言板')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.SELF_SERVICE) {
      NavDestination() {
        SelfServicePage({ params: param })
      }
      .title('自助服务')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.TRAVEL_SERVICE) {
      NavDestination() {
        TravelServicePage({ params: param })
      }
      .title('出行服务')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.INTERVIEW_LIST) {
      NavDestination() {
        InterviewListPage({ params: param })
      }
      .title('访谈列表')
      .hideTitleBar(false)
    } else if (name === ROUTE_NAMES.LIVE_DETAIL) {
      NavDestination() {
        LiveDetailPage({ params: param })
      }
      .title('直播详情')
      .hideTitleBar(false)
    }
  }

  mailBoxSwiperCtr: SwiperController = new SwiperController();

  // ========== 以下所有 Builder 代码完全不变，仅修改跳转逻辑 ==========

  @Builder
  mailBox() {
    Row() {
      Swiper(this.mailBoxSwiperCtr) {
        ForEach(this.mailBoxData, (item: GeneratedTypeLiteralInterface_3, index: number) => {
          Row() {
            Image(item.icon)
              .width(px2vp(24 * 3.5))
              .height(px2vp(26 * 3.5))
              .margin({ left: px2vp(27 * 3.5) })
            Text(item.title)
              .fontSize(px2vp(12 * 3.5))
              .fontWeight(500)
              .margin({ left: px2vp(8 * 3.5) })
          }
          .onClick(() => {
            // 改为 Navigation 跳转
            if (item.routeName) {
              this.pageInfos.pushPathByName(item.routeName, {
                from: 'message',
                title: item.title
              } as RouteParams)
            } else {
              promptAction.showToast({ message: '该功能即将上线' })
            }
          })
          .backgroundColor(Color.White)
          .borderRadius(10)
          .height(px2vp(48 * 3.5))
          .width(px2vp(158 * 3.5))
        })
      }
      .width(px2vp(158 * 3.5))
      .height(px2vp(48 * 3.5))
      .autoPlay(true)
      .interval(3000)
      .loop(true)
      .index(this.currentMailIndex)
      .onChange((index: number) => {
        this.currentMailIndex = index
      })

      // 第二个寄信箱 - 跳转逻辑改为 Navigation
      Row() {
        Image($r('app.media.comments'))
          .width(px2vp(24 * 3.5))
          .height(px2vp(27 * 3.5))
          .margin({ left: px2vp(27 * 3.5) })
        Text($r('app.string.shiweiBox'))
          .fontSize(px2vp(12 * 3.5))
          .fontWeight(500)
          .margin({ left: px2vp(8 * 3.5) })
      }
      .onClick(() => {
        this.dialogController.open()
      })
      .backgroundColor(Color.White)
      .borderRadius(10)
      .height(px2vp(48 * 3.5))
      .width(px2vp(158 * 3.5))
      .margin({ left: px2vp(12 * 3.5) })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .margin({ top: px2vp(262 * 3.5) })
  }

  @Builder
  showMessageDialog() {
    Column() {
      Text('请输入您的留言')
        .fontSize(16)
        .fontWeight(500)
        .margin({ top: 16, bottom: 8 })

      TextInput({ placeholder: '在这里输入留言...' })
        .width('90%')
        .height(40)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .onChange((value: string) => {
          this.messageInput = value
        })

      Row() {
        Button('取消')
          .width('40%')
          .height(36)
          .backgroundColor('#E0E0E0')
          .fontColor('#333')
          .borderRadius(8)
          .onClick(() => {
            this.messageInput = ''
            // 关闭对话框
            if (this.dialogController) {
              this.dialogController.close()
            }
          })

        Button('发布')
          .width('40%')
          .height(36)
          .backgroundColor('#007AFF')
          .fontColor(Color.White)
          .borderRadius(8)
          .onClick(() => {
            if (this.messageInput.trim()) {
              // 跳转到留言板并传递留言内容
              this.pageInfos.pushPathByName(ROUTE_NAMES.MESSAGE_BOARD, {
                from: 'mailbox',
                message: this.messageInput.trim(),
                userName: '我'
              } as RouteParams )
              this.messageInput = ''
              // 关闭对话框
              if (this.dialogController) {
                this.dialogController.close()
              }
            } else {
              promptAction.showToast({ message: '请输入留言内容' })
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 12, bottom: 16 })
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding(16)
  }

  @Builder
  hotLine() {
    ListItem() {
      Flex() {
        Column() {
          Text('12345专区')
            .width('100%')
            .fontSize(px2vp(18 * 3.5))
            .margin({ top: '20vp', left: '13vp' })
            .fontWeight(700)
          Blank(5)
          Grid() {
            ForEach(this.hotLineData, (item: GeneratedTypeLiteralInterface_4) => {
              GridItem() {
                this.hotLineItem(item.icon, item.title, item.action)
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 2fr')
          .columnsGap('8vp')
          .rowsGap('12vp')
          .height('70vp')
          .padding({ top: '12vp', bottom: '12vp' })
        }
      }
      .padding({ left: '13vp' })
    }
  }

  @Builder
  hotLineItem(imageUrl: string | Resource, title: string, action: () => void) {
    Column() {
      Image(imageUrl)
        .width(px2vp(24 * 3.5))
        .height(px2vp(24 * 3.5))
      Text(title)
        .fontSize(px2vp(12 * 3.5))
        .fontWeight(400)
        .margin({ top: '5vp' })
    }
    .onClick(() => {
      action()
    })
  }

  @Builder
  service() {
    Row() {
      Column() {
        Image($r('app.media.fig1'))
          .width(px2vp(165 * 3.5))
          .height(px2vp(105 * 3.5))
          .borderRadius(px2vp(14 * 3.5))
          .margin({ top: px2vp(10 * 3.5) })
        Text('自助服务')
          .fontSize(px2vp(14 * 3.5))
          .fontWeight(400)
          .margin({ top: px2vp(10 * 3.5) })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ right: px2vp(10 * 3.5) })
      .onClick(() => {
        // 改为 Navigation 跳转
        this.pageInfos.pushPathByName(ROUTE_NAMES.SELF_SERVICE, {
          serviceType: 'self',
          title: '自助服务'
        } as RouteParams)
      })

      Column() {
        Image($r('app.media.fig2'))
          .width(px2vp(165 * 3.5))
          .height(px2vp(105 * 3.5))
          .borderRadius(px2vp(14 * 3.5))
          .margin({ top: px2vp(10 * 3.5) })
        Text('出行服务')
          .fontSize(px2vp(14 * 3.5))
          .fontWeight(400)
          .margin({ top: px2vp(10 * 3.5) })
      }
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        // 改为 Navigation 跳转
        this.pageInfos.pushPathByName(ROUTE_NAMES.TRAVEL_SERVICE, {
          serviceType: 'travel',
          title: '出行服务'
        } as RouteParams)
      })
    }
    .margin({ bottom: px2vp(15 * 3.5) })
  }

  @Builder
  interviewOnline() {
    ListItem() {
      Flex() {
        Column() {
          Row() {
            Text('在线访谈')
              .fontSize(px2vp(18 * 3.5))
              .margin({ left: '13vp' })
              .fontWeight(700)
            Row() {
              Text('更多')
                .fontSize(px2vp(14 * 3.5))
                .fontWeight(400)
                .opacity(0.6)
                .onClick(() => {
                  // 改为 Navigation 跳转
                  this.pageInfos.pushPathByName(ROUTE_NAMES.INTERVIEW_LIST, {
                    category: 'interview',
                    title: '在线访谈'
                  } as RouteParams)
                })
                .margin({ right: '8vp' })
              Image($r('app.media.arrow'))
                .width(px2vp(6 * 3.5))
                .height(px2vp(12 * 3.5))
                .margin({ left: '6vp', right: '20vp' })
            }
          }.justifyContent(FlexAlign.SpaceBetween).width('100%')

          Row() {
            Image($r('app.media.interview'))
              .width(px2vp(110 * 3.5))
              .height(px2vp(65 * 3.5))
              .borderRadius(10)
              .padding({ left: px2vp(8 * 3.5) })
            Column() {
              Text('直播｜发布商业高频场景和分销新品，对合作伙伴表彰颁奖')
                .fontSize(px2vp(16 * 3.5))
                .fontWeight(400)
            }
            .width(px2vp(166 * 3.5))
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .margin({ left: '10vp', right: '10vp' })
          }
          .width(px2vp(308 * 3.5))
          .height(px2vp(80 * 3.5))
          .margin({ top: '12vp', right: '18vp' })
          .backgroundColor(Color.White)
          .borderRadius(px2vp(8 * 3.5))
          .onClick(() => {
            // 改为 Navigation 跳转
            this.pageInfos.pushPathByName(ROUTE_NAMES.LIVE_DETAIL, {
              title: '发布商业高频场景和分销新品，对合作伙伴表彰颁奖',
              type: '直播',
              from: 'interview',
              liveId: Date.now()
            } as RouteParams)
          })
        }
        .width('100%')
      }.width('100%')
    }
  }
}