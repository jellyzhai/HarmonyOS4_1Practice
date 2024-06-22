import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import Want from '@ohos.app.ability.Want';
import { CardMessageParams } from '../model/CardFormModel';
import formProvider from '@ohos.app.form.formProvider';

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    // Called to return a FormBindingData object.
    let formData = '';
    return formBindingData.createFormBindingData(formData);
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  // 定点或定时刷新, 当前在 10：30 会自动更新一次下面数据
  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
    const params = {
      city: '上海',
      temperature: '29'
    } as CardMessageParams
    const data = formBindingData.createFormBindingData(params)

    formProvider.updateForm(formId, data)
  }

  onChangeFormVisibility(newStatus: Record<string, number>) {
    // Called when the form provider receives form events from the system.
  }

  /*
   * @params message 来自 ’message‘ action 类型的事件中 params 参数的json 字符串
   * */
  onFormEvent(formId: string, message: string) {
    // Called when a specified message event defined by the form provider is triggered.
    if (message) {
      const params = JSON.parse(message) as CardMessageParams
      const data = formBindingData.createFormBindingData(params)

      formProvider.updateForm(formId, data)
    }
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
};