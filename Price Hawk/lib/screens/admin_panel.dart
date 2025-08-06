import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isAdmin = false;

  void _loginAsAdmin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email == 'prakharmishraspn91@gmail.com' && password == 'Shekhar@91611') {
      setState(() {
        isAdmin = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel', style: GoogleFonts.poppins()),
      ),
      body: isAdmin
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Earning Tracker", style: GoogleFonts.poppins(fontSize: 20)),
                  SizedBox(height: 10),
                  Text("Today: ₹43.21", style: GoogleFonts.poppins()),
                  Text("This Month: ₹1,235.89", style: GoogleFonts.poppins()),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic to view ad stats from Firebase
                    },
                    child: Text("Refresh Stats"),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Admin Login", style: GoogleFonts.poppins(fontSize: 22)),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loginAsAdmin,
                    child: Text("Login"),
                  )
                ],
              ),
            ),
    );
  }
}
