import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../helpers/responsive_helper.dart';
import '../cabinet/cabinet.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);

    double containerWidth = screen.isSmall ? screen.wp(0.9) : 400;
    double containerHeight = screen.isSmall ? screen.hp(0.6) : 600;
    double logoSize = screen.isSmall ? 120 : 140;
    double logoHeight = screen.isSmall ? 40 : 90;
    double padding = screen.isSmall ? 24 : 32;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: screen.hp(0.08)),
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Easily access university-provided\nservices and resources.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screen.isSmall ? 16 : 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),
                  ),

                  SizedBox(height: screen.hp(0.05)),

                  Container(
                    width: containerWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.5,
                      ),
                    ),
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                          'https://onedesk.newuu.uz/static/images/logo/onedesk-blue.png',
                          width: logoSize,
                          height: logoHeight,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                        ),

                        SizedBox(height: screen.hp(0.04)),

                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: screen.isSmall ? 22 : 26,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Access is allowed only to New Uzbekistan University staff members.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screen.isSmall ? 14 : 16,
                            color: const Color(0xFF666666),
                            height: 1.4,
                          ),
                        ),

                        SizedBox(height: screen.hp(0.03)),

                        SizedBox(
                          width: double.infinity,
                          height: screen.isSmall ? 50 : 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cabinet(),
                                ),
                              );

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF333333),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.network(
                                  'https://onedesk.newuu.uz/static/images/icons/google.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Google bilan kirish',
                                  style: TextStyle(
                                    fontSize: screen.isSmall ? 14 : 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: screen.hp(0.03)),

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: screen.isSmall ? 13 : 14,
                              color: const Color(0xFF666666),
                              height: 1.4,
                            ),
                            children: const [
                              TextSpan(
                                  text: 'Need assistance? Reach out to our '),
                              TextSpan(
                                text: 'support team',
                                style: TextStyle(
                                  color: Color(0xFF3B82F6),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' for help\nfor assistance.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



