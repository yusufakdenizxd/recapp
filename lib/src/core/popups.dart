import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:recapp/src/core/global.dart';

class Popup {
  static void showLoadingScreen() {
    showDialog(
      context: mainContext,
      barrierDismissible: false,
      routeSettings: const RouteSettings(name: 'loadingPopup'),
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text(
              'Please Wait a While...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            content: SizedBox(
              height: size.height / 10,
              width: size.width / 3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showAlertPopup({
    required String title,
    required String subtitle,
    required Icon icon,
    required Color backgroundColor,
  }) async {
    await showDialog(
      context: mainContext,
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AlertDialog(
          backgroundColor: Colors.white,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          content: AnimatedPrompt(
            title: title,
            subTitle: subtitle,
            backgroundColor: backgroundColor,
            child: icon,
          ),
        ),
      ),
    );
  }

  static Future<bool> showPopUpYesNo(
    String title,
  ) async {
    bool res = false;
    await showAdaptiveDialog(
      context: mainContext,
      routeSettings: const RouteSettings(name: "loadingDialog"),
      builder: (context) => AlertDialog.adaptive(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () {
              res = true;
              Navigator.pop(context);
            },
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
    return res;
  }

  static void showLoadingScreenWithButton({
    required Function callback,
    required String title,
  }) {
    final Size size = MediaQuery.of(mainContext).size;
    showDialog(
      context: mainContext,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text(
            'Lütfen Bekleyiniz',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          content: SizedBox(
            height: .13 * size.height,
            width: .3 * size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => callback(),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget child;
  final Color backgroundColor;

  const AnimatedPrompt({
    super.key,
    required this.title,
    required this.subTitle,
    required this.child,
    required this.backgroundColor,
  });

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _yAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.23),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _iconScaleAnimation = Tween<double>(
      begin: 7,
      end: 6,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _containerScaleAnimation = Tween<double>(
      begin: 2.0,
      end: 0.4,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _controller
      ..reset()
      ..forward();

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
              minHeight: 100,
              maxHeight: .7 * size.height,
              maxWidth: .6 * size.width,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 180,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.subTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: SlideTransition(
                    position: _yAnimation,
                    child: ScaleTransition(
                      scale: _containerScaleAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.backgroundColor,
                        ),
                        child: ScaleTransition(
                          scale: _iconScaleAnimation,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
