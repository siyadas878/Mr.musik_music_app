import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mr.musik/screens/settings/aboutUs.dart';
import 'package:Mr.musik/screens/settings/privacyPolicy.dart';
import 'package:Mr.musik/screens/settings/termsCondition.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget CreaateAppBar() {
    return AppBar(
      title: Text('Settings'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            children: [
              CreaateAppBar(),
              const Divider(
                color: Color(0xFFF0ECC2),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUs(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF0ECC2),
                          minimumSize: Size(250, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text('ABOUT US',
                          style:
                              GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        shareMusic();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF0ECC2),
                          minimumSize: Size(250, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text('SHARE APP',
                          style:
                              GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => privacyPolicy(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF0ECC2),
                          minimumSize: Size(250, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text('PRIVACY POLICY',
                          style:
                              GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsCondition(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF0ECC2),
                          minimumSize: Size(250, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text('TERMS AND CONDITIONS',
                          style:
                              GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

void shareMusic() {
  // Define the content to be shared
  String musicTitle = "Mr.musik";
  String musicUrl = "https://play.google.com/store/apps/details?id=com.brototype.mr_musik";

  // Share the content using the share package
  Share.share("Check out this amazing music player App: $musicTitle\n\n$musicUrl");
}
