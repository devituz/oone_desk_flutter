import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: Container(
                width: 400,
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),


                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top spacing

                    // Title text
                    Text(
                      'Easily access university-provided\nservices and resources.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 22 : 28,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.08),

                    // Main card
                    Container(
                      width: 360,
                      constraints: BoxConstraints(
                        maxWidth: 400,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),

                      ),

                      padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
                      child: Column(
                        children: [
                          // OneDesk logo
                          CachedNetworkImage(
                            imageUrl: 'https://onedesk.newuu.uz/static/images/logo/onedesk-blue.png',
                            width: isSmallScreen ? 100 : 140,
                            height: isSmallScreen ? 40 : 90,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                          ),


                          SizedBox(height: screenHeight * 0.06),

                          // Sign In text
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 24 : 28,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),

                          SizedBox(height: isSmallScreen ? 12 : 16),

                          // Access text
                          Text(
                            'Access is allowed only to New Uzbekistan University staff members.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: const Color(0xFF666666),
                              height: 1.4,
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.04),

                          // Google sign in button
                          Container(
                            width: double.infinity,
                            height: isSmallScreen ? 50 : 56,
                            child: ElevatedButton(
                              onPressed: () {
                                // Google sign in logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Google bilan kirish bosildi'),
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
                                  // SVG Google icon
                                  SvgPicture.network(
                                    'https://onedesk.newuu.uz/static/images/icons/google.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Google bilan kirish',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.04),

                          // Support text
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 14,
                                color: const Color(0xFF666666),
                                height: 1.4,
                              ),
                              children: [
                                const TextSpan(text: 'Need assistance? Reach out to our '),
                                TextSpan(
                                  text: 'support team',
                                  style: TextStyle(
                                    color: const Color(0xFF3B82F6),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const TextSpan(text: ' for help\nfor assistance.'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom spacing
                  ],
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}

