import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../cardsPage/model/my_card_model/my_card_model.dart';
part 'advanced_settings_page_viewmodel.g.dart';

class AdvancedSettingsPageViewmodel = AdvancedSettingsPageViewmodelBase
    with _$AdvancedSettingsPageViewmodel;

abstract class AdvancedSettingsPageViewmodelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => myContext = context;

  void init() {}

  @observable
  bool isCheckedName = false;

  @observable
  bool isCheckedDate = true;

  @action
  void changeisChecked(
      {required bool newisCheckedName,
      required bool newisCheckedDate,
      required List<MyCardModel>? list}) {
    isCheckedName = newisCheckedName;
    isCheckedDate = newisCheckedDate;
  }
}
