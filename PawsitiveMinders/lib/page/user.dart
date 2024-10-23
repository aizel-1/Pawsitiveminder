import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

String? userEmail = user?.email; // Get the user's email
String? userName = user?.displayName; // Get the user's display name (if available)
