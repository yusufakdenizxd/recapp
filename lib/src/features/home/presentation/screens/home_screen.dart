import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/formats.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/snackbar.dart';
import 'package:recapp/src/features/admin/presentation/screens/admin_screen.dart';
import 'package:recapp/src/features/home/presentation/widgets/drawer_widget.dart';
import 'package:recapp/src/features/home/presentation/widgets/my_location_widget.dart';
import 'package:recapp/src/features/home/presentation/widgets/zoom_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final mapControllerProvider = StateProvider<GoogleMapController?>((ref) => null);
final drawerOpenProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final markers = {
    Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(40.0869753504644, 29.50789883984419),
      icon: BitmapDescriptor.defaultMarkerWithHue(125),
      onTap: () {
        markerModal(0);
      },
    ),
    Marker(
      markerId: const MarkerId('2'),
      position: const LatLng(40.087330716726065, 29.506616142689538),
      icon: BitmapDescriptor.defaultMarkerWithHue(130),
      onTap: () {
        markerModal(1);
      },
    ),
  };
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void markerModal(int index) {
    final Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: size.height * .25,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * .03),
              GestureDetector(
                onTap: () {
                  final destination = markers.elementAt(index).position;
                  final googleUrl = 'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}';
                  launchUrl(Uri.parse(googleUrl));
                },
                child: Container(
                  width: size.width * .3,
                  height: size.height * .055,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(48),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Go',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * .03),
              GestureDetector(
                onTap: () async {
                  Popup.showLoadingScreen();
                  await FirebaseFirestore.instance.collection('request').add({
                    'userId': user!.id,
                    'date': DateTime.now(),
                    'cords': markers.elementAt(index).position.toJson(),
                    'markerId': markers.elementAt(index).markerId.value,
                  });
                  context.pop();
                  context.pop();
                  Snackbar.show('Recycle request sent.');
                },
                child: Container(
                  width: size.width * .5,
                  height: size.height * .065,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(48),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Recycle Waste',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          onEndDrawerChanged: (isOpened) {
            ref.read(drawerOpenProvider.notifier).update((state) => isOpened);
          },
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F5F5),
            automaticallyImplyLeading: false,
            leading: Center(
              child: GestureDetector(
                onLongPress: () => context.push(const AdminScreen()),
                child: Text(
                  'RecApp',
                  style: GoogleFonts.poppins(
                    color: context.theme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            leadingWidth: size.width * .4,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: VerticalDivider(
                          color: Color(0xFF78A991),
                          thickness: 1.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Center(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('users').doc(user!.id).snapshots(),
                            builder: (context, snapshot) {
                              num _ = snapshot.data?['coin'] ?? 0;
                              return Text(
                                _.numeric,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              )
            ],
          ),
          endDrawer: const DrawerWidget(),
          body: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: markers,
            onMapCreated: (controller) async {
              ref.read(mapControllerProvider.notifier).update((state) => controller);
              final pos = await Geolocator.getCurrentPosition();
              await controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(pos.latitude, pos.longitude),
                    zoom: 18,
                  ),
                ),
              );
            },
          ),
        ),
        const ZoomWidget(),
        const MyLocationWidget(),
      ],
    );
  }
}
