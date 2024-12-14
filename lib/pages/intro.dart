import 'dart:async';

import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختيار اللغة')),
      body: Center(child: Text('اختر اللغة')),
    );
  }
}

class WaterBottleTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مهام')),
      body: Center(child: Text('أداء المهمة')),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // دالة للتنقل إلى الصفحة الرئيسية بعد مدة قصيرة
  _navigateToHome() async {
    // تأخير لمدة 3 ثوانٍ قبل الانتقال
    Timer(Duration(seconds: 3), () {
     // Navigator.pushReplacement(
        //context,
       // MaterialPageRoute(builder: (context) => MainScreen()), // استبدال HomePage بالصفحة الرئيسية
    //  );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // خلفية بلون مخصص
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق
            Image.asset('assets/logo.png'),  // تأكد من إضافة الشعار في مجلد assets
            SizedBox(height: 20),
            // اسم التطبيق والشعار
            Text(
              'اسم التطبيق',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class IntroPage3 extends StatelessWidget {
  final VoidCallback onFinish;

  IntroPage3({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحبا بك'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('مرحبًا بك في تطبيق حفظ الكلمات!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onFinish,
              child: Text('ابدأ'),
            ),
          ],
        ),
      ),
    );
  }
}
