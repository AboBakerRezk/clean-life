import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'language.dart'; // تأكد من إضافة حزمة flutter_animate في pubspec.yaml

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // بيانات الاتصال بالمطور
  final String developerEmail = "abu20017baker@gmail.com";

  // رابط مصدر البيانات API
  final String apiUrl = "https://openweather.co.uk/  and https://docs.ckan.org/en/2.9/user-guide.html";

  // دالة لفتح الرابط
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // استخدام ScaffoldMessenger لإظهار رسالة بدلاً من رمي استثناء
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocale.air46.getString(context)}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // تحديد الثيم العام للصفحة
    final ThemeData theme = Theme.of(context).copyWith(
      primaryColor: Colors.deepPurple[700],
      hintColor: Colors.deepPurpleAccent,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'clean life',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple[700],
        centerTitle: true,
      ),
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[800]!, Colors.deepPurple[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // وصف التطبيق
              _buildCard(
                title: '${AppLocale.air48.getString(context)}',
                content:
                '${AppLocale.air49.getString(context)}',
              ),
              SizedBox(height: 20),

              // بيانات الاتصال بالمطور
              _buildCard(
                title: '${AppLocale.air50.getString(context)}',
                contentWidget: _buildContactTile(
                  icon: Icons.email,
                  title: '${AppLocale.air51.getString(context)}:',
                  subtitle: developerEmail,
                  url: 'mailto:$developerEmail',
                ),
              ),
              SizedBox(height: 20),

              // مصادر البيانات API
              _buildCard(
                title: '${AppLocale.air52.getString(context)}',
                contentWidget: _buildContactTile(
                  icon: Icons.link,
                  title: 'Data source:',
                  subtitle: apiUrl,
                  url: apiUrl,
                ),
              ),
              SizedBox(height: 20),

              // لماذا قمت بتصميم هذا التطبيق؟
              _buildCard(
                title: '${AppLocale.air53.getString(context)}',
                content:
                '${AppLocale.air54.getString(context)}',
              ),
              SizedBox(height: 20),

              // الهدف من إنشاء التطبيق
              _buildCard(
                title: 'The purpose of creating the application',
                content:
                '${AppLocale.air55.getString(context)}',
              ),
              SizedBox(height: 20),

              // الرسالة
              _buildCard(
                title: '${AppLocale.air56.getString(context)}',
                content:
                '${AppLocale.air57.getString(context)}',
              ),
              SizedBox(height: 20),

              // شرح أيقونة العصفورة
              _buildCard(
                title: '${AppLocale.air58.getString(context)}',
                content:
                '${AppLocale.air59.getString(context)}',
              ),
              SizedBox(height: 20),

              // الرسالة النهائية
              _buildCard(
                content:
                '${AppLocale.air60.getString(context)}',
                isFinalMessage: true,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// دالة لبناء كارد لكل قسم مع تحسين التصميم باستخدام Colors.deepPurple[700]
  Widget _buildCard({
    String? title,
    String? content,
    Widget? contentWidget,
    bool isFinalMessage = false,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[700]!, Colors.deepPurple[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
                  .animate()
                  .fadeIn(duration: Duration(milliseconds: 500))
                  .moveY(end: -20),
            if (title != null) SizedBox(height: 10),
            if (content != null)
              Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5, // تحسين تباعد الأسطر
                  color: Colors.white70,
                ),
                textAlign: TextAlign.justify,
              )
                  .animate()
                  .fadeIn(duration: Duration(milliseconds: 500))
                  .moveY(end: 20)
                  .scale(),
            if (contentWidget != null)
              contentWidget
                  .animate()
                  .fadeIn(duration: Duration(milliseconds: 500))
                  .moveY(end: 20),
            if (isFinalMessage && content != null) SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// دالة لبناء قائمة الاتصال داخل الكارد مع تحسين الألوان والأيقونات
  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
      onTap: () => _launchURL(url),
    )
        .animate()
        .fadeIn(duration: Duration(milliseconds: 500))
        .moveY(end: 20);
  }
}
