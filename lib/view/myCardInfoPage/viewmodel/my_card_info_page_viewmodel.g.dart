// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_card_info_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyCardInfoPageViewmodel on MyCardInfoPageViewmodelBase, Store {
  late final _$isLoadingUpdateAtom = Atom(
      name: 'MyCardInfoPageViewmodelBase.isLoadingUpdate', context: context);

  @override
  bool get isLoadingUpdate {
    _$isLoadingUpdateAtom.reportRead();
    return super.isLoadingUpdate;
  }

  @override
  set isLoadingUpdate(bool value) {
    _$isLoadingUpdateAtom.reportWrite(value, super.isLoadingUpdate, () {
      super.isLoadingUpdate = value;
    });
  }

  late final _$newBarcodeNoAtom =
      Atom(name: 'MyCardInfoPageViewmodelBase.newBarcodeNo', context: context);

  @override
  String? get newBarcodeNo {
    _$newBarcodeNoAtom.reportRead();
    return super.newBarcodeNo;
  }

  @override
  set newBarcodeNo(String? value) {
    _$newBarcodeNoAtom.reportWrite(value, super.newBarcodeNo, () {
      super.newBarcodeNo = value;
    });
  }

  late final _$isLoadingDeleteAtom = Atom(
      name: 'MyCardInfoPageViewmodelBase.isLoadingDelete', context: context);

  @override
  bool get isLoadingDelete {
    _$isLoadingDeleteAtom.reportRead();
    return super.isLoadingDelete;
  }

  @override
  set isLoadingDelete(bool value) {
    _$isLoadingDeleteAtom.reportWrite(value, super.isLoadingDelete, () {
      super.isLoadingDelete = value;
    });
  }

  late final _$MyCardInfoPageViewmodelBaseActionController =
      ActionController(name: 'MyCardInfoPageViewmodelBase', context: context);

  @override
  void isLoadingUpdateChange() {
    final _$actionInfo = _$MyCardInfoPageViewmodelBaseActionController
        .startAction(name: 'MyCardInfoPageViewmodelBase.isLoadingUpdateChange');
    try {
      return super.isLoadingUpdateChange();
    } finally {
      _$MyCardInfoPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewBarcodeNo(String newNo) {
    final _$actionInfo = _$MyCardInfoPageViewmodelBaseActionController
        .startAction(name: 'MyCardInfoPageViewmodelBase.setNewBarcodeNo');
    try {
      return super.setNewBarcodeNo(newNo);
    } finally {
      _$MyCardInfoPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingDeleteChange() {
    final _$actionInfo = _$MyCardInfoPageViewmodelBaseActionController
        .startAction(name: 'MyCardInfoPageViewmodelBase.isLoadingDeleteChange');
    try {
      return super.isLoadingDeleteChange();
    } finally {
      _$MyCardInfoPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingUpdate: ${isLoadingUpdate},
newBarcodeNo: ${newBarcodeNo},
isLoadingDelete: ${isLoadingDelete}
    ''';
  }
}
