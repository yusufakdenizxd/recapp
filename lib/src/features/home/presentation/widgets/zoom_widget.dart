import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/features/home/presentation/screens/home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ZoomWidget extends ConsumerWidget {
  const ZoomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerOpen = ref.watch(drawerOpenProvider);

    final Size size = context.mediaQuery.size;
    return Positioned(
      bottom: size.height * .05,
      left: size.width * .06,
      child: AnimatedOpacity(
        opacity: drawerOpen ? 0 : 1,
        duration: const Duration(milliseconds: 100),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => ref.read(mapControllerProvider)?.animateCamera(CameraUpdate.zoomIn()),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .006,
            ),
            GestureDetector(
              onTap: () => ref.read(mapControllerProvider)?.animateCamera(CameraUpdate.zoomOut()),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
