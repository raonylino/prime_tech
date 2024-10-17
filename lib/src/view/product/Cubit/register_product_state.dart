part of 'register_product_cubit.dart';

@freezed
class RegisterProductState with _$RegisterProductState {
  const factory RegisterProductState.initial() = _Initial;
  const factory RegisterProductState.loading() = _Loading;
  const factory RegisterProductState.data({required List<ProductModel> sales}) = _Data;
  const factory RegisterProductState.error({required String error}) = _Error;
}