import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/formats.dart';
import 'package:recapp/src/features/auth/domain/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                'EXP / Chart',
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
        stream: FirebaseFirestore.instance.collection('users').doc(user!.id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = UserModel.fromDocument(snapshot.data!);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Level: ${user!.level.numeric}',
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    minHeight: size.height * .04,
                    value: user!.percentage,
                    // value: 0.8,
                    borderRadius: BorderRadius.circular(16),

                    backgroundColor: Colors.grey.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'XP: ${user!.xpTitle}',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('#'),
                      ),
                      DataColumn(
                        label: Text('Paper'),
                      ),
                      DataColumn(
                        label: Text('Cardboard'),
                      ),
                      DataColumn(
                        label: Text('Styrofoam'),
                      ),
                      DataColumn(
                        label: Text('Green Waste'),
                      ),
                      DataColumn(
                        label: Text('Wood'),
                      ),
                      DataColumn(
                        label: Text('Battery Waste'),
                      ),
                      DataColumn(
                        label: Text('Oil Waste'),
                      ),
                      DataColumn(
                        label: Text('Metal'),
                      ),
                      DataColumn(
                        label: Text('Glass'),
                      ),
                      DataColumn(
                        label: Text('Aluminum'),
                      ),
                      DataColumn(
                        label: Text('Plastic'),
                      ),
                    ],
                    rows: const [
                      DataRow(
                        cells: [
                          DataCell(
                            Text('XP Per M^3'),
                          ),
                          DataCell(
                            Text('100'),
                          ),
                          DataCell(
                            Text('75'),
                          ),
                          DataCell(
                            Text('50'),
                          ),
                          DataCell(
                            Text('25'),
                          ),
                          DataCell(
                            Text('250'),
                          ),
                          DataCell(
                            Text('200'),
                          ),
                          DataCell(
                            Text('200'),
                          ),
                          DataCell(
                            Text('500'),
                          ),
                          DataCell(
                            Text('500'),
                          ),
                          DataCell(
                            Text('400'),
                          ),
                          DataCell(
                            Text('350'),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text('Coin Per M^3'),
                          ),
                          DataCell(
                            Text('40'),
                          ),
                          DataCell(
                            Text('30'),
                          ),
                          DataCell(
                            Text('20'),
                          ),
                          DataCell(
                            Text('10'),
                          ),
                          DataCell(
                            Text('100'),
                          ),
                          DataCell(
                            Text('80'),
                          ),
                          DataCell(
                            Text('80'),
                          ),
                          DataCell(
                            Text('200'),
                          ),
                          DataCell(
                            Text('200'),
                          ),
                          DataCell(
                            Text('160'),
                          ),
                          DataCell(
                            Text('120'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
