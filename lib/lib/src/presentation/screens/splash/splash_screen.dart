// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final String _switchLogo = "";
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, Routes.mainScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ColorSchemes.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: _switchLogo.isEmpty
              ? Stack(fit: StackFit.expand, children: [
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   width: 220,
                      //   height: 220,
                      //   "ImagePaths.splashLogo",
                      // ),
                      Container(
                        color: ColorSchemes.iconBackGround,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Text(
                            "stayConnectedStaySmarter",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorSchemes.black,
                                      fontWeight: Constants.fontWeightMedium,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 102,
                      ),
                    ],
                  )),
                  Positioned(
                      bottom: 150,
                      right: 0,
                      left: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${"poweredBy"}  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  ),
                            ),
                            Text(
                              "cityEye",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                            )
                          ])),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   left: 0,
                  //   child: SvgPicture.asset(
                  //     width: MediaQuery.sizeOf(context).width,
                  //     "ImagePaths.splashBackground",
                  //     color: ColorSchemes.primary.withOpacity(0.6),
                  //   ),
                  // ),
                ])
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // SvgPicture.asset(
                          //   width: 232,
                          //   height: 232,
                          //   "ImagePaths.switchSplash",
                          //   fit: BoxFit.cover,
                          //   color: ColorSchemes.primary,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     border: Border.all(
                          //       color: ColorSchemes.gray,
                          //       // color of the border
                          //       width: 2, // width of the border
                          //     ),
                          //   ),
                          //   child: ClipOval(
                          //     child: Image.network(
                          //       height: 130,
                          //       width: 130,
                          //       _switchLogo,
                          //       fit: BoxFit.cover,
                          //       errorBuilder: (context, error, stackTrace) =>
                          //           Image.asset(
                          //         height: 130,
                          //         width: 130,
                          //        " ImagePaths.imagePlaceHolder",
                          //         fit: BoxFit.cover,
                          //       ),
                          //       loadingBuilder: (BuildContext context,
                          //           Widget child,
                          //           ImageChunkEvent? loadingProgress) {
                          //         if (loadingProgress == null) return child;
                          //         return SizedBox(
                          //           width: 130,
                          //           height: 130,
                          //           child: Center(
                          //             child: CircularProgressIndicator(
                          //               color: ColorSchemes.primary,
                          //               value: loadingProgress
                          //                           .expectedTotalBytes !=
                          //                       null
                          //                   ? loadingProgress
                          //                           .cumulativeBytesLoaded /
                          //                       loadingProgress
                          //                           .expectedTotalBytes!
                          //                   : null,
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      // Image.asset(
                      //   width: 120,
                      //   height: 120,
                      //   "ImagePaths.splashLogo",
                      // ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

}
