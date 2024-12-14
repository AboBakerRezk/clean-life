import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class WaterQualityHomePage extends StatefulWidget {
  @override
  _WaterQualityHomePageState createState() => _WaterQualityHomePageState();
}

class _WaterQualityHomePageState extends State<WaterQualityHomePage>{
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _waterQualityData = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWaterQualityBasedOnLocation();
  }

  // دالة لجلب جودة المياه بناءً على الموقع الحالي
  Future<void> _fetchWaterQualityBasedOnLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _waterQualityData = [];
    });

    try {
      // التحقق من تفعيل خدمات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'خدمات الموقع غير مفعلة.';
          _isLoading = false;
        });
        return;
      }

      // التحقق من الأذونات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'تم رفض إذن الموقع.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'تم رفض إذن الموقع بشكل دائم. يرجى تفعيل الأذونات من إعدادات الجهاز.';
          _isLoading = false;
        });
        return;
      }

      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final double lat = position.latitude;
      final double lon = position.longitude;

      // جلب اسم الدولة باستخدام الترميز الجغرافي العكسي
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isEmpty) {
        setState(() {
          _errorMessage = 'لم يتم العثور على معلومات الموقع.';
          _isLoading = false;
        });
        return;
      }

      String country = placemarks[0].country ?? '';
      if (country.isEmpty) {
        setState(() {
          _errorMessage = 'لم يتم العثور على اسم الدولة.';
          _isLoading = false;
        });
        return;
      }

      // جلب بيانات جودة المياه بناءً على اسم الدولة
      await fetchWaterQualityData(country);
    } catch (e) {
      setState(() {
        _errorMessage = 'حدث خطأ أثناء جلب الموقع: $e';
        _isLoading = false;
      });
      print("Error fetching location: $e"); // لطباعة الخطأ في الكونسول
    }
  }

  // دالة لجلب بيانات جودة المياه بناءً على الدولة من ملف JSON محلي
  Future<void> fetchWaterQualityData(String country) async {
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
          _errorMessage = 'لم يتم العثور على بيانات لهذه الدولة: $country.';
        });
      } else {
        setState(() {
          _waterQualityData = filteredData;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'حدث خطأ أثناء تحميل البيانات: $e';
      });
      print("Error loading JSON: $e"); // لطباعة الخطأ في الكونسول
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // دالة للبحث اليدوي عند إدخال اسم الدولة
  Future<void> _manualSearch() async {
    final country = _controller.text.trim();
    if (country.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
        _waterQualityData = [];
      });
      await fetchWaterQualityData(country);
    } else {
      setState(() {
        _errorMessage = 'يرجى إدخال اسم دولة للبحث.';
        _waterQualityData = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جودة المياه في الدول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // حقل البحث وزر البحث اليدوي
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'أدخل اسم الدولة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _manualSearch,
                  child: Text('بحث'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // عرض مؤشر التحميل أو رسالة الخطأ أو قائمة البيانات
            Expanded(
              child: _isLoading
                  ? Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              )
                  : _errorMessage.isNotEmpty
                  ? Center(
                child: Text(
                  _errorMessage,
                  style:
                  TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
                  : _waterQualityData.isEmpty
                  ? Center(
                child: Text(
                  'لا توجد بيانات لعرضها.',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: _waterQualityData.length,
                itemBuilder: (context, index) {
                  final data = _waterQualityData[index];
                  return Card(
                    elevation: 2,
                    margin:
                    EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                          data['country'] ?? 'بدون اسم'),
                      subtitle: Text(
                        'درجة جودة المياه: ${data['WaterQuality_EPIDrinkingWaterScore_2024']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WaterQualityHomePage2 extends StatefulWidget {
  @override
  _WaterQualityHomePage2State createState() => _WaterQualityHomePage2State();
}

class _WaterQualityHomePage2State extends State<WaterQualityHomePage2> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _waterQualityData = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // دالة لجلب بيانات جودة المياه بناءً على الدولة من ملف JSON محلي
  Future<void> fetchWaterQualityData(String country) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _waterQualityData = [];
    });

    try {
      // تحميل ملف JSON من الأصول
      String jsonString = await rootBundle.loadString('assets/country.json');
      List<dynamic> jsonResponse = json.decode(jsonString);

      // البحث عن الدولة المطلوبة
      List<dynamic> filteredData = jsonResponse.where((item) {
        return item['country'].toString().toLowerCase().contains(country.toLowerCase());
      }).toList();

      if (filteredData.isEmpty) {
        setState(() {
          _errorMessage = 'لم يتم العثور على بيانات لهذه الدولة.';
        });
      } else {
        setState(() {
          _waterQualityData = filteredData;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'حدث خطأ أثناء تحميل البيانات: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جودة المياه في الدول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // حقل البحث وزر البحث
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'أدخل اسم الدولة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final country = _controller.text.trim();
                    if (country.isNotEmpty) {
                      fetchWaterQualityData(country);
                    } else {
                      setState(() {
                        _errorMessage = 'يرجى إدخال اسم دولة للبحث.';
                        _waterQualityData = [];
                      });
                    }
                  },
                  child: Text('بحث'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // عرض مؤشر التحميل أو رسالة الخطأ أو قائمة البيانات
            Expanded(
              child: _isLoading
                  ? Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              )
                  : _errorMessage.isNotEmpty
                  ? Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
                  : _waterQualityData.isEmpty
                  ? Center(
                child: Text(
                  'لا توجد بيانات لعرضها.',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: _waterQualityData.length,
                itemBuilder: (context, index) {
                  final data = _waterQualityData[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(data['country'] ?? 'بدون اسم'),
                      subtitle: Text(
                        'درجة جودة المياه: ${data['WaterQuality_EPIDrinkingWaterScore_2024']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
