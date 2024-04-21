import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HELP',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Help Center!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'If you encounter any issues or have questions about the Blood Bank app, please refer to the following resources:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Support'),
              subtitle: Text('support@bloodbank.com'),
              onTap: () {
                // Implement email support functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Support'),
              subtitle: Text('+1234567890'),
              onTap: () {
                // Implement call support functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('FAQs'),
              subtitle: Text('Frequently Asked Questions'),
              onTap: () {
                // Navigate to FAQs page
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              subtitle: Text('About Blood Bank App'),
              onTap: () {
                // Navigate to About page
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HelpPage(),
  ));
}
