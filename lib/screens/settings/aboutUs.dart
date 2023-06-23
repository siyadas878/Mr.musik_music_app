import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          child: Column(
            children: [
             SizedBox(height: MediaQuery.of(context).size.height * .02),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        ClipOval(
                          child: Image.asset(
                            'assets/music logo design (2).png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Text(
                          'About Mr.Musik',style: GoogleFonts.oswald( fontSize: 24.0,fontWeight: FontWeight.bold),
                          
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Text(
                          'Welcome to Mr.Musik! We are a passionate team of music enthusiasts dedicated to creating the ultimate music listening experience for our users.',
                          style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Text(
                          'Key Features:',
                         style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 16)
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .01),
                        ListTile(
                          leading: Icon(Icons.library_music),
                          title: Text('Music Library',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                          subtitle: Text('Access your entire music collection.',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          leading: Icon(Icons.equalizer),
                          title: Text('Equalizer',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                          subtitle: Text('Customize the audio settings to match your preferences.',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .01),
                        ListTile(
                          leading: Icon(Icons.playlist_play),
                          title: Text('Playlists',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                          subtitle: Text('Create and manage your personalized playlists.',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                        ),
                        // Add more key features as desired
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Text(
                          'We value your feedback and continuously strive to improve our app. Your input is essential in shaping the future of Mr.Music. Please feel free to reach out to us with any suggestions, questions, or issues you may have.',
                          style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Text(
                          'Contact Us:',
                          style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 16)
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .01),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('Email',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                          subtitle: Text('siyadas878@gmail.com',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Phone',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                          subtitle: Text('9400879756',style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



