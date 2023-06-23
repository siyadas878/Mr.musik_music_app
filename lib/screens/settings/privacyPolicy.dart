import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class privacyPolicy extends StatelessWidget {
  const privacyPolicy({super.key});

  Widget createAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(child: createAppBar(), preferredSize: Size.fromHeight(50)),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                             SizedBox(height: MediaQuery.of(context).size.height * .08),

                Text('Privacy Policy',
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 16.0),
                Text(
                    'This Privacy Policy governs the manner in which our Mr.Musik app collects, uses, maintains, and discloses information collected from users (each, a "User") of the Mr.Music app ("App").',
                    style: GoogleFonts.oswald(fontSize: 15)),
                SizedBox(height: 16.0),
                Text('Personal Identification Information',
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8.0),
                Text(
                    'We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users interact with the App, register on the App, and in connection with other activities, services, features, or resources we make available on our App. Users may be asked for, as appropriate, name, email address. Users may, however, visit our App anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us.',
                    style: GoogleFonts.oswald(fontSize: 15)),
                SizedBox(height: 16.0),
                Text('Non-Personal Identification Information',
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8.0),
                Text(
                    'We may collect non-personal identification information about Users whenever they interact with our App. Non-personal identification information may include the browser name, the type of computer, and technical information about Users\' means of connection to our App, such as the operating system and the Internet service providers utilized and other similar information.',
                    style: GoogleFonts.oswald(fontSize: 15)),
                SizedBox(height: 16.0),
                Text('How We Use Collected Information',
                    style: GoogleFonts.oswald(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8.0),
                Text(
                    'We may collect and use Users\' personal information for the following purposes:',
                    style: GoogleFonts.oswald(fontSize: 15)),
                SizedBox(height: 8.0),
                Text('- To personalize user experience',
                    style: GoogleFonts.oswald(fontSize: 15)),
                Text(
                  '- To improve our App',
                   style: GoogleFonts.oswald(fontSize: 15)
                ),
                SizedBox(height: 16.0),
                // Include other sections of your privacy policy as necessary

                // Add your own content to complete the privacy policy
              ],
            ),
          ),
        ),
      ),
    );
  }
}
