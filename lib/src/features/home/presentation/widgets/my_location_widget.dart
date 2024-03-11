import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/features/home/presentation/screens/home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocationWidget extends ConsumerWidget {
  const MyLocationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerOpen = ref.watch(drawerOpenProvider);
    final Size size = context.mediaQuery.size;
    return Positioned(
      bottom: size.height * .05,
      right: size.width * .06,
      child: AnimatedOpacity(
        opacity: drawerOpen ? 0 : 1,
        duration: const Duration(milliseconds: 100),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pos = await Geolocator.getCurrentPosition();
                ref.read(mapControllerProvider)?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(pos.latitude, pos.longitude),
                          zoom: 18,
                        ),
                      ),
                    );
              },
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
