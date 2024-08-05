import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
                onTap: () async {
                  String code;
                  String country;
                  setState(() {
                    if (context.locale.languageCode == 'en') {
                      code = "ar";
                      country = "LY";
                    } else {
                      code = "en";
                      country = "US";
                    }
                    EasyLocalization.of(context)!
                        .setLocale(Locale(code, country));
                  });
                },
                child: const Icon(
                  Icons.language,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/to_do.jpg',
                  width: screenSize.width,
                  // height: screenSize.height * 0.6,
                ),
                SizedBox(height: 30),
                Text(
                  "organizeYourLife".tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.07,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "startPageSubtitle".tr(),
                  style: TextStyle(
                      color: Colors.grey, fontSize: screenSize.width * 0.04),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height * 0.12),
                goToSignUpScreenButton(context, screenSize),
                SizedBox(height: 10),
                goToSignInScreenButton(context, screenSize),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget goToSignInScreenButton(BuildContext context, Size screenSize) {
    return InkWell(
      onTap: () {
        context.go('/login');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: screenSize.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Center(
            child: Text(
          "signIn".tr(),
          style: TextStyle(
              fontSize: screenSize.width * 0.04, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  Widget goToSignUpScreenButton(BuildContext context, Size screenSize) {
    return InkWell(
      onTap: () {
        context.go('/signup');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        // height: screenSize.height*0.05,
        width: screenSize.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.indigo,
        ),
        child: Center(
            child: Text(
          "createAccount".tr(),
          style: TextStyle(
              fontSize: screenSize.width * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
