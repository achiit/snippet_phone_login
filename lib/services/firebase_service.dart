import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:partyapp/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final _storage = FirebaseStorage.instance;
  final _database = FirebaseDatabase.instance.reference();

  Future<String> uploadImage(File image) async {
    final ref =
        _storage.ref().child('profile_pics').child('${DateTime.now()}.jpg');
    final uploadTask = ref.putFile(image);

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> uploadUserDetails(User user) async {
    try {
      await _database.child('users').child(user.id).set({
        'name': user.name,
        'city': user.city,
        'fathername': user.fathername,
        'dob': user.dob,
        'aadhar': user.aadhar,
        // 'phoneNumber': user.phoneNumber,
        'imageUrl': user.imageUrl,
      });
      log("done user created");
    } catch (e) {
      log(e.toString());
    }
  }

  String generateUserId() {
    // Implement your logic to generate a unique user ID
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
