import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/animations/fade_in_slide.dart';
import 'package:partyapp/config/color_config.dart';
import 'package:partyapp/services/firebase_service.dart';
import 'package:partyapp/viewmodels/auth_VM.dart';
import 'package:partyapp/viewmodels/signup_VM.dart';
import 'package:partyapp/widgets/background_template.dart';
import 'package:partyapp/widgets/submitbutton.dart';
import 'package:partyapp/widgets/textfield.dart';
import 'package:provider/provider.dart';

class GetAllDetailsScreen extends StatefulWidget {
  const GetAllDetailsScreen({Key? key});

  @override
  State<GetAllDetailsScreen> createState() => _GetAllDetailsScreenState();
}

class _GetAllDetailsScreenState extends State<GetAllDetailsScreen> {
  TextEditingController _fathernameController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController();

  String dob = "2024-12-12";
  TextEditingController _aadharController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final signupViewModel = Provider.of<SignUpViewModel>(context);
    final authViewModel =
        Provider.of<AuthViewModel>(context); // Provide AuthViewModel

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider(
        create: (_) => SignUpViewModel(context.read<FirebaseService>()),
        child: Builder(builder: (context) {
          return StackTemplate(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Enter your details",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  FadeInSlide(
                    duration: 0.5,
                    child: InkWell(
                        onTap: () async {
                          signupViewModel.showImagePicker(context);
                        },
                        child: Ink(
                          child: CircleAvatar(
                            radius: screenWidth * 0.138,
                            backgroundColor: AppColors.buttonColor,
                            child: signupViewModel.image != null
                                ? CircleAvatar(
                                    radius: screenWidth * 0.13,
                                    backgroundImage:
                                        FileImage(signupViewModel.image!),
                                  )
                                : Icon(
                                    Icons.person_outline,
                                    size: screenWidth * 0.18,
                                    color: Colors.black,
                                  ),
                          ),
                        )),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  FadeInSlide(
                    duration: 0.6,
                    child: CustomTextField(
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }

                        return null;
                      },
                      controller: name,
                      hintText: "Full Name",
                      icon: Icons.person_outline,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }

                      return null;
                    },
                    controller: _fathernameController,
                    hintText: 'Father\'s Name',
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(400, 60),
                      side: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xff1f2128),
                      elevation: 0,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 27,
                          color: Colors.grey[700],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Text(
                            dob.substring(0, 10),
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  FadeInSlide(
                    duration: 0.6,
                    child: CountryStateCityPicker(
                        city: city,
                        containerColor: const Color(0xff1f2128),
                        dialogColor: Colors.grey.shade200,
                        textFieldDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          hintStyle: TextStyle(color: Colors.grey[700]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 2.0),
                          ),
                        )),
                  ),
                  SizedBox(height: screenHeight * 0.023),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your 12 digit Aadhar Number';
                      }

                      return null;
                    },
                    controller: _aadharController,
                    hintText: 'Aadhar Number',
                    icon: Icons.credit_card_outlined,
                    type: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  SubmitButton(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onPressed: () async {
                      final imageUrl = await signupViewModel
                          .uploadProfilePic(signupViewModel.image!);
                      await signupViewModel.uploadUserDetails(
                        dob: dob,
                        aadhar: _aadharController.text,
                        fathername: _fathernameController.text,
                        name: name.text,
                        city: city.text,
                        // phoneNumber: phoneController.text,
                        imageUrl: imageUrl!,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != dob) {
      setState(() {
        dob = pickedDate.toString();
      });
    }
  }
}
