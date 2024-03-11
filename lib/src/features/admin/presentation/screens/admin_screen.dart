import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/double_picker.dart';
import 'package:recapp/src/core/formats.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/selection_picker.dart';
import 'package:recapp/src/core/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        leadingWidth: size.width * .7,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * .05,
            ),
            Container(
              height: size.height * .04,
              width: size.width * .01,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Requests',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.close,
                size: 40,
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('request').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final item = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Date: ${DateTime.parse(item['date'].toDate().toString()).tarihAysaat}',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF292929),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('users').doc(item['userId']).snapshots(),
                          builder: (context, _) {
                            final name = _.data?['username'] ?? 'Waiting';
                            return Text(
                              'User: ${name}',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF292929),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final res = await Popup.showPopUpYesNo('Are you you want to Reject request');
                                if (!res) {
                                  Vibration.vibrate();
                                  return;
                                }
                                await item.reference.delete();
                                Snackbar.show('Rejected Succefly');
                              },
                              child: Container(
                                width: size.width * .3,
                                height: size.height * .045,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(48),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Reject',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                    'Paper',
                                    'Cardboard',
                                    'Styrofoam',
                                    'Green Waste',
                                    'Wood',
                                    'Battery Waste',
                                    'Oil Waste',
                                    'Metal',
                                    'Glass',
                                    'Aluminum',
                                    'Plastic',
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
                                  'Are you you want to Accept request',
                                );
                                if (!res) {
                                  Vibration.vibrate();
                                  return;
                                }

                                await FirebaseFirestore.instance.collection('users').doc(item['userId']).get().then((value) async {
                                  await value.reference.update({
                                    'xp': double.parse(value['xp'].toString()) + (xpList[type] * amount),
                                    'coin': double.parse(value['coin'].toString()) + (coinList[type] * amount),
                                  });
                                });

                                await item.reference.delete();

                                Snackbar.show('Accepted Succefly');
                              },
                              child: Container(
                                width: size.width * .3,
                                height: size.height * .045,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(48),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Accept',
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
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
