import 'dart:io';
import 'package:forsanway/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/homePage.dart';
import 'package:forsanway/views/homePage/homeNavigation.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:forsanway/widgets/textField.dart';
import 'package:image_picker/image_picker.dart';
import '../loginRegistration/login.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  // --------------------------------REGISTRATION FORM PARAMETERS-------------------------------
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final phoneNumber = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordControler = new TextEditingController();
  final identityNumberController = new TextEditingController();
  final mobileNumberController = new TextEditingController();
  String male = 'Mr';
  String female = 'Mrs';
  String id = 'NID';
  String passPort = 'Passport';
  bool obscureText = true;
  bool obscureConfirmText = true;
  String email = '';
  PickedFile imageToUpload;
  ImagePicker _picker = new ImagePicker();
  String title = 'Mr';
  String identityType = 'NID';
// ----------------------------------REGISTER & CURRENT USER AUTH-------------------------------
  UserServices _userService = new UserServices();
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return email.length == 0 ? register() : HomePage();
  }

  Widget register() {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: white,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 30),
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), color: blue),
              child: Column(
                children: [
                  CustomText(
                    text: 'Create your account',
                    color: white,
                    size: 19,
                  ),
                  Expanded(child: Hero(
                    tag:'login',
                    child: Image.asset('assets/images/logo.png')))
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * .7,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: grey[100]),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 10),
                        GestureDetector(
                            child: imageToUpload == null
                                ? CircleAvatar(
                                    backgroundColor: blue,
                                    radius: 50,
                                    // backgroundImage: NetworkImage(user[0].image.length == 0
                                    //     ? '${ApiUrls.nullImage}'
                                    //     : '${ApiUrls.imageUrl + user[0].image}'),
                                    child: Icon(Icons.image),
                                  )
                                : ClipOval(
                                    child: Image.file(
                                      File(imageToUpload.path),
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                            // ignore: deprecated_member_use
                            onTap: () => selectProfileImage(_picker.getImage(source: ImageSource.gallery)).then((value) {
                                  if (imageToUpload != null) {
                                    // showRequestDialog();
                                  }
                                })),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: grey[300]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                    child: DropdownButtonHideUnderline(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: DropdownButton(
                                          icon: Icon(Icons.arrow_drop_down, color: black),
                                          style: TextStyle(color: white),
                                          hint: CustomText(
                                            text: 'Select Title',
                                            color: white,
                                          ),
                                          value: title.isNotEmpty ? title : null,
                                          onChanged: (val) {
                                            setState(() {
                                              title = val;
                                            });
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              child: CustomText(text: 'Mr', size: 16),
                                              value: male,
                                            ),
                                            DropdownMenuItem(
                                              child: CustomText(text: 'Mrs', size: 16),
                                              value: female,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: LoginTextField(
                                radius: 15,
                                hint: 'Full Names',
                                controller: nameController,
                                validator: (v) {
                                  if (v.isEmpty) {
                                    return 'Names cannot be left empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        LoginTextField(
                          radius: 15,
                          hint: 'Email Address',
                          controller: emailController,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Email Cannot be empty';
                            }
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(v))
                              return 'Please make sure your email address format is valid';
                            else
                              return null;
                          },
                        ),
                        SizedBox(height: 6),
                        LoginTextField(
                          radius: 15,
                          textInputType: TextInputType.numberWithOptions(),
                          hint: 'Mobile Number',
                          controller: mobileNumberController,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Email Cannot be empty';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: 6),
                        LoginTextField(
                          iconTwo: obscureText == true
                              ? IconButton(
                                  icon: Icon(Icons.lock),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = false;
                                    });
                                  })
                              : IconButton(
                                  icon: Icon(Icons.lock_open),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = true;
                                    });
                                  }),
                          obscure: obscureText,
                          radius: 15,
                          hint: 'Password',
                          controller: passwordController,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Password cannot be left empty';
                            }
                            if (v.length < 6) {
                              return 'the password length must be greather than 6';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 6),
                        LoginTextField(
                          iconTwo: obscureConfirmText == true
                              ? IconButton(
                                  icon: Icon(Icons.lock),
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmText = false;
                                    });
                                  })
                              : IconButton(
                                  icon: Icon(Icons.lock_open),
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmText = true;
                                    });
                                  }),
                          obscure: obscureConfirmText,
                          radius: 15,
                          hint: 'Confirm Password',
                          controller: confirmPasswordControler,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'this field cannot be left empty';
                            }
                            if (v.length < 6) {
                              return 'the password length must be greather than 6';
                            }
                            if (confirmPasswordControler.text != passwordController.text) {
                              return 'The passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: grey[300]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                  child: DropdownButtonHideUnderline(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: DropdownButton(
                                        icon: Icon(Icons.arrow_drop_down, color: black),
                                        style: TextStyle(color: white),
                                        hint: CustomText(
                                          text: 'Select Identity Type',
                                          color: white,
                                        ),
                                        value: identityType.isNotEmpty ? identityType : null,
                                        onChanged: (val) {
                                          setState(() {
                                            identityType = val;
                                          });
                                        },
                                        items: [
                                          DropdownMenuItem(
                                            child: CustomText(text: 'NID', size: 16),
                                            value: id,
                                          ),
                                          DropdownMenuItem(
                                            child: CustomText(text: 'Passport', size: 16),
                                            value: passPort,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: LoginTextField(
                                // iconTwo: obscureText == true ? Icon(Icons.lock) : Icon(Icons.lock_open),
                                textInputType: TextInputType.numberWithOptions(),
                                // obscure: true,
                                radius: 15,
                                hint: 'Identity Number',
                                controller: identityNumberController,
                                validator: (v) {
                                  if (v.isEmpty) {
                                    return 'Identity number cannot be left empty';
                                  }
                                  // if (v.length < 6) {
                                  //   return 'the password length must be greather than 6';
                                  // }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        CustomFlatButton(
                          radius: 30,
                          icon: Icons.check,
                          iconColor: white,
                          text: 'Sign Up',
                          textColor: white,
                          callback: () => signUp(),
                        ),
                        SizedBox(height: 6),
                        CartItemRich(
                          lightFont: 'Already have an account? ',
                          boldFont: 'Sign In',
                          callback: () {
                            changeScreenReplacement(context, SignIn());
                          },
                        ),
                        SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: loading == true,
              child: Center(
                child: Loading(),
              ),
            )
          ],
        ),
      ),
    );
  }

  signUp() async {
    if (imageToUpload != null) {
      if (formKey.currentState.validate()) {
        setState(() {
          loading = true;
        });
        await _userService.createUser(title, nameController.text, emailController.text, mobileNumberController.text, passwordController.text,
            confirmPasswordControler.text, identityType, identityNumberController.text, context);

        setState(() {
          loading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CustomText(text: 'You need to pick an image first', color: red, size: 15)));
    }
  }

  selectProfileImage(Future<PickedFile> pickImage) async {
    PickedFile selectedProfileImage = await pickImage;
    setState(() {
      imageToUpload = selectedProfileImage;
    });
  }
}
