import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:clean_life/home.dart';
import 'package:clean_life/pages/advice.dart';
import 'package:clean_life/pages/country.dart';
import 'package:clean_life/pages/intro.dart';
import 'package:clean_life/pages/language.dart';
import 'package:clean_life/pages/pullutants.dart';
import 'package:clean_life/pages/settings.dart';
import 'package:clean_life/pages/water.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'ai_chat.dart';

void main() {
  runApp(MyApp());
}
// lib/main.dart

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isFirstRun = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // تهيئة اللغات المدعومة
    await _localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
        const MapLocale('fr', AppLocale.FR),
        const MapLocale('es', AppLocale.ES),
        const MapLocale('ru', AppLocale.RU),
        const MapLocale('tr', AppLocale.TR),
        const MapLocale('de', AppLocale.DE),
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;

    // التحقق من حالة أول تشغيل
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstRun = prefs.getBool('isFirstRun');
    if (isFirstRun == null || isFirstRun) {
      await prefs.setBool('isFirstRun', false);
      setState(() {
        _isFirstRun = true;
      });
    } else {
      setState(() {
        _isFirstRun = false;
      });
    }

    // تحميل تفضيلات اللغة المحفوظة
    _loadSavedLanguagePreference();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  void _loadSavedLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      _localization.translate(savedLanguageCode);
    }
  }

  void _saveLanguagePreference(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          supportedLocales: _localization.supportedLocales,
          localizationsDelegates: _localization.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home:  CombinedQualityScreen(),
          //          home: _isFirstRun ? SettingsScreen() : CombinedQualityScreen(),
        );
      },
    );
  }
}









class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Update 25 Feb 2020',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildDashboardItem('My Account', Icons.person),
                  _buildDashboardItem('Inventory', Icons.local_shipping),
                  _buildDashboardItem('Search Mechanic', Icons.build),
                  _buildDashboardItem('Request', Icons.request_page),
                  _buildDashboardItem('Analytics', Icons.analytics),
                  _buildDashboardItem('Contact us', Icons.contact_mail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على الزر يمكن إضافة أنيميشن أو أي شيء تفاعلي هنا
        print('Tapped on $title');
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: AnimatedScale(
          duration: Duration(milliseconds: 300),
          scale: 1.05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white).animate().fadeIn().move(begin: Offset(0, -30), end: Offset(0, 0), duration: 300.ms),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ).animate().fadeIn().move(begin: Offset(0, 30), end: Offset(0, 0), duration: 300.ms),
            ],
          ),
        ),
      ).animate().fadeIn().scale( duration: 500.ms),
    );
  }
}





















class AirPollutionHomePage extends StatefulWidget {
  @override
  _AirPollutionHomePageState createState() => _AirPollutionHomePageState();
}

class _AirPollutionHomePageState extends State<AirPollutionHomePage> {
  final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // مفتاح الـ API الخاص بك
  double lat = 24.7136; // خط العرض (مثال: الرياض)
  double lon = 46.6753; // خط الطول (مثال: الرياض)

  Map<String, dynamic>? airData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAirPollutionData();
  }

  Future<void> fetchAirPollutionData() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          airData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('فشل في جلب البيانات: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('حدث خطأ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('قياس تلوث الهواء'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : airData != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'بيانات تلوث الهواء للموقع:',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'مؤشر جودة الهواء (AQI): ${airData!['list'][0]['main']['aqi']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'تفاصيل الملوثات:',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              ...airData!['list'][0]['components'].entries.map((entry) {
                return Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(fontSize: 16),
                );
              }).toList(),
            ],
          ),
        )
            : Center(child: Text('لا توجد بيانات متاحة')));
  }
}




class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double _buttonScale = 1.0;
  bool _isBalanceVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isBalanceVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              _buildInteractiveSection(
                title: 'Hello, Robert Ross',
                subtitle: 'Welcome Back!',
                icon: Icons.person,
                onTap: () {
                  // تعامل مع الضغط على قسم المستخدم
                },
              ),

              SizedBox(height: 20),

              // Balance Section
              _buildInteractiveSection(
                title: 'Your Balance',
                subtitle: '\$1,490.00',
                icon: Icons.account_balance_wallet,
                onTap: () {
                  // تعامل مع الضغط على الرصيد
                },
              ),

              SizedBox(height: 20),

              // Buttons Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInteractiveButton(
                    icon: Icons.add,
                    label: 'Add Transaction',
                    onTap: () {
                      // التعامل مع الضغط على الزر "إضافة معاملة"
                    },
                  ),
                  _buildInteractiveButton(
                    icon: Icons.details,
                    label: 'View Details',
                    onTap: () {
                      // التعامل مع الضغط على الزر "عرض التفاصيل"
                    },
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Graph Section
              _buildInteractiveSection(
                title: 'Graph Here',
                subtitle: '',
                icon: Icons.show_chart,
                onTap: () {
                  // التعامل مع الضغط على الرسم البياني
                },
              ),

              SizedBox(height: 30),

              // Stats Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('60', 'Items', Colors.deepPurple[600]!),
                  _buildStatColumn('950', 'Transactions', Colors.teal[600]!),
                  _buildStatColumn('1100', 'Total Value', Colors.blue[600]!),
                ],
              ),

              SizedBox(height: 30),

              // Circular Stats Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircularStat('25%', Colors.blue),
                  _buildCircularStat('50%', Colors.orange),
                  _buildCircularStat('75%', Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بناء قسم تفاعلي
  Widget _buildInteractiveSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            Icon(
              icon,
              color: Colors.deepPurple[600],
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  // بناء زر تفاعلي
  Widget _buildInteractiveButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: _buttonScale,
        duration: Duration(milliseconds: 200),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(icon, color: Colors.white),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCircularStat(String percentage, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              percentage,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Progress',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}






// // شاشة جودة الهواء
// class AirQualityScreen extends StatefulWidget {
//   @override
//   _AirQualityScreenState createState() => _AirQualityScreenState();
// }
//
// class _AirQualityScreenState extends State<AirQualityScreen> {
//   String _airQuality = "جاري التحميل...";
//   String _location = "تحميل الموقع...";
//   bool _isLoading = false;
//
//   // بيانات ثابتة للمميزات (يمكنك استبدالها ببيانات من API)
//   final List<String> bestCountries = ['السويد', 'فنلندا', 'نيوزيلندا'];
//   final List<String> worstCountries = ['الهند', 'الصين', 'باكستان'];
//   final List<String> bestCities = ['كوبنهاغن', 'هلسنكي', 'أوسلو'];
//   final List<String> worstCities = ['دلهي', 'بكين', 'كاول بالمور'];
//
//   final TextEditingController _controller = TextEditingController();
//
//   // دالة لجلب بيانات جودة الهواء باستخدام الإحداثيات
//   Future<void> fetchAirQuality(double lat, double lon) async {
//     final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك
//
//     final url = Uri.parse(
//         'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');
//
//     setState(() {
//       _isLoading = true;
//       _airQuality = "جاري التحميل...";
//       _location = "تحميل الموقع...";
//     });
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           // استخراج مستوى جودة الهواء من استجابة الـ API
//           int aqi = data['list'][0]['main']['aqi'];
//           _airQuality = _getAirQuality(aqi);
//           _location = "موقعك الحالي";
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _airQuality = "حدث خطأ أثناء جلب البيانات.";
//           _location = "";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _airQuality = "خطأ في الاتصال بالإنترنت.";
//         _location = "";
//         _isLoading = false;
//       });
//     }
//   }
//   Future<void> fetchAirQualityWithCurrentLocation() async {
//     final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك
//
//     try {
//       // التحقق من تفعيل خدمات الموقع
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           _airQuality = "خدمات الموقع غير مفعلة.";
//           _location = "";
//           _isLoading = false;
//         });
//         return;
//       }
//
//       // التحقق من الأذونات
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             _airQuality = "تم رفض إذن الموقع.";
//             _location = "";
//             _isLoading = false;
//           });
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           _airQuality = "تم رفض إذن الموقع بشكل دائم.";
//           _location = "";
//           _isLoading = false;
//         });
//         return;
//       }
//
//       // الحصول على الموقع الحالي
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       final double lat = position.latitude;
//       final double lon = position.longitude;
//
//       // جلب اسم الموقع باستخدام الترميز الجغرافي العكسي
//       final reverseUrl = Uri.parse(
//           'http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$apiKey');
//
//       final reverseResponse = await http.get(reverseUrl);
//
//       String locationName = "موقعك الحالي";
//
//       if (reverseResponse.statusCode == 200) {
//         final List reverseData = json.decode(reverseResponse.body);
//         if (reverseData.isNotEmpty && reverseData[0]['name'] != null) {
//           locationName = reverseData[0]['name'];
//         }
//       }
//
//       // جلب جودة الهواء باستخدام الإحداثيات
//       final airQualityUrl = Uri.parse(
//           'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');
//
//       final airQualityResponse = await http.get(airQualityUrl);
//
//       if (airQualityResponse.statusCode == 200) {
//         final data = json.decode(airQualityResponse.body);
//         int aqi = data['list'][0]['main']['aqi'];
//         setState(() {
//           _airQuality = _getAirQuality(aqi);
//           _location = locationName;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _airQuality = "حدث خطأ أثناء جلب بيانات جودة الهواء.";
//           _location = "";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _airQuality = "خطأ في الاتصال بالإنترنت أو الحصول على الموقع.";
//         _location = "";
//         _isLoading = false;
//       });
//     }
//   }
//
//   // دالة للترميز الجغرافي المباشر (جلب الإحداثيات حسب اسم الموقع)
//   Future<void> fetchCoordinates(String cityName) async {
//     final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك
//
//     final url = Uri.parse(
//         'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey');
//
//     setState(() {
//       _isLoading = true;
//       _airQuality = "جاري التحميل...";
//       _location = "تحميل الموقع...";
//     });
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List data = json.decode(response.body);
//         if (data.isNotEmpty) {
//           final double lat = data[0]['lat'];
//           final double lon = data[0]['lon'];
//           final String locationName = data[0]['name'];
//           setState(() {
//             _location = "موقع: $locationName";
//           });
//           await fetchAirQuality(lat, lon);
//         } else {
//           setState(() {
//             _airQuality = "لم يتم العثور على الموقع.";
//             _location = "";
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _airQuality = "حدث خطأ أثناء جلب البيانات.";
//           _location = "";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _airQuality = "خطأ في الاتصال بالإنترنت.";
//         _location = "";
//         _isLoading = false;
//       });
//     }
//   }
//
//   // تحويل قيمة مؤشر جودة الهواء إلى نص
//   String _getAirQuality(int aqi) {
//     switch (aqi) {
//       case 1:
//         return "جيد";
//       case 2:
//         return "مقبول";
//       case 3:
//         return "متوسط";
//       case 4:
//         return "ضعيف";
//       case 5:
//         return "ضعيف جدًا";
//       default:
//         return "غير معروف";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // الحصول على ارتفاع الشاشة لتقسيمها
//     final screenHeight = MediaQuery.of(context).size.height;
//     final airQualityHeight = screenHeight * 0.25; // 25% من الشاشة
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('مؤشر جودة الهواء'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'أدخل اسم المدينة',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     String city = _controller.text.trim();
//                     if (city.isNotEmpty) {
//                       fetchCoordinates(city);
//                     }
//                   },
//                   child: Text('بحث'),
//                 ),
//               ],
//             ),
//           ),
//
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               fetchAirQualityWithCurrentLocation();
//             },
//             tooltip: 'تحديث',
//           ),
//         ],
//       ),      body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//         children: [
//           // قسم البحث عن المدينة
//           // قسم مؤشر جودة الهواء
//           _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : Column(
//             children: [
//               // قسم مؤشر جودة الهواء
//               Container(
//                 height: airQualityHeight,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: _getGradientColors(_airQuality),
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _location,
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white70,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'مؤشر جودة الهواء: $_airQuality',
//                         style: TextStyle(
//                           fontSize: 24,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // باقي الصفحة للمميزات
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ListView(
//                     children: [
//                       // أفضل الدول في جودة الهواء
//                       Text(
//                         'أفضل الدول في جودة الهواء',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       ...bestCountries.map((country) => ListTile(
//                         leading: Icon(Icons.thumb_up, color: Colors.green),
//                         title: Text(country),
//                       )),
//                       SizedBox(height: 20),
//                       // أسوأ الدول في جودة الهواء
//                       Text(
//                         'أسوأ الدول في جودة الهواء',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       ...worstCountries.map((country) => ListTile(
//                         leading:
//                         Icon(Icons.thumb_down, color: Colors.red),
//                         title: Text(country),
//                       )),
//                       SizedBox(height: 20),
//                       // أفضل المدن في جودة الهواء
//                       Text(
//                         'أفضل المدن في جودة الهواء',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       ...bestCities.map((city) => ListTile(
//                         leading: Icon(Icons.thumb_up, color: Colors.green),
//                         title: Text(city),
//                       )),
//                       SizedBox(height: 20),
//                       // أسوأ المدن في جودة الهواء
//                       Text(
//                         'أسوأ المدن في جودة الهواء',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       ...worstCities.map((city) => ListTile(
//                         leading:
//                         Icon(Icons.thumb_down, color: Colors.red),
//                         title: Text(city),
//                       )),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),          // باقي الصفحة للمميزات
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   // أفضل الدول في جودة الهواء
//                   Text(
//                     'أفضل الدول في جودة الهواء',
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   ...bestCountries.map((country) => ListTile(
//                     leading: Icon(Icons.thumb_up, color: Colors.green),
//                     title: Text(country),
//                   )),
//                   SizedBox(height: 20),
//                   // أسوأ الدول في جودة الهواء
//                   Text(
//                     'أسوأ الدول في جودة الهواء',
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   ...worstCountries.map((country) => ListTile(
//                     leading:
//                     Icon(Icons.thumb_down, color: Colors.red),
//                     title: Text(country),
//                   )),
//                   SizedBox(height: 20),
//                   // أفضل المدن في جودة الهواء
//                   Text(
//                     'أفضل المدن في جودة الهواء',
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   ...bestCities.map((city) => ListTile(
//                     leading: Icon(Icons.thumb_up, color: Colors.green),
//                     title: Text(city),
//                   )),
//                   SizedBox(height: 20),
//                   // أسوأ المدن في جودة الهواء
//                   Text(
//                     'أسوأ المدن في جودة الهواء',
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   ...worstCities.map((city) => ListTile(
//                     leading:
//                     Icon(Icons.thumb_down, color: Colors.red),
//                     title: Text(city),
//                   )),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   List<Color> _getGradientColors(String airQuality) {
//     switch (airQuality) {
//       case "جيد":
//         return [Colors.green, Colors.lightGreen];
//       case "مقبول":
//         return [Colors.yellow, Colors.orange];
//       case "متوسط":
//         return [Colors.orange, Colors.deepOrange];
//       case "ضعيف":
//         return [Colors.red, Colors.deepOrange];
//       case "ضعيف جدًا":
//         return [Colors.brown, Colors.redAccent];
//       default:
//         return [Colors.grey, Colors.blueGrey];
//     }
//   }
//
// }
//
// // شاشة أفضل وأسوأ الدول والمدن








