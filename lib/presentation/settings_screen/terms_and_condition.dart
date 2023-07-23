import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  Widget CreaateAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 40.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: CreaateAppBar(), preferredSize: Size.fromHeight(50)),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF555449), Color(0xFFF0ECC2), Color(0xFF555449)],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .08),

                Text('Terms and Conditions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 16.0),
                Text(
                    'By using our Mr.Musik app, you agree to the following terms and conditions:',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 16.0),
                Text('1. Usage',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8.0),
                Text(
                    'a. You may use the app for personal, non-commercial purposes only.',
                    style: TextStyle(fontSize: 15)),
                Text(
                    'b. You shall not reproduce, duplicate, copy, sell, resell, or exploit any portion of the app without the explicit permission of the app owners.',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 16.0),
                Text('2. Intellectual Property',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8.0),
                Text(
                    'a. All intellectual property rights in the app and its contents (including but not limited to text, graphics, logos, and software) are owned by the app owners.',
                    style: TextStyle(fontSize: 15)),
                Text(
                    'b. You shall not modify, distribute, or create derivative works based on the app or its contents without the explicit permission of the app owners.',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 16.0),
                Text('3. User Conduct',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8.0),
                Text(
                    'a. You shall not use the app in any way that may impair the performance, corrupt the content, or otherwise interfere with the functionality of the app.',
                    style: TextStyle(fontSize: 15)),
                Text(
                    'b. You shall not use the app to distribute any illegal or unauthorized material.',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 16.0),

              ],
            ),
          ),
        ));
  }
}
