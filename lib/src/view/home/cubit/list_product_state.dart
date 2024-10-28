part of 'list_product_cubit.dart';

@freezed
class ListProductState with _$ListProductState {
  const factory ListProductState.initial() = _Initial;
  const factory ListProductState.data({
    required List<ProductModel> products
  }) = _Products;
  const factory ListProductState.error({
    required String string,
    required String error,
  }) = _Error;
  const factory ListProductState.loading() = _Loading;
  const factory ListProductState.success() = _Success;
}
