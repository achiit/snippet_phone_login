import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partyapp/models/user.dart';
import 'package:partyapp/services/firebase_service.dart';

class SignUpViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String phonenumber = '';
  File? profileImage;
  File? image;
  ValueNotifier<bool> termsCheck = ValueNotifier(false);
  final FirebaseService _firebaseService;

  SignUpViewModel(this._firebaseService);

  Future<String?> uploadProfilePic(File image) async {
    // Upload image to Firebase Storage
    final imageUrl = await _firebaseService.uploadImage(image);

    // Notify listeners about the updated image URL
    notifyListeners();

    return imageUrl;
  }

  Future<void> uploadUserDetails({
    required String name,
    required String city,
    required String fathername,
    required String dob,
    required String aadhar,

    // required String phoneNumber,
    required String imageUrl,
  }) async {
    // Create a new user object
    final newUser = User(
      id: _firebaseService.generateUserId(), // Generate a unique user ID
      name: name,
      city: city,
      fathername: fathername,
      dob: dob,
      aadhar: aadhar,
      // phoneNumber: phoneNumber,
      imageUrl: imageUrl,
    );

    // Upload user details to Realtime Database
    await _firebaseService.uploadUserDetails(newUser);
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _getImage(ImageSource.gallery); // Open gallery
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera); // Open camera
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to get image from gallery or camera
  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image = File(pickedFile.path); // Set selected image
      print("image selected");
      notifyListeners();
    }
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void updatePhoneNo(String newPhoneNo) {
    phonenumber = newPhoneNo;
    notifyListeners();
  }

  // void loginUser(BuildContext context) {
  //   // Simulating authentication
  //   final user = User(email: email, password: password);
  //   user.authenticate();
  // }
  bool validateTerms() {
    if (!termsCheck.value) {
      return false;
    }
    return true;
  }

  void toogleTerms() {
    // Simulating checkbox state change
    termsCheck.value = !termsCheck.value;
    notifyListeners();
    print(termsCheck);
  }
}
