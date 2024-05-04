import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recapp/src/core/context_extension.dart';

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
                      'Mission:',
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
                      'Our mission at Recapp is to empower individuals to make a meaningful impact on the environment by promoting recycling and sustainable practices. We strive to provide a user-friendly platform that incentivizes and rewards users for their contributions to recycling efforts. Through education, innovation, and collaboration, we aim to create a cleaner, healthier planet for current and future generations.',
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
                      'Vision:',
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
                      'At Recapp, we envision a world where recycling is not only a habit but a celebrated act of environmental stewardship. We aspire to build a global community of eco-conscious individuals who are inspired and motivated to participate in recycling initiatives. By harnessing the power of technology and gamification, we seek to revolutionize the way people engage with recycling, making it accessible, enjoyable, and rewarding for all. Together, we can transform waste into valuable resources and pave the way towards a sustainable future.',
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
