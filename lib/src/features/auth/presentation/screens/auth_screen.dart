import 'package:flutter/material.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/features/auth/presentation/widgets/login_widget.dart';
import 'package:recapp/src/features/auth/presentation/widgets/register_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({this.initialIndex, super.key});
  final int? initialIndex;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => context.unFocus(),
      child: DefaultTabController(
        initialIndex: widget.initialIndex ?? 1,
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: PreferredSize(
            preferredSize: Size(size.width, size.height * .12),
            child: Container(
              color: context.theme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RecApp',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'think for nature',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TabBar(
                  indicatorColor: context.theme.primaryColor,
                  dividerColor: context.theme.primaryColor,
                  labelColor: context.theme.primaryColor,
                  tabs: [
                    Tab(
                      text: 'Sign In',
                      height: size.height * .07,
                    ),
                    Tab(
                      text: 'Sign Up',
                      height: size.height * .07,
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    LoginWidget(),
                    RegisterWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
