part of 'photo_gallery_cubit.dart';

@immutable
sealed class PhotoGalleryState {}

final class PhotoGalleryInitial extends PhotoGalleryState {}

final class PhotoGalleryUploading extends PhotoGalleryState {}

final class PhotoGallerySuccess extends PhotoGalleryState {
  final List<File> imageFiles;

  PhotoGallerySuccess(this.imageFiles);
}

final class PhotoGalleryError extends PhotoGalleryState {
  final String message;

  PhotoGalleryError(this.message);
}
