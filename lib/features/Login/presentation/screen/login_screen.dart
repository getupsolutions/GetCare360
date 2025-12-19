import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getcare360/features/Dashboard/presentation/screen/home_page.dart';
import 'package:getcare360/features/Login/presentation/widget/logo_widget.dart';
import 'package:getcare360/features/Login/presentation/widget/network_background.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/core/widget/text_field_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final shortest = mq.size.shortestSide;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned.fill(child: NetworkBackground()),

          // Content
          SafeArea(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;

                  // Responsive card width
                  double cardWidth;
                  if (w >= 1100) {
                    cardWidth = 520;
                  } else if (w >= 700) {
                    cardWidth = 520;
                  } else {
                    cardWidth = min(w * 0.92, 520);
                  }

                  final titleSize = shortest < 600 ? 18.0 : 20.0;
                  final subtitleSize = shortest < 600 ? 12.5 : 13.5;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: cardWidth),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Logo(titleScale: shortest < 600 ? 0.9 : 1.0),
                          const SizedBox(height: 18),

                          Text(
                            "Sign In To Admin",
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2B2B2B),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Enter your details to login to your account:",
                            style: TextStyle(
                              fontSize: subtitleSize,
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 22),

                          TextFieldBox(
                            hint: "Enter Username",
                            controller: _usernameCtrl,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          TextFieldBox(
                            hint: "Enter Password",
                            controller: _passwordCtrl,
                            obscureText: _obscure,
                            textInputAction: TextInputAction.done,
                            suffix: IconButton(
                              tooltip: _obscure ? "Show" : "Hide",
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: min(cardWidth * 0.55, 220),
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                NavigatorHelper.push(context, HomePage());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF8E24AA,
                                ), // purple
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
