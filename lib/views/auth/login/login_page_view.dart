
import 'package:chopnow/common/size.dart';
import 'package:chopnow/views/auth/login/login_page.dart';
import 'package:chopnow/views/auth/login/widget/pin_login.dart';
import 'package:flutter/material.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: height / 1.25,
            width: width,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: false,
              children: [
                LoginPage(next: () {
                     _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),  // Reduced duration
                      curve: Curves.easeIn,
                    );
                  
                }),
                const LoginPinPage()
              ],
            ),
          )
        ],
      ),
    );
  }
}
