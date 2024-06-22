import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import preferences from '@ohos.data.preferences';
import { entryAbilityPreference, ENTRY_ABILITY_PREFERENCE } from '../model/PreferencesModel';
import { windowOperationUtil } from '../utils/windowOperation';
import { CardRouterParams, CardParamsMessage } from '../model/CardFormModel';

const cardLocalStorage = new LocalStorage()
let cardParamsPageUri = ''

export default class EntryAbility extends UIAbility {

  cardParamsHandler(want: Want) {
    if (want.parameters.params) {
      const cardParams = want.parameters.params as CardRouterParams

      if (!cardParams.cardPageUri) {
        cardParamsPageUri = ''
        cardLocalStorage.delete(CardParamsMessage)
        return
      }
      hilog.info(0x11111, 'test_tag', 'cardParams: ', JSON.stringify(cardParams))

      cardParamsPageUri = cardParams.cardPageUri
      cardLocalStorage.setOrCreate(CardParamsMessage, cardParams.cardMessage)
    }
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    AppStorage.setOrCreate('uiAbilityContext', this.context)

    // 在ability创建后，创建单例对象，其中保存 能力上下文中的唯一 首选项对象
    entryAbilityPreference.create(this.context, ENTRY_ABILITY_PREFERENCE)

    this.cardParamsHandler(want)
  }

  // 单例模式下，其他ability使用 ，调用 this.context.startAbility(want: Want) 打开当前 ability
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.cardParamsHandler(want)
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    // 在其他 feature ability 的onDestroy 中，需要执行删除操作，减少内存占用，提升性能
    // 在 entry ability 中需要，因为 入口能力销毁，整个应用就销毁了，应用上下文中的对象等都会被释放内存
    preferences.removePreferencesFromCache(this.context, ENTRY_ABILITY_PREFERENCE).then(() => {
      hilog.info(0x0000, 'test_tag', '从内存中删除 preference 成功');
    })
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowOperationUtil.setWindowStage(windowStage)

    if (cardParamsPageUri) {
      windowStage.loadContent(cardParamsPageUri, cardLocalStorage, (err) => {
        if (err.code) {
          hilog.error(0x0000, 'test_tag', 'Failed to load the 卡片启动的页面. Cause: %{public}s', JSON.stringify(err) ?? '');
          return;
        }
        hilog.info(0x0000, 'test_tag', 'Succeeded in loading the 卡片启动的页面.');
      });
    }

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
