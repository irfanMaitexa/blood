import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blood/login.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context) => const LoginPage()
      ));
    });
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: 500,
            child: Center(
              child: Image.network('https://th.bing.com/th/id/OIP.d7SOKZ6FLBZ7_-0Da9YlvwHaJM?w=164&h=204&c=7&r=0&o=5&dpr=1.5&pid=1.7',
                fit: BoxFit.cover,),
            ),
          ),

          SizedBox(
            child: Text('BLOOD BANK APP',style: TextStyle(fontStyle: FontStyle.italic,
              color: Colors.red,fontSize: 40,),
            ),
          ),

        ],
      ),
    );

  }
}
