import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language.dart';

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  double airQuality = 0.0;
  bool isLoading = true;
  Position? _currentPosition;
  GoogleMapController? _mapController;

  // استبدل هذا بمفتاح API الخاص بك من OpenWeatherMap
  final String apiKey = '85a38e33702779880006e1eb0f8ee104';

  // Air quality message lists
  final List<String> lowQualityMessages = [
    'Air quality is low, please take precautions!',
    'The air is polluted, take care of your health!',
    'Pollution is high, reduce outdoor activities!'
  ];

  final List<String> goodQualityMessages = [
    'Air quality is good, enjoy your environment!',
    'The air is clean, you can breathe easily!',
    'Excellent atmosphere, perfect time for outdoor activities!'
  ];

  // الفهرس الافتراضي للرسائل
  int selectedLowQualityMessageIndex = 0;
  int selectedGoodQualityMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // دالة لتهيئة البيانات عند بدء التطبيق
  Future<void> _initializeData() async {
    await _loadSavedAirQuality();
    await _loadSavedMessageIndices(); // تحميل الرسائل المحفوظة
    await _determinePosition();
  }

  // دالة لتحميل جودة الهواء المحفوظة في SharedPreferences
  Future<void> _loadSavedAirQuality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? savedAQI = prefs.getDouble('airQuality');
    if (savedAQI != null) {
      setState(() {
        airQuality = savedAQI;
        isLoading = false;
      });
    }
  }

  // دالة لتحميل مؤشرات الرسائل المحفوظة
  Future<void> _loadSavedMessageIndices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLowQualityMessageIndex =
          prefs.getInt('selectedLowQualityMessageIndex') ?? 0;
      selectedGoodQualityMessageIndex =
          prefs.getInt('selectedGoodQualityMessageIndex') ?? 0;
    });
  }

  // دالة لحفظ مؤشرات الرسائل
  Future<void> _saveSelectedMessageIndices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedLowQualityMessageIndex',
        selectedLowQualityMessageIndex);
    await prefs.setInt('selectedGoodQualityMessageIndex',
        selectedGoodQualityMessageIndex);
  }

  // دالة لتحديد موقع المستخدم وجلب بيانات جودة الهواء
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق مما إذا كانت خدمات الموقع مفعلة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServiceDialog();
      return;
    }

    // التحقق من حالة الأذونات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // طلب الأذونات
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // إذا تم رفض الأذونات
        await _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // إذا تم رفض الأذونات بشكل دائم
      await _showPermissionDeniedForeverDialog();
      return;
    }

    // الحصول على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      isLoading = true; // بدء عملية التحميل
    });

    // جلب بيانات جودة الهواء
    await fetchAirQuality();
  }

  // Function to show a dialog when location services are disabled
  Future<void> _showLocationServiceDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Location Services Disabled'),
        content:
        Text('Please enable location services to access the app features.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // دالة لعرض حوار عند رفض الأذونات
  Future<void> _showPermissionDeniedDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${AppLocale.air64.getString(context)}'),
        content: Text('${AppLocale.air65.getString(context)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _determinePosition();
            },
            child: Text('${AppLocale.air66.getString(context)}'),
          ),
        ],
      ),
    );
  }

  // دالة لعرض حوار عند رفض الأذونات بشكل دائم
  Future<void> _showPermissionDeniedForeverDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${AppLocale.air67.getString(context)}'),
        content: Text(
            '${AppLocale.air68.getString(context)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Geolocator.openAppSettings();
            },
            child: Text('${AppLocale.air69.getString(context)}'),
          ),
        ],
      ),
    );
  }

  // دالة لجلب بيانات جودة الهواء وتخزينها في SharedPreferences
  Future<void> fetchAirQuality() async {
    if (_currentPosition == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=${_currentPosition!.latitude}&lon=${_currentPosition!.longitude}&appid=$apiKey',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double fetchedAQI = data['list'][0]['main']['aqi'].toDouble();

        setState(() {
          airQuality = fetchedAQI;
          isLoading = false;
        });

        // حفظ القيمة في SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('airQuality', fetchedAQI);
      } else {
        setState(() {
          isLoading = false;
        });
        showErrorDialog(
            '${AppLocale.air70.getString(context)}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorDialog(
          '${AppLocale.air71.getString(context)}');
    }
  }

  // دالة لعرض رسالة خطأ
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${AppLocale.air72.getString(context)}'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('${AppLocale.air63.getString(context)}ً'),
          ),
        ],
      ),
    );
  }

  // تحويل مؤشر جودة الهواء إلى قيمة قابلة للعرض
  String get airQualityText {
    switch (airQuality.toInt()) {
      case 1:
        return '${AppLocale.air28.getString(context)}';
      case 2:
        return '${AppLocale.air29.getString(context)}';
      case 3:
        return '${AppLocale.air76.getString(context)}';
      case 4:
        return '${AppLocale.air77.getString(context)}';
      case 5:
        return '${AppLocale.air78.getString(context)}';
      default:
        return '${AppLocale.air33.getString(context)}';
    }
  }

  // تحديد اللون بناءً على جودة الهواء
  Color get containerColor {
    switch (airQuality.toInt()) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // تحديد الحجم بناءً على جودة الهواء
  double get containerSize {
    switch (airQuality.toInt()) {
      case 1:
        return 100;
      case 2:
        return 150;
      case 3:
        return 200;
      case 4:
        return 250;
      case 5:
        return 300;
      default:
        return 100;
    }
  }

  // إنشاء Marker لموقع المستخدم
  Marker _createMarker() {
    return Marker(
      markerId: MarkerId('currentLocation'),
      position:
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      infoWindow: InfoWindow(title: '${AppLocale.air21.getString(context)}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // تحديد ما إذا كانت جودة الهواء جيدة أم لا
    bool isGoodQuality = airQuality <= 2; // مثال: AQI ≤ 2 جيد

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocale.air81.getString(context)}'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await _determinePosition();
            },
          ),

        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // تأثير الأنيميشن على مستوى جودة الهواء باستخدام AnimatedContainer
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : AnimatedContainer(
              duration: Duration(seconds: 2),
              height: 100,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${AppLocale.air82.getString(context)}: $airQualityText',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          SizedBox(height: 30),

          // النصوص التفصيلية حول جودة الهواء داخل Card مع تحسين التصميم
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Card(
              key: ValueKey<int>(1),
              color: Colors.purple.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${AppLocale.air83.getString(context)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),

          // قسم النصائح مع تأثير انيميشن على ظهور النصوص
          Text(
            '${AppLocale.air84.getString(context)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          ...List.generate(7, (index) {
            return AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: 1.0,
              child: Card(
                key: ValueKey<int>(index),
                color: Colors.purple.shade50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                margin: EdgeInsets.only(bottom: 15),

              ),
            );
          }),

          SizedBox(height: 20),

          // قسم النصائح الإضافية
          Text(
            '${AppLocale.air85.getString(context)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          ...List.generate(4, (index) {
            return AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: 1.0,
              child: Card(
                key: ValueKey<int>(index + 7),
                color: Colors.purple.shade50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                margin: EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _getAdditionalTipText(index + 1),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            );
          }),

          SizedBox(height: 30),

          // قسم الخاتمة مع الرسالة المعتمدة على جودة الهواء
          AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: isGoodQuality ? 1.0 : 0.5,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                isGoodQuality ? Colors.purple.shade100 : Colors.purple.shade50,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                isGoodQuality
                    ? goodQualityMessages[selectedGoodQualityMessageIndex]
                    : lowQualityMessages[selectedLowQualityMessageIndex],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SizedBox(height: 30),

          // قسم الخاتمة العامة مع تأثير انيميشن
          AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${AppLocale.air86.getString(context)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      // عرض خريطة لموقع المستخدم إذا كان متاحًا
    );
  }

  // دالة لاسترجاع نصائح التعامل مع جودة الهواء

  // دالة لاسترجاع نصائح إضافية
  String _getAdditionalTipText(int tipNumber) {
    switch (tipNumber) {
      case 1:
        return '${AppLocale.air94.getString(context)}';
      case 2:
        return '${AppLocale.air95.getString(context)}';
      case 3:
        return '${AppLocale.air96.getString(context)}';
      case 4:
        return '${AppLocale.air97.getString(context)}';
      default:
        return '';
    }
  }

}
