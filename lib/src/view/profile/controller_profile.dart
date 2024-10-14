import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ControllerProfile {
 static User? user;
//  ------------------ User --------------------------------
  static Future<User?> getUser() async {
    user = FirebaseAuth.instance.currentUser;
    log('User: $user');
    return user;
  }
  //  ------------------ Name --------------------------------

  static Future<void> updateUserName(String newName,Function(bool) onSuccess) async {
    try {
      await user?.updateDisplayName(newName);
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
          'name': newName,
        });
        log('Nome atualizado no Firestore para: $newName');
        onSuccess(true);
      }
    } catch (e) {
      log(e.toString());
      onSuccess(false);
    }

  }
 //  ------------------ Password --------------------------------

   static Future<void> changePassword(String newPassword,Function(bool) onSuccess) async {
    try {
      if (user != null) {
      await user?.updatePassword(newPassword);
        log('Password atualizado');
        onSuccess(true);
      }
    } catch (e) {
      log(e.toString());
      onSuccess(false);
    }

  }

  //  ------------------ Image --------------------------------

  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

 
  static Future<String?> uploadImage(File image) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      Reference storageRef = FirebaseStorage.instance.ref().child('profilePictures/$userId.jpg');


      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;


      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }


  static Future<void> updateProfilePicture(String photoUrl) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Atualiza a URL da foto de perfil
        await user.updatePhotoURL(photoUrl);
        await user.reload(); // Recarrega o perfil do usuário para refletir a mudança
      }
    } catch (e) {
      log('Erro ao atualizar a foto de perfil: $e');
      throw FirebaseAuthException(
        code: 'profile-picture-update-failed',
        message: 'Erro ao atualizar a foto de perfil.',
      );
    }
  }
  
  
  // ------------------ Sign Out --------------------------------
  static Future<void> signOut() async {
    log('Sign Out');
    await FirebaseAuth.instance.signOut();
  }
}
