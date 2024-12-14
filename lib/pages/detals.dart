import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  DetailsPage({required this.latitude, required this.longitude});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map<String, dynamic> _pollutants = {};
  String _tips = "تحميل البيانات...";

  // استدعاء API للحصول على تفاصيل جودة الهواء
  Future<void> _fetchAirQualityDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.waqi.info/feed/geo:${widget.latitude};${widget.longitude}/?token=YOUR_API_KEY'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _pollutants = data['data']['iaqi']; // تفاصيل الملوثات
        _tips = _getTipsForAirQuality(data['data']['aqi']);
      });
    } else {
      setState(() {
        _tips = "خطأ في الاتصال بالخادم!";
      });
    }
  }

  // تحديد النصائح بناءً على قيمة AQI
  String _getTipsForAirQuality(int aqi) {
    if (aqi <= 50) {
      return "جودة الهواء جيدة، لا داعي للقلق.";
    } else if (aqi <= 100) {
      return "جودة الهواء معتدلة، قد تكون هناك بعض المخاطر للمجموعات الحساسة.";
    } else if (aqi <= 150) {
      return "جودة الهواء غير صحية للمجموعات الحساسة. حاول تجنب الأنشطة الخارجية.";
    } else if (aqi <= 200) {
      return "جودة الهواء غير صحية. تجنب الأنشطة الخارجية قدر الإمكان.";
    } else if (aqi <= 300) {
      return "جودة الهواء خطرة. يجب تجنب الأنشطة الخارجية بشكل كامل.";
    } else {
      return "جودة الهواء خطرة جداً. يُنصح بالبقاء داخل الأماكن المغلقة.";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAirQualityDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل جودة الهواء'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عرض النصائح للمستخدم
              Text(
                'نصائح للتعامل مع جودة الهواء:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _tips,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // عرض الملوثات وتركيزاتها
              Text(
                'مستويات الملوثات:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _pollutants.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                children: _pollutants.entries.map((entry) {
                  return ListTile(
                    title: Text('${entry.key}'),
                    subtitle: Text('تركيز: ${entry.value['v']} µg/m³'),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
