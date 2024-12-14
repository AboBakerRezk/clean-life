import 'package:clean_life/pages/about.dart';
import 'package:clean_life/pages/advice.dart';
import 'package:clean_life/pages/country.dart';
import 'package:clean_life/pages/detals.dart';
import 'package:clean_life/pages/game.dart';
import 'package:clean_life/pages/language.dart';
import 'package:clean_life/pages/pullutants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts; // استخدام اسم مستعار
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'ai_chat.dart';




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart'; // تأكد من إضافة هذا الحزمة في pubspec.yaml

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لـ rootBundle
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart'; // تأكد من إضافة الحزمة في pubspec.yaml

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CombinedQualityScreen extends StatefulWidget {
  @override
  _CombinedQualityScreenState createState() => _CombinedQualityScreenState();
}

class _CombinedQualityScreenState extends State<CombinedQualityScreen> {
  // متحكم البحث
  final TextEditingController _controller = TextEditingController();

  // متغيرات جودة الهواء
  String _airQuality = AppLocale.air1;
  String _location = AppLocale.air2;
  bool _isLoadingAirQuality = false;

  // متغيرات جودة المياه
  List<dynamic> _waterQualityData = [];
  bool _isLoadingWaterQuality = false;
  String _waterErrorMessage = '';

  // رسائل الخطأ العامة
  String _generalErrorMessage = '';

  // مفتاح API الخاص بك
  final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // تأكد من أمان المفاتيح في التطبيق الفعلي

  // علم لضمان استدعاء _fetchAllQualityData مرة واحدة فقط
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // تجنب استدعاء _fetchAllQualityData هنا
    // أي تهيئة غير معتمدة على السياق يمكن أن تبقى هنا
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _fetchAllQualityData();
    }
  }

  // دالة لجلب كل من جودة الهواء والمياه بناءً على الموقع الحالي
  Future<void> _fetchAllQualityData() async {
    setState(() {
      _isLoadingAirQuality = true;
      _isLoadingWaterQuality = true;
      _generalErrorMessage = '';
      _airQuality = "${AppLocale.air1.getString(context)}";
      _location = "${AppLocale.air2.getString(context)}";
      _waterQualityData = [];
      _waterErrorMessage = '';
    });

    try {
      // التحقق من تفعيل خدمات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _generalErrorMessage = '${AppLocale.air18.getString(context)}';
          _isLoadingAirQuality = false;
          _isLoadingWaterQuality = false;
        });
        return;
      }

      // التحقق من الأذونات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _generalErrorMessage = '${AppLocale.air19.getString(context)}';
            _isLoadingAirQuality = false;
            _isLoadingWaterQuality = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _generalErrorMessage =
          '${AppLocale.air20.getString(context)}';
          _isLoadingAirQuality = false;
          _isLoadingWaterQuality = false;
        });
        return;
      }

      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final double lat = position.latitude;
      final double lon = position.longitude;

      // جلب اسم الموقع والدولة باستخدام الترميز الجغرافي العكسي
      final reverseUrl = Uri.parse(
          'https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$apiKey');

      final reverseResponse = await http.get(reverseUrl);

      String locationName = "${AppLocale.air21.getString(context)}";
      String country = '';

      if (reverseResponse.statusCode == 200) {
        final List reverseData = json.decode(reverseResponse.body);
        if (reverseData.isNotEmpty) {
          locationName = reverseData[0]['name'] ?? "${AppLocale.air21.getString(context)}";
          country = reverseData[0]['country'] ?? '';
        }
      }

      setState(() {
        _location = locationName;
      });

      // جلب جودة الهواء باستخدام الإحداثيات
      await _fetchAirQuality(lat, lon);

      // جلب جودة المياه بناءً على اسم الدولة
      if (country.isNotEmpty) {
        await _fetchWaterQualityData(country);
      } else {
        setState(() {
          _waterErrorMessage = '${AppLocale.air26.getString(context)}';
          _isLoadingWaterQuality = false;
        });
      }
    } catch (e) {
      setState(() {
        _generalErrorMessage = '${AppLocale.air16.getString(context)}: $e';
        _isLoadingAirQuality = false;
        _isLoadingWaterQuality = false;
      });
      print("Error fetching data: $e");
    }
  }

  // دالة لجلب جودة الهواء
  Future<void> _fetchAirQuality(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['list'] != null && data['list'].isNotEmpty) {
          int aqi = data['list'][0]['main']['aqi'];
          setState(() {
            _airQuality = _getAirQuality(aqi);
            _isLoadingAirQuality = false;
          });
        } else {
          setState(() {
            _airQuality = "${AppLocale.air16.getString(context)}";
            _isLoadingAirQuality = false;
          });
        }
      } else {
        setState(() {
          _airQuality = "${AppLocale.air16.getString(context)}";
          _isLoadingAirQuality = false;
        });
      }
    } catch (e) {
      setState(() {
        _airQuality = "${AppLocale.air17.getString(context)}";
        _isLoadingAirQuality = false;
      });
      print("Error fetching air quality: $e");
    }
  }

  // دالة لجلب جودة المياه بناءً على الدولة من ملف JSON محلي
  Future<void> _fetchWaterQualityData(String country) async {
    try {
      // تحميل ملف JSON من الأصول
      String jsonString = await rootBundle.loadString('assets/country.json');
      List<dynamic> jsonResponse = json.decode(jsonString);

      // البحث عن الدولة المطلوبة
      List<dynamic> filteredData = jsonResponse.where((item) {
        return item['country']
            .toString()
            .toLowerCase()
            .contains(country.toLowerCase());
      }).toList();

      if (filteredData.isEmpty) {
        setState(() {
          _waterErrorMessage =
          '${AppLocale.air26.getString(context)}: $country.';
          _isLoadingWaterQuality = false;
        });
      } else {
        setState(() {
          _waterQualityData = filteredData;
          _isLoadingWaterQuality = false;
        });
      }
    } catch (e) {
      setState(() {
        _waterErrorMessage = '${AppLocale.air16.getString(context)}: $e';
        _isLoadingWaterQuality = false;
      });
      print("Error loading JSON: $e");
    }
  }

  // دالة للبحث اليدوي عند إدخال اسم الموقع أو الدولة
  Future<void> _manualSearch() async {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _isLoadingAirQuality = true;
        _isLoadingWaterQuality = true;
        _generalErrorMessage = '';
        _airQuality = "${AppLocale.air1.getString(context)}";
        _location = "${AppLocale.air2.getString(context)}";
        _waterQualityData = [];
        _waterErrorMessage = '';
      });

      try {
        // جلب الإحداثيات بناءً على اسم المدينة
        final geoUrl = Uri.parse(
            'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=1&appid=$apiKey');

        final geoResponse = await http.get(geoUrl);

        if (geoResponse.statusCode == 200) {
          final List geoData = json.decode(geoResponse.body);
          if (geoData.isNotEmpty) {
            final double lat = geoData[0]['lat'];
            final double lon = geoData[0]['lon'];
            final String locationName = geoData[0]['name'] ?? query;
            final String country = geoData[0]['country'] ?? '';

            setState(() {
              _location = locationName;
            });

            // جلب جودة الهواء والمياه بناءً على الإحداثيات والدولة
            await _fetchAirQuality(lat, lon);
            if (country.isNotEmpty) {
              await _fetchWaterQualityData(country);
            } else {
              setState(() {
                _waterErrorMessage = '${AppLocale.air26.getString(context)}';
                _isLoadingWaterQuality = false;
              });
            }
          } else {
            setState(() {
              _generalErrorMessage = "${AppLocale.air26.getString(context)}";
              _isLoadingAirQuality = false;
              _isLoadingWaterQuality = false;
            });
          }
        } else {
          setState(() {
            _generalErrorMessage = "${AppLocale.air16.getString(context)}";
            _isLoadingAirQuality = false;
            _isLoadingWaterQuality = false;
          });
        }
      } catch (e) {
        setState(() {
          _generalErrorMessage =
          "${AppLocale.air24.getString(context)}";
          _isLoadingAirQuality = false;
          _isLoadingWaterQuality = false;
        });
        print("Error in manual search: $e");
      }
    } else {
      setState(() {
        _generalErrorMessage = '${AppLocale.airs1.getString(context)}';
      });
    }
  }
  // تحويل قيمة مؤشر جودة الهواء إلى نص
  String _getAirQuality(int aqi) {
    switch (aqi) {
      case 1:
        return "${AppLocale.air28.getString(context)}";
      case 2:
        return "${AppLocale.air29.getString(context)}";
      case 3:
        return "${AppLocale.air30.getString(context)}";
      case 4:
        return "${AppLocale.air31.getString(context)}";
      case 5:
        return "${AppLocale.air32.getString(context)}";
      default:
        return "${AppLocale.air33.getString(context)}";
    }
  }

  // دالة لتحويل درجة جودة المياه الرقمية إلى وصفية
  String _getWaterQualityGrade(double score) {
    if (score >= 80) {
      return "${AppLocale.air28.getString(context)}";
    } else if (score >= 60) {
      return "${AppLocale.air29.getString(context)}";
    } else if (score >= 40) {
      return "${AppLocale.air30.getString(context)}";
    } else if (score >= 20) {
      return "${AppLocale.air31.getString(context)}";
    } else {
      return "${AppLocale.air32.getString(context)}";
    }
  }

// تحديد ألوان التدرج بناءً على جودة الهواء
  List<Color> _getGradientColors(String airQuality) {
    // الحصول على النصوص المترجمة
    final String goodQuality = AppLocale.air28.getString(context) ?? "${AppLocale.air28.getString(context)}";
    final String acceptableQuality = "${AppLocale.air29.getString(context)}";
    final String moderateQuality = "${AppLocale.air30.getString(context)}";
    final String poorQuality = "${AppLocale.air31.getString(context)}";
    final String veryPoorQuality = "${AppLocale.air32.getString(context)}";

    // استخدام if-else بدلاً من switch
    if (airQuality == goodQuality || airQuality == "${AppLocale.air28.getString(context)}") {
      return [Colors.green, Colors.lightGreen];
    } else if (airQuality == acceptableQuality) {
      return [Colors.yellow, Colors.orange];
    } else if (airQuality == moderateQuality) {
      return [Colors.orange, Colors.deepOrange];
    } else if (airQuality == poorQuality) {
      return [Colors.red, Colors.deepOrange];
    } else if (airQuality == veryPoorQuality) {
      return [Colors.brown, Colors.redAccent];
    } else {
      return [Colors.grey, Colors.blueGrey];
    }
  }


// تحديد ألوان التدرج بناءً على درجة جودة المياه
  // تحديد ألوان التدرج بناءً على درجة جودة المياه
  List<Color> _getWaterGradientColors(String grade) {
    if (grade == "${AppLocale.air28.getString(context)}") { // استبدل النص بـ AppLocale.waterGood.getString(context) إذا كنت تستخدم الترجمة
      return [Colors.blue, Colors.lightBlue];
    } else if (grade == "${AppLocale.air29.getString(context)}") { // استبدل النص بـ AppLocale.waterAcceptable.getString(context)
      return [Colors.teal, Colors.cyan];
    } else if (grade == "${AppLocale.air30.getString(context)}") { // استبدل النص بـ AppLocale.waterModerate.getString(context)
      return [Colors.yellow, Colors.amber];
    } else if (grade == "${AppLocale.air31.getString(context)}") { // استبدل النص بـ AppLocale.waterPoor.getString(context)
      return [Colors.orange, Colors.deepOrange];
    } else if (grade == "${AppLocale.air32.getString(context)}") { // استبدل النص بـ AppLocale.waterVeryPoor.getString(context)
      return [Colors.red, Colors.redAccent];
    } else {
      return [Colors.grey, Colors.blueGrey];
    }
  }
  // final FlutterLocalization _localization = FlutterLocalization.instance;
  // bool _isPermissionChecked = false;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_isPermissionChecked) {
  //     _checkLocationPermission();
  //     _isPermissionChecked = true;
  //   }
  // }
  //
  // Future<void> _checkLocationPermission() async {
  //   PermissionStatus status = await Permission.location.status;
  //   if (!status.isGranted) {
  //     PermissionStatus result = await Permission.location.request();
  //     if (result.isGranted) {
  //       // تم منح الإذن
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('تم منح إذن الوصول إلى الموقع.')),
  //       );
  //     } else if (result.isDenied) {
  //       // تم رفض الإذن
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('تم رفض إذن الوصول إلى الموقع.')),
  //       );
  //     } else if (result.isPermanentlyDenied) {
  //       // تم رفض الإذن بشكل دائم
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('تم رفض إذن الموقع بشكل دائم. يمكنك تمكينه من إعدادات التطبيق.'),
  //           action: SnackBarAction(
  //             label: 'إعدادات',
  //             onPressed: () {
  //               openAppSettings();
  //             },
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     // الإذن مُمنوح مسبقًا
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('إذن الموقع مُمنوح بالفعل.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // الحصول على ارتفاع الشاشة لتقسيمها
    final screenHeight = MediaQuery.of(context).size.height;
    final qualityHeight = screenHeight * 0.25; // 25% من الشاشة لكل قسم

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(
          '${AppLocale.air34.getString(context)}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchAllQualityData,
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );// يعود إلى الصفحة السابقة (الصفحة الرئيسية)

              // التعامل مع الضغط على الإعدادات
            },
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // حقل البحث وزر البحث اليدوي
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: '${AppLocale.airs1.getString(context)}',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => _manualSearch(),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _manualSearch,
                    child: IconButton(onPressed: (){},   icon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // عرض رسالة الخطأ العامة إذا وجدت
              if (_generalErrorMessage.isNotEmpty)
                Center(
                  child: Text(
                    _generalErrorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),

              // عرض مؤشر التحميل أو جودة الهواء
              if (_isLoadingAirQuality)
                Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                )
              else if (_airQuality.isNotEmpty)
                GestureDetector(
                  onTap: _fetchAllQualityData,
                  child: Container(
                    height: qualityHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _getGradientColors(_airQuality),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isLoadingAirQuality
                          ? CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _location,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${AppLocale.air36.getString(context)}: $_airQuality',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 20),

              // عرض مؤشر التحميل أو جودة المياه
              if (_isLoadingWaterQuality)
                Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                )
              else if (_waterErrorMessage.isNotEmpty)
                Center(
                  child: Text(
                    _waterErrorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              else if (_waterQualityData.isNotEmpty)
                  Container(
                    height: qualityHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _getWaterGradientColors(
                          _getWaterQualityGrade(
                            double.tryParse(
                                _waterQualityData[0]['WaterQuality_EPIDrinkingWaterScore_2024']?.toString() ??
                                    '0') ??
                                0,
                          ),
                        ),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: _waterQualityData.length,
                      itemBuilder: (context, index) {
                        final data = _waterQualityData[index];
                        double score = double.tryParse(
                            data['WaterQuality_EPIDrinkingWaterScore_2024']
                                ?.toString() ??
                                '0') ??
                            0;
                        String grade = _getWaterQualityGrade(score);
                        return ListTile(
                          title: Text(
                            data['country'] ?? 'Without a name',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${AppLocale.airs36.getString(context)}: $score',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                '${AppLocale.airs37.getString(context)} $grade',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                else
                  Center(
                    child: Text(
                      '${AppLocale.airs38.getString(context)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر "الدول الافضل والاسوء"
                  _buildDashboardItem(context, '${AppLocale.air39.getString(context)}',
                      Icons.analytics, HomeScreen()), // استبدل بـ Widget المناسب

                  // زر "خريطة"
                  _buildDashboardItem(
                      context, 'AI', Icons.adb, ChatScreen22()), // استبدل بـ Widget المناسب
                ],
              ),
              SizedBox(height: 16),

              // قسم الأزرار المدمجة (يمكنك تعديلها أو إضافة المزيد حسب الحاجة)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر "نصائح للتعامل مع جودة الهواء والمياه الحالية"
                  _buildDashboardItem(
                      context,
                      '''${AppLocale.air37.getString(context)}''',
                      Icons.person,
                      AirQualityPage()), // استبدل بـ Widget المناسب

                  // زر "الملوثات وتركيزاتها"
                  _buildDashboardItem(
                      context,
                      '${AppLocale.air38.getString(context)}',
                      Icons.air_outlined,
                      AirPollutantsPage()), // استبدل بـ Widget المناسب
                ],
              ),


              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر "حول التطبيق"
                  _buildDashboardItem(
                      context, '${AppLocale.air41.getString(context)}', Icons.info, AboutPage()), // استبدل بـ Widget المناسب

                  // زر "تعلم المزيد"
                  // _buildDashboardItem(
                  //     context, '${AppLocale.air42.getString(context)}', Icons.contact_mail, ChatScreen22()), // استبدل بـ Widget المناسب
                ],
              ),
              SizedBox(height: 30),

              // قسم الإحصائيات الدائرية (يمكنك تخصيصها حسب البيانات)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     _buildCircularStat('25%', Colors.blue, '${AppLocale.air43.getString(context)}'),
              //     _buildCircularStat('50%', Colors.orange, '${AppLocale.air44.getString(context)}'),
              //     _buildCircularStat('75%', Colors.red, '${AppLocale.air45.getString(context)}'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // تعريف دالة _buildDashboardItem داخل الكلاس فقط
  Widget _buildDashboardItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على الزر، الانتقال إلى الصفحة المحددة
        print('Tapped on $title');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 160, // زيادة العرض لاستيعاب النصوص الطويلة
        height: 120, // زيادة الارتفاع لتحسين التوزيع
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade700
            ],
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40, // تقليل حجم الأيقونة لتوفير مساحة للنص
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14, // تقليل حجم الخط ليتناسب مع النص الطويل
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis, // إذا كان النص كبيرًا جدًا يتم تقليصه
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // بناء الإحصائيات الدائرية
  Widget _buildCircularStat(String percentage, Color color, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 3),
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
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}


// تعريف صفحة AirQualityScreen
class AirQualityScreen extends StatefulWidget {
  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  String _airQuality = "جاري التحميل...";
  String _location = "تحميل الموقع...";
  bool _isLoadingAirQuality = false;

  // بيانات ثابتة للمميزات (يمكنك استبدالها ببيانات من API)
  final List<String> bestCountries = ['السويد', 'فنلندا', 'نيوزيلندا'];
  final List<String> worstCountries = ['الهند', 'الصين', 'باكستان'];
  final List<String> bestCities = ['كوبنهاغن', 'هلسنكي', 'أوسلو'];
  final List<String> worstCities = ['دلهي', 'بكين', 'كاول بالمور'];

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // جلب جودة الهواء باستخدام الموقع الحالي عند فتح الشاشة
    fetchAirQualityWithCurrentLocation();
  }

  // دالة لجلب بيانات جودة الهواء باستخدام الإحداثيات
  Future<void> fetchAirQuality(double lat, double lon) async {
    final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك

    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');

    setState(() {
      _isLoadingAirQuality = true;
      _airQuality = "جاري التحميل...";
      _location = "تحميل الموقع...";
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['list'] != null && data['list'].isNotEmpty) {
          int aqi = data['list'][0]['main']['aqi'];
          setState(() {
            _airQuality = _getAirQuality(aqi);
            _isLoadingAirQuality = false;
          });
        } else {
          setState(() {
            _airQuality = "لم يتم العثور على بيانات جودة الهواء.";
            _location = "";
            _isLoadingAirQuality = false;
          });
        }
      } else {
        setState(() {
          _airQuality = "حدث خطأ أثناء جلب البيانات.";
          _location = "";
          _isLoadingAirQuality = false;
        });
      }
    } catch (e) {
      setState(() {
        _airQuality = "خطأ في الاتصال بالإنترنت.";
        _location = "";
        _isLoadingAirQuality = false;
      });
      print("Error fetching air quality: $e"); // لطباعة الخطأ في الكونسول
    }
  }

  // دالة لجلب جودة الهواء باستخدام الموقع الحالي
  Future<void> fetchAirQualityWithCurrentLocation() async {
    final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك

    setState(() {
      _isLoadingAirQuality = true;
    });

    try {
      // التحقق من تفعيل خدمات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _airQuality = "خدمات الموقع غير مفعلة.";
          _location = "";
          _isLoadingAirQuality = false;
        });
        return;
      }

      // التحقق من الأذونات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _airQuality = "تم رفض إذن الموقع.";
            _location = "";
            _isLoadingAirQuality = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _airQuality = "تم رفض إذن الموقع بشكل دائم.";
          _location = "";
          _isLoadingAirQuality = false;
        });
        return;
      }

      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final double lat = position.latitude;
      final double lon = position.longitude;

      // جلب اسم الموقع باستخدام الترميز الجغرافي العكسي
      final reverseUrl = Uri.parse(
          'https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$apiKey');

      final reverseResponse = await http.get(reverseUrl);

      String locationName = "موقعك الحالي";

      if (reverseResponse.statusCode == 200) {
        final List reverseData = json.decode(reverseResponse.body);
        if (reverseData.isNotEmpty && reverseData[0]['name'] != null) {
          locationName = reverseData[0]['name'];
        }
      }

      // جلب جودة الهواء باستخدام الإحداثيات
      final airQualityUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');

      final airQualityResponse = await http.get(airQualityUrl);

      if (airQualityResponse.statusCode == 200) {
        final data = json.decode(airQualityResponse.body);
        if (data['list'] != null && data['list'].isNotEmpty) {
          int aqi = data['list'][0]['main']['aqi'];
          setState(() {
            _airQuality = _getAirQuality(aqi);
            _location = locationName;
            _isLoadingAirQuality = false;
          });
        } else {
          setState(() {
            _airQuality = "لم يتم العثور على بيانات جودة الهواء.";
            _location = "";
            _isLoadingAirQuality = false;
          });
        }
      } else {
        setState(() {
          _airQuality = "حدث خطأ أثناء جلب بيانات جودة الهواء.";
          _location = "";
          _isLoadingAirQuality = false;
        });
      }
    } catch (e) {
      setState(() {
        _airQuality = "خطأ في الاتصال بالإنترنت أو الحصول على الموقع.";
        _location = "";
        _isLoadingAirQuality = false;
      });
      print("Error fetching air quality with current location: $e"); // لطباعة الخطأ في الكونسول
    }
  }

  // دالة للترميز الجغرافي المباشر (جلب الإحداثيات حسب اسم الموقع)
  Future<void> fetchCoordinates(String cityName) async {
    final String apiKey = '85a38e33702779880006e1eb0f8ee104'; // ضع هنا مفتاح الـ API الخاص بك

    final url = Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey');

    setState(() {
      _isLoadingAirQuality = true;
      _airQuality = "جاري التحميل...";
      _location = "تحميل الموقع...";
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          final double lat = data[0]['lat'];
          final double lon = data[0]['lon'];
          final String locationName = data[0]['name'] ?? cityName;
          setState(() {
            _location = "موقع: $locationName";
          });
          await fetchAirQuality(lat, lon);
        } else {
          setState(() {
            _airQuality = "لم يتم العثور على الموقع.";
            _location = "";
            _isLoadingAirQuality = false;
          });
        }
      } else {
        setState(() {
          _airQuality = "حدث خطأ أثناء جلب البيانات.";
          _location = "";
          _isLoadingAirQuality = false;
        });
      }
    } catch (e) {
      setState(() {
        _airQuality = "خطأ في الاتصال بالإنترنت.";
        _location = "";
        _isLoadingAirQuality = false;
      });
      print("Error fetching coordinates: $e"); // لطباعة الخطأ في الكونسول
    }
  }

  // تحويل قيمة مؤشر جودة الهواء إلى نص
  String _getAirQuality(int aqi) {
    switch (aqi) {
      case 1:
        return "جيد";
      case 2:
        return "مقبول";
      case 3:
        return "متوسط";
      case 4:
        return "ضعيف";
      case 5:
        return "ضعيف جدًا";
      default:
        return "غير معروف";
    }
  }

  // تحديد ألوان التدرج بناءً على جودة الهواء
  List<Color> _getGradientColors(String airQuality) {
    switch (airQuality) {
      case "جيد":
        return [Colors.green, Colors.lightGreen];
      case "مقبول":
        return [Colors.yellow, Colors.orange];
      case "متوسط":
        return [Colors.orange, Colors.deepOrange];
      case "ضعيف":
        return [Colors.red, Colors.deepOrange];
      case "ضعيف جدًا":
        return [Colors.brown, Colors.redAccent];
      default:
        return [Colors.grey, Colors.blueGrey];
    }
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على ارتفاع الشاشة لتقسيمها
    final screenHeight = MediaQuery.of(context).size.height;
    final airQualityHeight = screenHeight * 0.25; // 25% من الشاشة

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(
          'مؤشر جودة الهواء',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchAirQualityWithCurrentLocation();
              // يمكنك إضافة وظائف إضافية هنا للتعامل مع الضغط على الإشعارات
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );// يعود إلى الصفحة السابقة (الصفحة الرئيسية)

              // التعامل مع الضغط على الإعدادات
            },
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
              // قسم البحث والتحديث
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'أدخل اسم المدينة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String city = _controller.text.trim();
                      if (city.isNotEmpty) {
                        fetchCoordinates(city);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[600],
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // قسم مؤشر جودة الهواء
              GestureDetector(
                onTap: () {
                  fetchAirQualityWithCurrentLocation();
                },
                child: Container(
                  height: airQualityHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getGradientColors(_airQuality),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isLoadingAirQuality
                        ? CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _location,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'مؤشر جودة الهواء: $_airQuality',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),
              // الصف الأول من الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر "نصائح للتعامل مع جودة الهواء الحالية"
                  _buildDashboardItem(
                      context,
                      '''نصائح للتعامل 
  مع جودة الهواء الحالية''',
                      Icons.person,
                      AirQualityPage()),
                  // زر " الملوثات وتركيزاتها"
                  _buildDashboardItem(
                      context,
                      'الملوثات وتركيزاتها',
                      Icons.air_outlined,
                      AirPollutantsPage()),
                ],
              ),
              SizedBox(height: 16),

              // الصف الثاني من الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر "الدول الافضل والاسوء"
                  _buildDashboardItem(context, 'الدول الافضل والاسوء',
                      Icons.analytics, HomeScreen()),
                  // زر "خريطة"
                  _buildDashboardItem(
                      context, 'لعبة', Icons.map, ChatScreen22()),
                ],
              ),
              SizedBox(height: 16),

              // الصف الثالث من الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر "حول التطبيق"
                  _buildDashboardItem(
                      context, 'حول التطبيق', Icons.info, AboutPage()),
                  // زر "تعلم المزيد"
                  _buildDashboardItem(
                      context, 'تعلم المزيد', Icons.contact_mail, ChatScreen22()),
                ],
              ),
              SizedBox(height: 30),

              // قسم الإحصائيات الدائرية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircularStat('25%', Colors.blue, 'قليل'),
                  _buildCircularStat('50%', Colors.orange, 'متوسط'),
                  _buildCircularStat('75%', Colors.red, 'عالي'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // تعريف دالة _buildDashboardItem داخل الكلاس فقط
  Widget _buildDashboardItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على الزر، الانتقال إلى الصفحة المحددة
        print('Tapped on $title');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 160, // زيادة العرض لاستيعاب النصوص الطويلة
        height: 120, // زيادة الارتفاع لتحسين التوزيع
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade700
            ],
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40, // تقليل حجم الأيقونة لتوفير مساحة للنص
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14, // تقليل حجم الخط ليتناسب مع النص الطويل
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis, // إذا كان النص كبيرًا جدًا يتم تقليصه
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // بناء الإحصائيات الدائرية
  Widget _buildCircularStat(String percentage, Color color, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 3),
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
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

