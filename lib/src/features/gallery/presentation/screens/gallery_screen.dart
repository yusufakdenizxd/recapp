import 'package:flutter/material.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuery.size;
    return Scaffold(
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
                'Gallery',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://www.brandeis.edu/sustainability/waste/trash-recycling-bins-massell-20230410.jpg',
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: size.height * .3,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  ),
                );
              },
              width: size.width,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF292929),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dictum molestie gravida. Maecenas luctus auctor erat, ut accumsan nisl rutrum a. Aliquam leo dolor, convallis euismod mi a, dapibus malesuada dolor. Nam aliquet augue non metus elementum, ut eleifend neque sagittis. Morbi sodales felis massa. Fusce et consectetur nulla. Proin rutrum non quam ac efficitur. Aenean a ligula at odio eleifend sagittis fringilla imperdiet erat. Donec et vestibulum quam. Donec euismod ante eros, ut vulputate nunc tincidunt vel. Nulla facilisi.',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF747474),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              'https://cdn.wm.com/content/dam/wm/assets/home/waste-recycling-pickup/index-pages/woman-waste-recycling-toters-omr.jpg',
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: size.height * .3,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  ),
                );
              },
              width: size.width,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF292929),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dictum molestie gravida. Maecenas luctus auctor erat, ut accumsan nisl rutrum a. Aliquam leo dolor, convallis euismod mi a, dapibus malesuada dolor. Nam aliquet augue non metus elementum, ut eleifend neque sagittis. Morbi sodales felis massa. Fusce et consectetur nulla. Proin rutrum non quam ac efficitur. Aenean a ligula at odio eleifend sagittis fringilla imperdiet erat. Donec et vestibulum quam. Donec euismod ante eros, ut vulputate nunc tincidunt vel. Nulla facilisi.',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF747474),
                        fontSize: 20,
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
  }
}
