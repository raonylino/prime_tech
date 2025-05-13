import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'photo_gallery_state.dart';

class PhotoGalleryCubit extends Cubit<PhotoGalleryState> {
  PhotoGalleryCubit() : super(PhotoGalleryInitial());
}
