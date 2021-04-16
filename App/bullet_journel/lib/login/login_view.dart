import 'dart:ui';
import 'package:bullet_journel/assets/icons/db_icons.dart';
import 'package:bullet_journel/edit_image/edit_image_view.dart';
import 'package:bullet_journel/login/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

bool isObscured = true;
LoginViewModel loginViewModel = LoginViewModel();
TextEditingController userController = new TextEditingController(),
    passController = new TextEditingController();

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    userController.addListener(() {
      loginViewModel.userSink.add(userController.text);
    });
    passController.addListener(() {
      loginViewModel.passSink.add(passController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.pink[100].withOpacity(0.3),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.pink.withOpacity(0.2), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg_login_1.jpg')),
              ),
            ),
            SizedBox(
              height: height * 0.4,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.5,
                      width: width,
                    ),
                    Container(
                      // color: Colors.black,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: width,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Divider(
                                          // color: Colors.red,
                                          color: Colors.red,
                                          thickness: 4,
                                          endIndent: 30,
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Register',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          thickness: 4,
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Expanded(flex: 4, child: SizedBox())
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            StreamBuilder<String>(
                                stream: loginViewModel.userStream,
                                builder: (context, snapshot) {
                                  return TextField(
                                    controller: userController,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          LoginViewIcon
                                              .iconly_light_outline_profile,
                                          color: Colors.white,
                                        ),
                                        errorText: snapshot.hasData
                                            ? snapshot.data
                                            : null,
                                        labelText: 'Username',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        fillColor:
                                            Colors.white.withOpacity(0.2),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            )),
                                        hintText: 'Type your username',
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 16)),
                                  );
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<String>(
                                stream: loginViewModel.passStream,
                                builder: (context, snapshot) {
                                  return TextField(
                                    controller: passController,
                                    cursorColor: Colors.white,
                                    obscureText: isObscured,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    decoration: InputDecoration(
                                        errorText: snapshot.hasData
                                            ? snapshot.data
                                            : null,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isObscured = !isObscured;
                                              });
                                            },
                                            icon: Icon(
                                              isObscured
                                                  ? LoginViewIcon
                                                      .iconly_light_outline_hide
                                                  : VisibilityIcon
                                                      .iconly_light_outline_show,
                                              color: Colors.white,
                                            )),
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        fillColor:
                                            Colors.white.withOpacity(0.2),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        hintText: 'Type your password',
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 16)),
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Divider(
                                    color: Colors.white.withOpacity(0.5),
                                    thickness: 2,
                                    indent: 10,
                                    endIndent: 5,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      'Or',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Divider(
                                    color: Colors.white.withOpacity(0.5),
                                    thickness: 2,
                                    indent: 5,
                                    endIndent: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: width,
                              height: 60,
                              child: RaisedButton(
                                onPressed: onLoginPressed,
                                color: const Color(0xffD93025),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLoginPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditImageView(),
        ));
  }
}
