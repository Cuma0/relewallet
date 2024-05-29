// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_settings_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AdvancedSettingsPageViewmodel
    on AdvancedSettingsPageViewmodelBase, Store {
  late final _$isCheckedNameAtom = Atom(
      name: 'AdvancedSettingsPageViewmodelBase.isCheckedName',
      context: context);

  @override
  bool get isCheckedName {
    _$isCheckedNameAtom.reportRead();
    return super.isCheckedName;
  }

  @override
  set isCheckedName(bool value) {
    _$isCheckedNameAtom.reportWrite(value, super.isCheckedName, () {
      super.isCheckedName = value;
    });
  }

  late final _$isCheckedDateAtom = Atom(
      name: 'AdvancedSettingsPageViewmodelBase.isCheckedDate',
      context: context);

  @override
  bool get isCheckedDate {
    _$isCheckedDateAtom.reportRead();
    return super.isCheckedDate;
  }

  @override
  set isCheckedDate(bool value) {
    _$isCheckedDateAtom.reportWrite(value, super.isCheckedDate, () {
      super.isCheckedDate = value;
    });
  }

  late final _$AdvancedSettingsPageViewmodelBaseActionController =
      ActionController(
          name: 'AdvancedSettingsPageViewmodelBase', context: context);

  @override
  void changeisChecked(
      {required bool newisCheckedName,
      required bool newisCheckedDate,
      required List<MyCardModel>? list}) {
    final _$actionInfo = _$AdvancedSettingsPageViewmodelBaseActionController
        .startAction(name: 'AdvancedSettingsPageViewmodelBase.changeisChecked');
    try {
      return super.changeisChecked(
          newisCheckedName: newisCheckedName,
          newisCheckedDate: newisCheckedDate,
          list: list);
    } finally {
      _$AdvancedSettingsPageViewmodelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isCheckedName: ${isCheckedName},
isCheckedDate: ${isCheckedDate}
    ''';
  }
}
