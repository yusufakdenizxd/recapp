import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/double_picker.dart';
import 'package:recapp/src/core/formats.dart';
import 'package:recapp/src/core/latlng_calculator.dart';
import 'package:recapp/src/core/local_notifications.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/selection_picker.dart';
import 'package:recapp/src/core/snackbar.dart';
import 'package:recapp/src/features/coupons/presentation/screens/coupons_screen.dart';
import 'package:recapp/src/features/home/presentation/widgets/drawer_widget.dart';
import 'package:recapp/src/features/home/presentation/widgets/my_location_widget.dart';
import 'package:recapp/src/features/home/presentation/widgets/zoom_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

//Google map kontrolcüsü değişkeni
final mapControllerProvider = StateProvider<GoogleMapController?>((ref) => null);
//Drawer menüsün açık olup olmadığınınn kontrolü
final drawerOpenProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //Harita üzerindeki pinlerin eklenmesi
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
    Marker(
      markerId: const MarkerId('3'),
      position: const LatLng(39.52574437753011, 36.426974113205844),
      icon: BitmapDescriptor.defaultMarkerWithHue(130),
      onTap: () {
        markerModal(2);
      },
    ),
    Marker(
      markerId: const MarkerId('4'),
      position: const LatLng(38.19348764243855, 41.972951922957),
      icon: BitmapDescriptor.defaultMarkerWithHue(130),
      onTap: () {
        markerModal(3);
      },
    ),
  };
  //Drawer menüsünün kontrolü için gerekli anahtar
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void markerModal(int index) {
    final size = MediaQuery.of(context).size;
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
                  final coinList = <double>[
                    40,
                    30,
                    20,
                    10,
                    100,
                    80,
                    80,
                    200,
                    200,
                    160,
                    120,
                  ];

                  final xpList = <double>[
                    100,
                    75,
                    50,
                    25,
                    250,
                    200,
                    200,
                    500,
                    500,
                    400,
                    350,
                  ];

                  final type = await selectionPicker(
                    data: [
                      'Paper (m^3)',
                      'Cardboard (m^3)',
                      'Styrofoam (m^3)',
                      'Green Waste (m^3)',
                      if (user!.level > 1) ...[
                        'Wood (m^3)',
                        'Battery Waste (10 units)',
                        'Oil Waste (liter)',
                      ],
                      if (user!.level > 2) ...[
                        'Metal (m^3)',
                        'Glass (m^3)',
                        'Aluminum (m^3)',
                        'Plastic (m^3)',
                      ],
                    ],
                    title: 'What type of waste',
                  );

                  if (type == null) {
                    Vibration.vibrate();
                    return;
                  }
                  final amount = await doublePicker(title: 'Amount');
                  if (amount == null) {
                    Vibration.vibrate();
                    return;
                  }

                  final res = await Popup.showPopUpYesNo(
                    'Are you you want to Recycle',
                  );
                  if (!res) {
                    Vibration.vibrate();
                    return;
                  }

                  await FirebaseFirestore.instance.collection('users').doc(user!.id).get().then((value) async {
                    await value.reference.update({
                      'xp': double.parse(value['xp'].toString()) + (xpList[type] * amount),
                      'coin': double.parse(value['coin'].toString()) + (coinList[type] * amount),
                    });
                  });

                  final targetPosition = markers.elementAt(index).position;
                  final myPosition = await Geolocator.getCurrentPosition();

                  final distance = LatlngCalculator.calculateDistance(
                    myPosition.latitude,
                    myPosition.longitude,
                    targetPosition.latitude,
                    targetPosition.longitude,
                  );

                  final inHours = math.max(distance ~/ 60, 1);

//TODO METINLER DUZENLECEK
                  LocalNotification.instance.addNotification(
                    title: 'We are close!',
                    body: 'Our courier will be at your location in 15 minutes',
                    notificationTime: DateTime.now().add(Duration(hours: inHours)).subtract(const Duration(minutes: 15)),
                  );
                  LocalNotification.instance.addNotification(
                    title: 'We are in there',
                    body: 'Our courier is waiting for you  at your location',
                    notificationTime: DateTime.now().add(Duration(hours: inHours)),
                  );
                  Snackbar.show('Your Waste will be taken in ${inHours} hour.');
                  // Popup.showLoadingScreen();
                  // await FirebaseFirestore.instance.collection('request').add({
                  //   'userId': user!.id,
                  //   'date': DateTime.now(),
                  //   'cords': markers.elementAt(index).position.toJson(),
                  //   'markerId': markers.elementAt(index).markerId.value,
                  // });
                  // context.pop();
                  // context.pop();
                  // Snackbar.show('Recycle request sent.');
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
              child: Text(
                'RecApp',
                style: GoogleFonts.poppins(
                  color: context.theme.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leadingWidth: size.width * .4,
            actions: [
              GestureDetector(
                onTap: () {
                  context.push(const CouponsScreen());
                },
                child: Padding(
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
            zoomControlsEnabled: false,
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
