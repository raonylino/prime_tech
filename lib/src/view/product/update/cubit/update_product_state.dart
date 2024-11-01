part of 'update_product_cubit.dart';

@freezed
class UpdateProductState with _$UpdateProductState {
  const factory UpdateProductState.initial() = _Initial;
  const factory UpdateProductState.success() = _Success;
  const factory UpdateProductState.error(String message) = _Error;
  const factory UpdateProductState.loading() = _Loading;
}
