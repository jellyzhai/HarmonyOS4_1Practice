// 不同 UIAbility 对应不同 UIAbilityContext 的 preference
import preferences from '@ohos.data.preferences'
import { Context } from '@ohos.abilityAccessCtrl'

// preference 实例定义在全局中，所以 ability 销毁后，需要调用
// removePreferencesFromCacheSync(context: Context, name: string): void;
// 从内存中删除，提高性能；

export const ENTRY_ABILITY_PREFERENCE = 'ENTRY_ABILITY_PREFERENCE'
export const DARK_MODE_KEY = 'DARK_MODE_KEY'

// ability 上下文中的单例对象，当 ability 销毁后，当前对象应该会自动释放内存
class EntryAbilityPreference {
  private preference!: preferences.Preferences

  create(context: Context, name: 'ENTRY_ABILITY_PREFERENCE') {
    this.preference = preferences.getPreferencesSync(context, {name})
  }

  getPreference() {
    return this.preference
  }
}

export const entryAbilityPreference = new EntryAbilityPreference()