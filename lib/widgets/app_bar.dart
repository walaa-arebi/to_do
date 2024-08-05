import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String? titleText;
  final Widget? actionWidget;
  final bool centeredTitle;

  CustomAppBar(
    BuildContext context, {
    super.key,
    this.centeredTitle = false,
    this.titleText,
    this.actionWidget,
  }) : super(
            backgroundColor: Colors.indigo,
            titleSpacing: 20,
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            title: titleText != null
                ? Text(
                    titleText.tr(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : null,
            centerTitle: centeredTitle,
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                    onTap: () async {
                      String code;
                      String country;
                      if (context.locale.languageCode == 'en') {
                        code = "ar";
                        country = "LY";
                      } else {
                        code = "en";
                        country = "US";
                      }
                      EasyLocalization.of(context)!
                          .setLocale(Locale(code, country));
                    },
                    child: const Icon(
                      Icons.language,
                      color: Colors.white,
                    )),
              ),
              actionWidget ?? Container()
            ]);
}
