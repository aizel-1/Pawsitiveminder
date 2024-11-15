import 'package:firebase/login/login.dart';
import 'package:firebase/page/settings.dart';
import 'package:firebase/page/user.dart';
import 'package:firebase/profile/ProfileMenuWidget.dart';
import 'package:firebase/profile/UpdateProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  // profile page text string

  static const String tProfile = 'Profile';
  static const String tEditProfile = 'Edit Profile';
  static const String tLogOutDialogHeading = 'Log out';
  static const String tProfileHeading = 'sample name';
  static const String tProfileSubHeading = 'email';

// menu
  static const String tMenu1 = 'Log out';
  static const String tMenu2 = 'Settings';
  static const String tMenu3 = 'Information';

//update profile screen
  static const String tDelete = "Delete";
  static const String tJoined = "Joined";
  static const String tJoinedAt = " 25 October 2025";

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  final FirebaseAuth _auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    Future<void> updateDisplayName(String name) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (User != true) {
        await user?.updateDisplayName(null);
        await user?.reload();
        user = FirebaseAuth.instance.currentUser;
      }
    }

    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: const Image(
                            image: AssetImage('images/logo.png'),
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // ignore: deprecated_member_use
                          color: Colors.brown.withOpacity(0.1),
                        ),
                        child: const Icon(LineAwesomeIcons.pencil_alt_solid,
                            size: 18, color: Color.fromARGB(255, 29, 24, 24)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(user?.displayName ?? 'No Name',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(user?.email ?? 'No email'),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Updateprofilescreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(239, 236, 177, 120),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(profilepage.tEditProfile,
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Settings",
                    icon: LineAwesomeIcons.cog_solid,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Settings()));
                    }),
                ProfileMenuWidget(
                    title: "Add Pets",
                    icon: LineAwesomeIcons.paw_solid,
                    onPressed: () {}),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Log out",
                    icon: LineAwesomeIcons.sign_out_alt_solid,
                    textColor: Colors.redAccent,
                    endIcon: false,
                    onPressed: () {
                      _auth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login()));
                              OnInvokeCallback == false;
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
