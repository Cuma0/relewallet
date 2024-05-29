// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OffersPageViewmodel on OffersPageViewmodelBase, Store {
  late final _$isLoadingOffersAtom =
      Atom(name: 'OffersPageViewmodelBase.isLoadingOffers', context: context);

  @override
  bool get isLoadingOffers {
    _$isLoadingOffersAtom.reportRead();
    return super.isLoadingOffers;
  }

  @override
  set isLoadingOffers(bool value) {
    _$isLoadingOffersAtom.reportWrite(value, super.isLoadingOffers, () {
      super.isLoadingOffers = value;
    });
  }

  late final _$OffersPageViewmodelBaseActionController =
      ActionController(name: 'OffersPageViewmodelBase', context: context);

  @override
  void isLoadingOffersChange() {
    final _$actionInfo = _$OffersPageViewmodelBaseActionController.startAction(
        name: 'OffersPageViewmodelBase.isLoadingOffersChange');
    try {
      return super.isLoadingOffersChange();
    } finally {
      _$OffersPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingOffers: ${isLoadingOffers}
    ''';
  }
}
