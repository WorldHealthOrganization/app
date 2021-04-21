// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static m0(copyrightString, versionString) =>
      "${copyrightString} ${versionString} 由世界卫生组织联合开发的-19 应用程序组合。";

  static m1(team) => "感谢： ${team}";

  static m2(projectIdShort) => "服务器 ${projectIdShort} - 上无隐私";

  static m3(version, buildNumber) => "版本 ${version} (${buildNumber})";

  static m4(year) => "© ${year} 谁";

  static m5(country) => "${country} 案例总数";

  static m6(lastUpd) => "最后更新 ${lastUpd}";

  static m7(attribution) => "来源： ${attribution}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "LegalLandingPageTermsOfServiceLinkText":
            MessageLookupByLibrary.simpleMessage("服务条款"),
        "aboutPageBuiltByCreditText": m0,
        "aboutPagePrivacyPolicyLinkText":
            MessageLookupByLibrary.simpleMessage("隐私政策"),
        "aboutPagePrivacyPolicyLinkUrl": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/myhealthapp/privacy-notice"),
        "aboutPageTermsOfServiceLinkText":
            MessageLookupByLibrary.simpleMessage("服务条款"),
        "aboutPageTermsOfServiceLinkUrl": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/myhealthapp/terms-of-use"),
        "aboutPageThanksToText": m1,
        "aboutPageTitle": MessageLookupByLibrary.simpleMessage("关于应用"),
        "aboutPageViewLicensesLinkText":
            MessageLookupByLibrary.simpleMessage("查看许可证"),
        "checkUpIntroPageByUsingThisToolYouAgreeToItsTermsAnd":
            MessageLookupByLibrary.simpleMessage(
                "使用此工具即表示您同意其条款，且谁将对与您使用有关的任何损害不承担任何责任。"),
        "checkUpIntroPageCheckup": MessageLookupByLibrary.simpleMessage("检查"),
        "checkUpIntroPageGetStarted":
            MessageLookupByLibrary.simpleMessage("开始"),
        "checkUpIntroPageNotMedicalAdvise":
            MessageLookupByLibrary.simpleMessage(
                "本工具提供的信息不构成医疗建议，不应用于诊断或治疗医疗状况。"),
        "checkUpIntroPageSeeTerms":
            MessageLookupByLibrary.simpleMessage("请参阅术语"),
        "checkUpIntroPageYouShouldKnow":
            MessageLookupByLibrary.simpleMessage("你应该知道..."),
        "checkUpIntroPageYourAnswersWillNotBeSharedWithWhoOrOthers":
            MessageLookupByLibrary.simpleMessage("未经您的许可，您的答案将不会分享给谁或其他人。"),
        "commonContentLoadingDialogUpdateRequiredBodyText":
            MessageLookupByLibrary.simpleMessage("请更新最新版本的应用程序，以接收最新信息和更新。"),
        "commonContentLoadingDialogUpdateRequiredDetails":
            MessageLookupByLibrary.simpleMessage(
                "这些信息可能已过时。您必须更新此应用程序才能获得更多最新的 coadd-19 信息。"),
        "commonContentLoadingDialogUpdateRequiredTitle":
            MessageLookupByLibrary.simpleMessage("需要更新应用"),
        "commonContentNoPrivacyOnServer": m2,
        "commonDialogButtonNext": MessageLookupByLibrary.simpleMessage("下一步"),
        "commonDialogButtonOk": MessageLookupByLibrary.simpleMessage("好吧"),
        "commonPermissionRequestPageButtonSkip":
            MessageLookupByLibrary.simpleMessage("跳过"),
        "commonWhoAppShareIconButtonDescription":
            MessageLookupByLibrary.simpleMessage(
                "查看来自世界卫生组织的官方 COVALD-19 应用程序 https://covid19app.who.int/app"),
        "commonWorldHealthOrganization":
            MessageLookupByLibrary.simpleMessage("世界卫生组织"),
        "commonWorldHealthOrganizationCoronavirusApp":
            MessageLookupByLibrary.simpleMessage("科维德-19"),
        "commonWorldHealthOrganizationCoronavirusAppVersion": m3,
        "commonWorldHealthOrganizationCoronavirusCopyright": m4,
        "countrySelectCountryLabel": MessageLookupByLibrary.simpleMessage("国家"),
        "countrySelectPlaceholder": MessageLookupByLibrary.simpleMessage("选择"),
        "healthCheckTitle": MessageLookupByLibrary.simpleMessage("健康检查"),
        "homePageCountryTotalCases": m5,
        "homePageCovid19Response":
            MessageLookupByLibrary.simpleMessage("COVALD-19 响应"),
        "homePageGlobalTotalCases":
            MessageLookupByLibrary.simpleMessage("全球总案例"),
        "homePagePageButtonLatestNumbers":
            MessageLookupByLibrary.simpleMessage("最新数字"),
        "homePagePageButtonLatestNumbersUrl":
            MessageLookupByLibrary.simpleMessage("https://who.sprinklr.com"),
        "homePagePageButtonNewsAndPress":
            MessageLookupByLibrary.simpleMessage("新闻与新闻"),
        "homePagePageButtonProtectYourself":
            MessageLookupByLibrary.simpleMessage("保护自己"),
        "homePagePageButtonQuestions":
            MessageLookupByLibrary.simpleMessage("问题和答案"),
        "homePagePageButtonTravelAdvice":
            MessageLookupByLibrary.simpleMessage("旅行建议"),
        "homePagePageButtonWHOMythBusters":
            MessageLookupByLibrary.simpleMessage("了解事实"),
        "homePagePageButtonWHOMythBustersDescription":
            MessageLookupByLibrary.simpleMessage("了解 CODAD-19 的事实以及如何防止传播"),
        "homePagePageButtonYourQuestionsAnswered":
            MessageLookupByLibrary.simpleMessage("问题和答案"),
        "homePagePageDonate": MessageLookupByLibrary.simpleMessage("在这里捐赠"),
        "homePagePageDonateUrl": MessageLookupByLibrary.simpleMessage(
            "https://covid19responsefund.org/"),
        "homePagePageSliverListAboutTheApp":
            MessageLookupByLibrary.simpleMessage("关于应用"),
        "homePagePageSliverListAboutTheAppDialog":
            MessageLookupByLibrary.simpleMessage("世界卫生组织的官方核心-19 应用程序。"),
        "homePagePageSliverListProvideFeedback":
            MessageLookupByLibrary.simpleMessage("提供应用反馈"),
        "homePagePageSliverListSettings":
            MessageLookupByLibrary.simpleMessage("设置"),
        "homePagePageSliverListSettingsDataCollection":
            MessageLookupByLibrary.simpleMessage("允许谁通过 Google 分析收集产品改进用分析"),
        "homePagePageSliverListSettingsHeader1":
            MessageLookupByLibrary.simpleMessage("分析"),
        "homePagePageSliverListSettingsHeader2":
            MessageLookupByLibrary.simpleMessage("语言"),
        "homePagePageSliverListSettingsNotificationsHeader":
            MessageLookupByLibrary.simpleMessage("通知"),
        "homePagePageSliverListSettingsNotificationsInfo":
            MessageLookupByLibrary.simpleMessage("允许谁向您发送通知，通知您最新消息"),
        "homePagePageSliverListShareTheApp":
            MessageLookupByLibrary.simpleMessage("分享应用"),
        "homePagePageSubTitle": MessageLookupByLibrary.simpleMessage("信息和工具"),
        "homePagePageSupport": MessageLookupByLibrary.simpleMessage("帮助支持救援工作"),
        "homePagePageTitle": MessageLookupByLibrary.simpleMessage("科维德-19"),
        "latestNumbersPageCasesDimension":
            MessageLookupByLibrary.simpleMessage("全球案例"),
        "latestNumbersPageDaily": MessageLookupByLibrary.simpleMessage("每日"),
        "latestNumbersPageDailyToggle":
            MessageLookupByLibrary.simpleMessage("新款"),
        "latestNumbersPageDeathsDimension":
            MessageLookupByLibrary.simpleMessage("全球死亡"),
        "latestNumbersPageDisclosure":
            MessageLookupByLibrary.simpleMessage("当前一天或一周的数据可能不完整。"),
        "latestNumbersPageGlobalCasesTitle":
            MessageLookupByLibrary.simpleMessage("全球案例"),
        "latestNumbersPageGlobalDeaths":
            MessageLookupByLibrary.simpleMessage("全球死亡"),
        "latestNumbersPageLastUpdated": m6,
        "latestNumbersPageSourceGlobalStatsAttribution": m7,
        "latestNumbersPageTitle": MessageLookupByLibrary.simpleMessage("最近数字"),
        "latestNumbersPageTotalToggle":
            MessageLookupByLibrary.simpleMessage("总计"),
        "latestNumbersPageUpdating":
            MessageLookupByLibrary.simpleMessage("更新……"),
        "latestNumbersPageViewLiveData":
            MessageLookupByLibrary.simpleMessage("查看实时数据"),
        "legalLandingPageAnd": MessageLookupByLibrary.simpleMessage("和"),
        "legalLandingPageButtonAgree":
            MessageLookupByLibrary.simpleMessage("继续即表示您同意我们的"),
        "legalLandingPageButtonGetStarted":
            MessageLookupByLibrary.simpleMessage("开始"),
        "legalLandingPagePrivacyPolicyLinkText":
            MessageLookupByLibrary.simpleMessage("隐私政策"),
        "legalLandingPagePrivacyPolicyLinkUrl":
            MessageLookupByLibrary.simpleMessage(
                "https://www.who.int/myhealthapp/privacy-notice"),
        "legalLandingPageTermsOfServiceLinkUrl":
            MessageLookupByLibrary.simpleMessage(
                "https://www.who.int/myhealthapp/terms-of-use"),
        "legalLandingPageTitle":
            MessageLookupByLibrary.simpleMessage("官方 WANDE-19 信息应用程序"),
        "locationSharingPageButton":
            MessageLookupByLibrary.simpleMessage("允许位置共享"),
        "locationSharingPageDescription":
            MessageLookupByLibrary.simpleMessage("要获取本地新闻和信息，请选择您的祖国。"),
        "locationSharingPageTitle":
            MessageLookupByLibrary.simpleMessage("获取来自社区的最新消息"),
        "newsFeedSliverListNewsFeedItemDescription1":
            MessageLookupByLibrary.simpleMessage(
                "情况报告提供了关于新型 coronavis 爆发的最新消息。"),
        "newsFeedSliverListNewsFeedItemDescription2":
            MessageLookupByLibrary.simpleMessage(
                "来自世界卫生组织各地媒体的 coronavis 疾病（COWD-19）滚动更新。"),
        "newsFeedSliverListNewsFeedItemDescription3":
            MessageLookupByLibrary.simpleMessage("向媒体发布的所有新闻、声明和说明。"),
        "newsFeedSliverListNewsFeedItemDescription4":
            MessageLookupByLibrary.simpleMessage(
                "Coronavis 疾病（COADER-19）的新闻简报，包括视频、音频和记录。"),
        "newsFeedSliverListNewsFeedItemTitle1":
            MessageLookupByLibrary.simpleMessage("情况报告"),
        "newsFeedSliverListNewsFeedItemTitle2":
            MessageLookupByLibrary.simpleMessage("滚动更新"),
        "newsFeedSliverListNewsFeedItemTitle3":
            MessageLookupByLibrary.simpleMessage("新闻文章"),
        "newsFeedSliverListNewsFeedItemTitle4":
            MessageLookupByLibrary.simpleMessage("新闻简报"),
        "newsFeedSliverListNewsFeedItemUrl1": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/"),
        "newsFeedSliverListNewsFeedItemUrl2": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/events-as-they-happen"),
        "newsFeedSliverListNewsFeedItemUrl3": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/news"),
        "newsFeedSliverListNewsFeedItemUrl4": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/press-briefings"),
        "newsFeedTitle": MessageLookupByLibrary.simpleMessage("新闻与新闻"),
        "notificationsEnableDialogHeader":
            MessageLookupByLibrary.simpleMessage("启用通知"),
        "notificationsEnableDialogOptionLater":
            MessageLookupByLibrary.simpleMessage("可能稍后"),
        "notificationsEnableDialogOptionOpenSettings":
            MessageLookupByLibrary.simpleMessage("开放设置"),
        "notificationsEnableDialogText": MessageLookupByLibrary.simpleMessage(
            "由于您之前已禁用通知，我们需要您通过应用程序的系统设置手动重新启用通知"),
        "notificationsPagePermissionRequestPageButton":
            MessageLookupByLibrary.simpleMessage("允许通知"),
        "notificationsPagePermissionRequestPageDescription":
            MessageLookupByLibrary.simpleMessage(
                "要了解 CODAD-19 最新消息，请打开世界卫生组织的应用通知。"),
        "notificationsPagePermissionRequestPageTitle":
            MessageLookupByLibrary.simpleMessage("在 COADER-19 上随时掌握最新动态"),
        "protectYourselfHeader": MessageLookupByLibrary.simpleMessage("一般建议"),
        "protectYourselfListOfItemsPageListItem1":
            MessageLookupByLibrary.simpleMessage("*用肥皂和水洗手* 以避免生病和感染他人"),
        "protectYourselfListOfItemsPageListItem2":
            MessageLookupByLibrary.simpleMessage("*避免触摸你的眼睛、口腔和鼻子"),
        "protectYourselfListOfItemsPageListItem3":
            MessageLookupByLibrary.simpleMessage("*当你粘结或打喷时，用弯曲或组织盖住你的鼻子和鼻子*"),
        "protectYourselfListOfItemsPageListItem4":
            MessageLookupByLibrary.simpleMessage("*入住时间超过* 1 米（+3 英尺），远离生病的人"),
        "protectYourselfListOfItemsPageListItem5":
            MessageLookupByLibrary.simpleMessage(
                "只有在你或你照看的人生病时才会戴面罩（特别是 coughing）"),
        "protectYourselfTitle": MessageLookupByLibrary.simpleMessage("保护自己"),
        "travelAdviceContainerText": MessageLookupByLibrary.simpleMessage(
            "<p>他继续建议不要将旅行或贸易限制</b> 应用于正在经历 COVID - 19 突发事件的国家。 <b> </p> <p><b>对于生病的旅客，应谨慎对待延迟或避免前往受影响地区 </b> 的旅行，特别是老年人和慢性病或潜在健康状况的人。“受影响区域”被认为是指仅报告进口案例的国家、省、地区或城市。</p>"),
        "travelAdvicePageButtonGeneralRecommendations":
            MessageLookupByLibrary.simpleMessage("一般建议"),
        "travelAdvicePageButtonGeneralRecommendationsDescription":
            MessageLookupByLibrary.simpleMessage("了解 CODAD-19 的事实以及如何防止传播"),
        "travelAdvicePageButtonGeneralRecommendationsLink":
            MessageLookupByLibrary.simpleMessage(
                "https://www.who.int/emergencies/diseases/novel-coronavirus-2019"),
        "travelAdvicePageListItem1Text":
            MessageLookupByLibrary.simpleMessage("14 天症状自我监测，并遵循接收国的国家协议。"),
        "travelAdvicePageListItem2Text":
            MessageLookupByLibrary.simpleMessage("有些国家可能需要返回的旅客进入隔离状态。"),
        "travelAdvicePageListItem3Text": MessageLookupByLibrary.simpleMessage(
            "如果出现症状，我们建议旅客最好通过电话联系当地的医疗服务提供商，并告知他们自己的症状和旅行记录。"),
        "travelAdvicePageListTitle":
            MessageLookupByLibrary.simpleMessage("从受影响地区返回的旅客应："),
        "whoMythBustersListOfItemsPageListItem1":
            MessageLookupByLibrary.simpleMessage("上有很多虚假信息，这些都是事实"),
        "whoMythBustersListOfItemsPageListItem10":
            MessageLookupByLibrary.simpleMessage(
                "热扫描仪可以检测人们是否有发烧，但不能检测是否有人有玉米病毒"),
        "whoMythBustersListOfItemsPageListItem11":
            MessageLookupByLibrary.simpleMessage("在身体上喷洒酒精或氯气不会杀死已经进入身体的病毒"),
        "whoMythBustersListOfItemsPageListItem12":
            MessageLookupByLibrary.simpleMessage(
                "防刺疫苗，如气动疫苗和 B 类（Hib）疫苗等，不能提供防血保护"),
        "whoMythBustersListOfItemsPageListItem13":
            MessageLookupByLibrary.simpleMessage(
                "没有证据表明，经常用盐水漂洗鼻子可以保护人们免受科洋病毒的感染"),
        "whoMythBustersListOfItemsPageListItem14":
            MessageLookupByLibrary.simpleMessage(
                "大蒜是健康的，但目前的爆发没有证据表明吃大蒜已经保护了人们免受科洋病毒的影响"),
        "whoMythBustersListOfItemsPageListItem15":
            MessageLookupByLibrary.simpleMessage("抗生素不适用于病毒，抗生素仅用于抗菌"),
        "whoMythBustersListOfItemsPageListItem16":
            MessageLookupByLibrary.simpleMessage(
                "到目前为止，没有建议用具体药物来预防或治疗 coronavis"),
        "whoMythBustersListOfItemsPageListItem2":
            MessageLookupByLibrary.simpleMessage(
                "所有年龄的人都可能受到玉米病毒的感染。老年人和已经存在疾病的人（如哮喘、糖尿病、心脏病）似乎更容易受到病毒的严重感染"),
        "whoMythBustersListOfItemsPageListItem3":
            MessageLookupByLibrary.simpleMessage("寒冷的天气和雪不能杀死玉米病毒"),
        "whoMythBustersListOfItemsPageListItem4":
            MessageLookupByLibrary.simpleMessage("可以在气候炎热和潮湿的地区传播玉米病毒"),
        "whoMythBustersListOfItemsPageListItem5":
            MessageLookupByLibrary.simpleMessage("Coronavic 不能通过寄生传输"),
        "whoMythBustersListOfItemsPageListItem6":
            MessageLookupByLibrary.simpleMessage("没有证据表明伙伴动物/宠物（如狗或猫）可以传播科洋病毒"),
        "whoMythBustersListOfItemsPageListItem7":
            MessageLookupByLibrary.simpleMessage("热水澡不能预防玉米病毒"),
        "whoMythBustersListOfItemsPageListItem8":
            MessageLookupByLibrary.simpleMessage("手工干燥器不能有效地杀死 coronavis"),
        "whoMythBustersListOfItemsPageListItem9":
            MessageLookupByLibrary.simpleMessage("紫外线不应用于灭菌，并且可能会刺激皮肤")
      };
}
