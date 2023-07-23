import 'package:flutter/material.dart';
import 'package:Mr.musik/presentation/settings_screen/about_us.dart';
import 'package:Mr.musik/presentation/settings_screen/privacy_policy.dart';
import 'package:Mr.musik/presentation/settings_screen/terms_and_condition.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget createAppBar() {
    return AppBar(
      title: Text('Settings'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  FutureBuilder<String> buildAppVersionWidget() {
    return FutureBuilder<String>(
      future: getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        } else if (snapshot.hasData) {
          return Text('App Version: ${snapshot.data}',
              style: TextStyle(color: Colors.white));
        } else {
          return Text('Failed to get app version.',
              style: TextStyle(color: Color(0xFFF0ECC2)));
        }
      },
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
            createAppBar(),
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
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF0ECC2),
                      minimumSize: Size(250, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('ABOUT US',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('SHARE APP',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF0ECC2),
                      minimumSize: Size(250, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('PRIVACY POLICY',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF0ECC2),
                      minimumSize: Size(250, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('TERMS AND CONDITIONS',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: buildAppVersionWidget(),
            ), // Display app version at the bottom
          ],
        ),
      ),
    );
  }
}

void shareMusic() {
  // Define the content to be shared
  String musicTitle = "Mr.musik";
  String musicUrl =
      "https://play.google.com/store/apps/details?id=com.brototype.mr_musik";

  // Share the content using the share package
  Share.share("Check out this amazing music player App: $musicTitle\n\n$musicUrl");
}
