import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());

    try {
      await Future.delayed(Duration(seconds: 2));

      final name = 'Rodrigo Pereira';
      final email = 'teste@teste.com';

      emit(ProfileLoaded(name: name, email: email));
    } catch (e) {
      emit(ProfileError('Erro ao carregar o perfil'));
    }
  }
}
