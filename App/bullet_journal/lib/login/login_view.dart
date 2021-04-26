import 'dart:ui';
import 'package:bullet_journel/assets/icons/db_icons.dart';
import 'package:bullet_journel/snap_photo/snap_photo_view.dart';
import 'package:bullet_journel/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

bool isObscured = true;
LoginViewModel loginViewModel = LoginViewModel();
TextEditingController userController = new TextEditingController(),
    passController = new TextEditingController();
double widthOfContext, heightOfContext;
bool isTapLogin = true;

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
    widthOfContext = MediaQuery.of(context).size.width;
    heightOfContext = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: heightOfContext,
          child: Stack(
            children: [
              setLoginBackGround(),
              Align(alignment: Alignment.bottomCenter, child: buildWidget()),
            ],
          ),
        ),
      ),
    );
  }

  void onLoginPressed() {
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => SnapPhotoView()),
    //     (Route<dynamic> route) => false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SnapPhotoView()));
  }

  Widget setLoginBackGround() {
    return Container(
      height: heightOfContext,
      width: widthOfContext,
      decoration: BoxDecoration(
        color: Colors.pink[100].withOpacity(0.3),
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.pink.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg_login_1.jpg')),
      ),
    );
  }

  Widget buildWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: heightOfContext * 0.1,
            // ),
            buildIcon(),
            buildTextIntro(),
            SizedBox(
              height: heightOfContext * 0.2,
              width: widthOfContext,
            ),
            //Set login container
            Container(
              // height: heightOfContext * 0.5,
              // color: Colors.black,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),

              ///da xoa single scroll view
              child: Column(
                children: <Widget>[
                  buildTab(),
                  buildLoginTab(),
                ],
              ),
            ),
            SizedBox(
              height: heightOfContext * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTab() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              setState(() {
                isTapLogin = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  // color: Colors.red,
                  color: isTapLogin ? Colors.red : Colors.transparent,
                  thickness: 4,
                  // endIndent: 30,
                ),
              ]),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              setState(() {
                isTapLogin = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: !isTapLogin ? Colors.red : Colors.transparent,
                  thickness: 4,
                ),
              ]),
            ),
          ),
        ),
        Expanded(flex: 4, child: SizedBox())
      ],
    );
  }

  Widget buildUsernameWidget() {
    return StreamBuilder<String>(
        stream: loginViewModel.userStream,
        builder: (context, snapshot) {
          return TextField(
            controller: userController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
                suffixIcon: Icon(
                  LoginViewIcon.iconly_light_outline_profile,
                  color: Colors.white,
                ),
                errorText: snapshot.hasData ? snapshot.data : null,
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.white,
                    )),
                hintText: 'Type your username',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 16)),
          );
        });
  }

  Widget buildPasswordWidget() {
    return StreamBuilder<String>(
        stream: loginViewModel.passStream,
        builder: (context, snapshot) {
          return TextField(
            controller: passController,
            cursorColor: Colors.white,
            obscureText: isObscured,
            style: TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
                // errorText: snapshot.hasData ? snapshot.data : null,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                      isObscured
                          ? LoginViewIcon.iconly_light_outline_hide
                          : VisibilityIcon.iconly_light_outline_show,
                      color: Colors.white,
                    )),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Type your password',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 16)),
          );
        });
  }

  Widget buildIcon() {
    return Container(
      height: widthOfContext * 0.3,
      width: widthOfContext * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage('assets/icons/icon_cat.png'),
          fit: BoxFit.contain,
          // colorFilter: ColorFilter.mode(
          //     Colors.pink.withOpacity(0.7), BlendMode.dstATop)
        ),
      ),
    );
  }

  Widget buildTextIntro() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        'Your life, your style',
        style: GoogleFonts.dancingScript(
            letterSpacing: 0.5,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            // wordSpacing: 1
            shadows: [
              Shadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1,
                  offset: Offset(4, 4))
            ]),
      ),
    );
  }

  Widget buildLoginTab() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          buildUsernameWidget(),
          SizedBox(
            height: 10,
          ),
          buildPasswordWidget(),
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
                        color: Colors.white.withOpacity(0.5), fontSize: 16),
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
            height: 20,
          ),
          SizedBox(
            width: widthOfContext,
            height: 60,
            child: StreamBuilder<bool>(
                stream: loginViewModel.loginStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    onPressed: onLoginPressed,
                    // !snapshot.hasData || !snapshot.data
                    //     ? null
                    //     : onLoginPressed,
                    color: const Color(0xffD93025),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
