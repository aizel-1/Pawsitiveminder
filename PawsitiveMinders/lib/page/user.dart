import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;
final FirebaseAuth _auth = FirebaseAuth.instance;

String? userEmail = user?.email; // Get the user's email
String? userName =
    user?.displayName; // Get the user's display name (if available)

void _updateProfile(dynamic _nameController) async {
  if (user != null) {
    try {
      // Update the displayName
      await user?.updateDisplayName(_nameController.text.trim());
      await user!.reload();
      user = _auth.currentUser;
      print('update name:${user?.displayName}'); // Reload the current user
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}
