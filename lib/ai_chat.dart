

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:clean_life/pages/language.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'ai_chat_voice.dart';
// Widget build(BuildContext context) {
//   // تعريف قائمة _quickReplies باستخدام الثوابت واستدعاء الترجمات
//   final List<String> _quickReplies = [
//     '${AppLocale.quickReply1.getString(context)}',
//     '${AppLocale.quickReply2.getString(context)}',
//     '${AppLocale.quickReply3.getString(context)}',
//     '${AppLocale.quickReply4.getString(context)}',
//     '${AppLocale.quickReply5.getString(context)}',
//     '${AppLocale.quickReply6.getString(context)}',
//     '${AppLocale.quickReply7.getString(context)}',
//     '${AppLocale.quickReply8.getString(context)}',
//     '${AppLocale.quickReply9.getString(context)}',
//     '${AppLocale.quickReply10.getString(context)}',
//     '${AppLocale.quickReply11.getString(context)}',
//     '${AppLocale.quickReply12.getString(context)}',
//     '${AppLocale.quickReply13.getString(context)}',
//     '${AppLocale.quickReply14.getString(context)}',
//     '${AppLocale.quickReply15.getString(context)}',
//     '${AppLocale.quickReply16.getString(context)}',
//     '${AppLocale.quickReply17.getString(context)}',
//     '${AppLocale.quickReply18.getString(context)}',
//     '${AppLocale.quickReply19.getString(context)}',
//     '${AppLocale.quickReply20.getString(context)}',
//     '${AppLocale.quickReply21.getString(context)}',
//     '${AppLocale.quickReply22.getString(context)}',
//     '${AppLocale.quickReply23.getString(context)}',
//     '${AppLocale.quickReply24.getString(context)}',
//     '${AppLocale.quickReply25.getString(context)}',
//     '${AppLocale.quickReply26.getString(context)}',
//     '${AppLocale.quickReply27.getString(context)}',
//     '${AppLocale.quickReply28.getString(context)}',
//     '${AppLocale.quickReply29.getString(context)}',
//     '${AppLocale.quickReply30.getString(context)}',
//     '${AppLocale.quickReply31.getString(context)}',
//     '${AppLocale.quickReply32.getString(context)}',
//     '${AppLocale.quickReply33.getString(context)}',
//     '${AppLocale.quickReply34.getString(context)}',
//     '${AppLocale.quickReply35.getString(context)}',
//     '${AppLocale.quickReply36.getString(context)}',
//     '${AppLocale.quickReply37.getString(context)}',
//     '${AppLocale.quickReply38.getString(context)}',
//     '${AppLocale.quickReply39.getString(context)}',
//     '${AppLocale.quickReply40.getString(context)}',
//     '${AppLocale.quickReply41.getString(context)}',
//     '${AppLocale.quickReply42.getString(context)}',
//     '${AppLocale.quickReply43.getString(context)}',
//     '${AppLocale.quickReply44.getString(context)}',
//     '${AppLocale.quickReply45.getString(context)}',
//     '${AppLocale.quickReply46.getString(context)}',
//     '${AppLocale.quickReply47.getString(context)}',
//     '${AppLocale.quickReply48.getString(context)}',
//     '${AppLocale.quickReply49.getString(context)}',
//   ];
//
// }

final List<String> _quickReplies = [
  AppLocale.quickReply1,
  AppLocale.quickReply2,
  AppLocale.quickReply3,
  AppLocale.quickReply4,
  AppLocale.quickReply5,
  AppLocale.quickReply6,
  AppLocale.quickReply7,
  AppLocale.quickReply8,
  AppLocale.quickReply9,
  AppLocale.quickReply10,
  AppLocale.quickReply11,
  AppLocale.quickReply12,
  AppLocale.quickReply13,
  AppLocale.quickReply14,
  AppLocale.quickReply15,
  AppLocale.quickReply16,
  AppLocale.quickReply17,
  AppLocale.quickReply18,
  AppLocale.quickReply19,
  AppLocale.quickReply20,
  AppLocale.quickReply21,
  AppLocale.quickReply22,
  AppLocale.quickReply23,
  AppLocale.quickReply24,
  AppLocale.quickReply25,
  AppLocale.quickReply26,
  AppLocale.quickReply27,
  AppLocale.quickReply28,
  AppLocale.quickReply29,
  AppLocale.quickReply30,
  AppLocale.quickReply31,
  AppLocale.quickReply32,
  AppLocale.quickReply33,
  AppLocale.quickReply34,
  AppLocale.quickReply35,
  AppLocale.quickReply36,
  AppLocale.quickReply37,
  AppLocale.quickReply38,
  AppLocale.quickReply39,
  AppLocale.quickReply40,
  AppLocale.quickReply41,
  AppLocale.quickReply42,
  AppLocale.quickReply43,
  AppLocale.quickReply44,
  AppLocale.quickReply45,
  AppLocale.quickReply46,
  AppLocale.quickReply47,
  AppLocale.quickReply48,
  AppLocale.quickReply49,
];class Message {
  final String text;
  final DateTime timestamp;
  final bool isUser;

  Message(this.text, this.timestamp, {this.isUser = false});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map['text'],
      DateTime.parse(map['timestamp']),
      isUser: map['isUser'],
    );
  }
}

class ChatPage {
  String name;
  List<Message> messages;

  ChatPage({required this.name, required this.messages});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'messages': messages.map((msg) => msg.toMap()).toList(),
    };
  }

  factory ChatPage.fromMap(Map<String, dynamic> map) {
    return ChatPage(
      name: map['name'],
      messages: List<Message>.from(
          map['messages']?.map((msg) => Message.fromMap(msg)) ?? []),
    );
  }
}

class ChatScreen22 extends StatefulWidget {
  @override
  _ChatScreen22State createState() => _ChatScreen22State();
}

class _ChatScreen22State extends State<ChatScreen22>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatPage> _chatPages = [];
  ChatPage? _currentChatPage;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  final ApiService apiService = ApiService();
  final Random _random = Random();
  List<Message> _favorites = [];

  int recyclingProgressLevel = 0;
  int energySavingProgressLevel = 0;
  int wasteReductionProgressLevel = 0;
  int waterConservationProgressLevel = 0;
  int transportationProgressLevel = 0;

  late AnimationController _sendButtonController;
  final ApiService _apiService = ApiService();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  String _userVoice = '';
  List<Message> _messages = [];
  String _selectedLanguage = 'Arabic';
  final List<String> _languageOptions = ['العربية', 'English'];

  String userRank = "junior";

  bool showInitialOptions = true;

  // إضافة مؤشر الكتابة
  bool _isTyping = false;

  // قائمة الرسائل المجدولة
  List<ScheduledMessage> _scheduledMessages = [];

  @override
  void initState() {
    super.initState();
    _loadChatPages();
    _sendButtonController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _shuffleQuickReplies();

    _shuffleQuickReplies();
    _loadFavorites();
    loadSavedProgressData();
    langdetect.initLangDetect(); // Initialize the language detector once
  }

  Future<void> _listen2() async {
    String localeId = _selectedLanguage == 'Arabic' ? 'ar-SA' : 'en-US';
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (val) {
        setState(() {
          _isListening = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while listening.')),
        );
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        localeId: localeId,
        onResult: (val) {
          setState(() {
            _userVoice = val.recognizedWords;
          });
        },
      );
    } else {
      setState(() => _isListening = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Voice recognition is not available.')),
      );
    }
  }

  Future<void> _stopListening2() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
    _detectLanguageAndSendMessage2(_userVoice); // Detect language before sending message
  }

  Future<void> _detectLanguageAndSendMessage2(String text) async {
    if (text.trim().isEmpty) {
      print('An empty message cannot be sent.');
      return;
    }

    String detectedLang;
    try {
      // كشف اللغة باستخدام مكتبة langdetect
      detectedLang = await langdetect.detect(text);
      print('Language revealed: $detectedLang');
    } catch (e) {
      print('An error occurred while detecting the language.: $e');
      detectedLang = 'unknown';
    }

    // تعيين اللغة المختارة إذا كانت عربية أو إنجليزية فقط
    setState(() {
      if (detectedLang == 'ar') {
        _selectedLanguage = 'Arabic';
      } else if (detectedLang == 'en') {
        _selectedLanguage = 'English';
      } else {
        _selectedLanguage = 'English'; // افتراضيًا للغة غير مدعومة
      }
    });

    // تحسين النص وتحليله
    String optimizedText = _optimizeText2(text);
    String sentiment = await _analyzeSentiment2(text);
    bool containsInappropriateContent = _checkForInappropriateContent2(text);

    // إرسال الرسالة إذا كانت المحتوى مناسب
    if (containsInappropriateContent) {
      return;
    }

    // تسجيل البيانات
    _logMessageData2(text, detectedLang, sentiment);

    // إرسال الرسالة بعد التحليل
    await _sendMessage(optimizedText, sentiment: sentiment);
  }

// دالة لتحسين النص
  String _optimizeText2(String text) {
    List<String> words = text.split(' ');
    Set<String> uniqueWords = Set.from(words);
    return uniqueWords.join(' ');
  }

// دالة لتحليل المشاعر
  Future<String> _analyzeSentiment2(String text) async {
    if (text.contains(RegExp(r'\b(جميل|رائع|ممتاز|مميز|happy|excellent|great)\b'))) {
      return 'إيجابي';
    } else if (text.contains(RegExp(r'\b(سيء|رديء|حزين|مزعج|sad|bad|annoying)\b'))) {
      return 'سلبي';
    }
    return 'محايد';
  }

// دالة للتحقق من الكلمات المسيئة
  bool _checkForInappropriateContent2(String text) {
    List<String> inappropriateWords = ['كلمة1', 'كلمة2', 'badword1', 'badword2'];
    return inappropriateWords.any((word) => text.contains(word));
  }

// دالة لتسجيل بيانات الرسالة
  void _logMessageData2(String text, String detectedLang, String sentiment) {
    // print('تسجيل الرسالة:');
    // print('النص: $text');
    // print('اللغة: $detectedLang');
    // print('المشاعر: $sentiment');
  }

  // دالة لتحميل بيانات مستويات التقدم من SharedPreferences
  Future<void> loadSavedProgressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recyclingProgressLevel = prefs.getInt('progressRecycling') ?? 0;
      energySavingProgressLevel = prefs.getInt('progressEnergySaving') ?? 0;
      wasteReductionProgressLevel = prefs.getInt('progressWasteReduction') ?? 0;
      waterConservationProgressLevel =
          prefs.getInt('progressWaterConservation') ?? 0;
      transportationProgressLevel =
          prefs.getInt('progressTransportation') ?? 0;
      // أضف مستويات التقدم الأخرى إذا لزم الأمر
    });
  }
  void _shuffleQuickReplies() {
    _quickReplies.shuffle(_random);
  }
  @override
  void dispose() {
    _controller.dispose();
    _sendButtonController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    // يمكن حذف هذه الدالة إذا لم تعد مستخدمة
  }

  Future<void> _saveUserData() async {
    // يمكن حذف هذه الدالة إذا لم تعد مستخدمة
  }

  void _updateUserRank() {
    // يمكن تعديل هذه الدالة إذا كانت لازمة أو حذفها
    if (userRank == "مبتدئ") {
      userRank = "مستدام";
    } else if (userRank == "مستدام") {
      userRank = "محترف";
    } else if (userRank == "محترف") {
      userRank = "خبير بيئي";
    } else {
      userRank = "سيد البيئة";
    }
  }

  Future<void> _checkProgress() async {
    String? message;
    final Random random = Random();

    // توسيع قوائم الرسائل لكل حالة
    List<String> messages5000 = [
      "🎉 مبروك! لقد وصلت إلى مستوى بيئي ممتاز!",
      "👏 رائع! أنت في تقدم كبير في دعم البيئة.",
      "✨ إنجاز رائع! استمر في جهودك للحفاظ على البيئة.",
      "🥳 خطتك البيئية تزدهر! استمر بنفس الحماس.",
      "🚀 تقدم مذهل! استمر في دعم كوكبنا.",
      "🌟 تقدمك في دعم البيئة ملهم!",
    ];

    List<String> messages10000 = [
      "🏆 تهانينا! لقد حققت هدفك البيئي.",
      "🎯 هدفك البيئي تحقق بنجاح.",
      "🔥 ممتاز! أنت في القمة في دعم البيئة.",
      "🎖️ نجاح كبير! إنجاز بيئي لا يصدق!",
      "👏 أنت في أعلى المستويات الآن في دعم البيئة.",
      "🌈 حلمك البيئي تحقق!",
    ];

    List<String> messagesBetterThanYesterday = [
      "📈 لقد جمعت اليوم نقاطًا أكثر من أمس في دعم البيئة. **أداء رائع!**",
      "👍 تحسن ملحوظ! نقاطك اليوم تفوق أمس في الجهود البيئية.",
      "💪 عمل ممتاز! تجاوزت نقاط أمس اليوم في الحفاظ على البيئة.",
      "🎉 أداء مدهش! نقاطك لهذا اليوم أفضل من اليوم السابق في دعم البيئة.",
      "🔝 تقدمك اليوم يتفوق على الأمس في حماية البيئة، استمر على هذا المنوال!",
      "🚀 أداء مبهر اليوم في دعم البيئة، واصل التفوق على نفسك!",
    ];

    List<String> messagesWorseThanYesterday = [
      "😟 حاول جمع نقاط أكثر غدًا لدعم البيئة بشكل أفضل!",
      "⚠️ يبدو أنك بحاجة لبذل جهد أكبر غدًا لجمع المزيد من النقاط البيئية.",
      "📉 لم تحقق النقاط البيئية المطلوبة اليوم. لا تيأس وحاول غدًا!",
      "😔 يمكنك تحسين أدائك البيئي غدًا، حافظ على حماسك.",
      "🔄 غدًا فرصة جديدة لجمع نقاط بيئية أكثر والوصول لهدفك.",
      "📊 أداءك البيئي اليوم أقل من الأمس، جرب استراتيجيات جديدة غدًا.",
    ];

    List<String> messagesPointsRemaining = [
      "🔔 تبقى لك خطوات قليلة لتحقيق هدفك البيئي. استمر في الجهد! 💪",
      "🚀 قريب من الهدف البيئي! استمر في دعم البيئة.",
      "🎯 نقطة واحدة تلو الأخرى! استمر في جهودك البيئية.",
      "🌟 فقط بعض الخطوات لتصل إلى هدفك البيئي. واصل التقدم!",
      "🛤️ طريقك نحو الهدف البيئي قريب. استمر في الدعم!",
      "🔜 قريبًا تصل للنهاية البيئية! فقط بعض الخطوات تفصلك عن النجاح.",
      "🏅 تبقى خطوة صغيرة! للوصول إلى هدفك البيئي.",
      "📈 أنت في الطريق الصحيح نحو إكمال هدفك البيئي.",
      "🔥 استمر في دعم البيئة! تبقى خطوات قليلة فقط.",
      "💡 أنت قريب جدًا من الهدف البيئي! استمر في العمل.",
    ];

    // اختيار الرسالة بناءً على التقدم
    if (/* شرط يعتمد على التقدم */ false) { // يجب تعديل الشرط بناءً على التطبيق الجديد
      message = messages5000[random.nextInt(messages5000.length)];
    } else if (/* شرط آخر */ false) { // يجب تعديل الشرط بناءً على التطبيق الجديد
      message = messages10000[random.nextInt(messages10000.length)];
    }

    final prefs = await SharedPreferences.getInstance();
    DateTime lastUpdateDate =
        DateTime.tryParse(prefs.getString('lastUpdateDate') ?? '') ??
            DateTime.now();

    if (DateTime.now().day != lastUpdateDate.day) {
      // يمكن تعديل الشروط بناءً على التطبيق الجديد
      message = messagesBetterThanYesterday[random.nextInt(messagesBetterThanYesterday.length)];

      prefs.setString('lastUpdateDate', DateTime.now().toIso8601String());
      await _saveUserData();
    }

    double pointsRemaining = 0; // يمكن تعديلها بناءً على التطبيق الجديد
    if (pointsRemaining > 0 && message == null) {
      // اختيار رسالة عشوائية من قائمة النقاط المتبقية
      message = messagesPointsRemaining[random.nextInt(messagesPointsRemaining.length)];
    }

    if (message != null) {
      _sendMessageToUser(message); // تأكد من تنسيق الرسائل بشكل جذاب
    }
  }

  void _sendMessageToUser(String message) {
    _saveChatPages();
    _scrollToBottom();
  }

  List<String> progressTemplates = [
    // يمكن إزالة هذا القسم إذا لم يعد مستخدمًا
  ];

  List<String> learningPlanTemplates = [
    // يمكن تعديل أو إزالة القوالب حسب الحاجة
    """
✨ مرحبًا بك في خطتك البيئية، يا \$name! 🎉

1. ♻️ **إعادة التدوير**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **30 دقيقة يوميًا** لتحسين مهارات إعادة التدوير.
2. 💡 **توفير الطاقة**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **20 دقيقة يوميًا** لتوفير الطاقة.
3. 🗑️ **تقليل النفايات**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام لمدة **15 دقيقة يوميًا**.
4. 💧 **حفظ المياه**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام لمدة **10 دقائق يوميًا**.
5. 🚴 **النقل المستدام**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي لمدة **20 دقيقة يوميًا** لتقليل انبعاثات الكربون.
6. 🌿 **العيش المستدام**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك لمدة **15 دقيقة يوميًا**.

🚀 استمر في هذا البرنامج لدعم البيئة وتحقيق تقدم بيئي مستدام! 🌟
    """,
    // يمكن إضافة المزيد من القوالب البيئية حسب الحاجة
  ];

  // دالة لاختيار قالب عشوائي لخطة التعلم البيئية
  String getRandomLearningPlan() {
    final random = Random();
    int index = random.nextInt(learningPlanTemplates.length);
    return learningPlanTemplates[index];
  }



  Future<void> _sendMessage(String text, {required String sentiment}) async {
    if (text.trim().isEmpty) return;

    final userMessage = Message(text, DateTime.now(), isUser: true);
    setState(() {
      _messages.add(userMessage);
    });

    final processingMessage = Message('Processing...', DateTime.now(), isUser: false);
    setState(() {
      _messages.add(processingMessage);
    });

    try {
      final botResponse = await _apiService.getTextResponse(text);
      setState(() {
        _messages.remove(processingMessage);
      });

      final botMessage = Message(botResponse, DateTime.now(), isUser: false);
      setState(() {
        _messages.add(botMessage);
      });
    } catch (e) {
      setState(() {
        _messages.remove(processingMessage);
      });

      final errorMessage = Message('There was an error getting the response. Try again.', DateTime.now(), isUser: false);
      setState(() {
        _messages.add(errorMessage);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('API connection failed')),
      );
    }
    if (text.isEmpty) return;

    _sendButtonController
        .forward()
        .then((_) => _sendButtonController.reverse());

    final message = Message("${AppLocale.air171.getString(context)}: $text", DateTime.now(), isUser: true);
    setState(() {
      _currentChatPage?.messages.add(message);
      _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
      showInitialOptions = false;
    });
    _saveChatPages();
    _scrollToBottom();

    setState(() {
      _isTyping = true;
    });

    try {
      String response;
      final Random random = Random();

      if (text.toLowerCase().contains("التقدم")) {
        List<String> progressResponses = [
          "📊 إجمالي جهودك البيئية رائعة! استمر في دعم البيئة بحماس! 🌿",
          "🚀 أنت في طريقك لتحقيق أهدافك البيئية. استمر في العمل الجيد!",
          // يمكن إضافة المزيد من الردود البيئية هنا
        ];
        response = progressResponses[random.nextInt(progressResponses.length)];
      } else if (text.toLowerCase().contains("نصيحة")) {
        List<String> adviceResponses = [
          "🌍 حافظ على الاستمرارية في دعم البيئة واحرص على اتخاذ خطوات صغيرة يوميًا. **التغيير يبدأ منك!** ♻️",
          "💡 اجعل الحفاظ على البيئة عادة يومية، وحدد أهدافًا بيئية صغيرة ومتواصلة.",
          "✨ ركز على تحسين عاداتك البيئية يوميًا بخطوات بسيطة لتحقيق نتائج كبيرة.",
          "📖 لا تتوقف عند أي صعوبة؛ كل خطوة تقربك من الهدف البيئي!",
          "🌟 نظم وقتك بفعالية وخصص فترات محددة للأنشطة البيئية والاستراحة.",
          "🔍 ركز على فهم أهمية الحفاظ على البيئة بدلاً من الحفظ فقط لتحقيق استفادة أفضل.",
          "🧘‍♂️ احرص على أخذ فترات راحة منتظمة للحفاظ على تركيزك ونشاطك البيئي.",
          "🚀 استخدم تقنيات الحفاظ على البيئة مثل إعادة التدوير والممارسات المستدامة لتعزيز مهاراتك البيئية.",
          "📅 خطط لنشاطاتك البيئية مسبقًا وحدد مواعيد محددة لكل نشاط.",
          "🌱 تعلم شيئًا جديدًا كل يوم حول البيئة ولا تخف من مواجهة التحديات البيئية.",
        ];
        response = adviceResponses[random.nextInt(adviceResponses.length)];
      } else if (text.toLowerCase().contains("الخطة البيئية")) {
        List<String> learningPlans = [
          """
✨ إليك خطتك البيئية في EcoAI:
        
1. ♻️ **إعادة التدوير**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **30 دقيقة يوميًا**.
2. 💡 **توفير الطاقة**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **20 دقيقة يوميًا**.
3. 🗑️ **تقليل النفايات**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام لمدة **15 دقيقة يوميًا**.
4. 💧 **حفظ المياه**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام لمدة **10 دقائق يوميًا**.
5. 🚴 **النقل المستدام**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي لمدة **20 دقيقة يوميًا**.
6. 🌿 **العيش المستدام**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك لمدة **15 دقيقة يوميًا**.
        
💪 استمر في هذه الخطة البيئية يوميًا لتحقيق تقدم ملحوظ في دعم البيئة! 🚀
    """,
          """
🚀 خطة بيئية جديدة لك في EcoAI:
        
1. 👂 **إعادة التدوير**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **40 دقيقة**.
2. 💡 **توفير الطاقة**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **25 دقيقة**.
3. 🗑️ **تقليل النفايات**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام أو القابلة للتحلل لمدة **15 دقيقة**.
4. 💧 **حفظ المياه**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام لمدة **20 دقيقة**.
5. 🚴 **النقل المستدام**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي أو النقل العام لمدة **20 دقيقة**.
6. 🌿 **العيش المستدام**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك لمدة **15 دقيقة**.
        
🌱 استمر والتزم لتحقق تقدم بيئي كبير!
    """,
          """
📅 خطة بيئية مخصصة:
        
1. ♻️ **إعادة التدوير النشط**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **25 دقيقة** يوميًا.
2. 💡 **توفير الطاقة المستمر**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **30 دقيقة** يوميًا.
3. 🗑️ **تقليل النفايات المتقدم**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام أو القابلة للتحلل لمدة **20 دقيقة** يوميًا.
4. 💧 **حفظ المياه الفعّال**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام واتباع تقنيات الحفاظ على المياه لمدة **15 دقيقة** يوميًا.
5. 🚴 **النقل المستدام المتقدم**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي أو النقل العام لمدة **25 دقيقة** يوميًا.
6. 🌿 **العيش المستدام الإبداعي**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك وزراعة النباتات لمدة **15 دقيقة** يوميًا.
        
✨ التزامك بهذه الخطة البيئية سيساعدك على تحقيق تقدم مستدام وفعّال في دعم البيئة! 🌟
    """,
        ];
        response = learningPlans[random.nextInt(learningPlans.length)];
      } else if (text.toLowerCase().contains("كم المتبقي")) {
        List<String> pointsRemainingResponses = [
          "🔔 تبقى لك خطوات قليلة لتحقيق هدفك البيئي. استمر في الجهد! 💪",
          "🚀 قريب من الهدف البيئي! استمر في دعم البيئة.",
          "🎯 نقطة واحدة تلو الأخرى! استمر في جهودك البيئية.",
          "🌟 فقط بعض الخطوات لتصل إلى هدفك البيئي. واصل التقدم!",
          "🛤️ طريقك نحو الهدف البيئي قريب. استمر في الدعم!",
          "🔜 قريبًا تصل للنهاية البيئية! فقط بعض الخطوات تفصلك عن النجاح.",
          "🏅 تبقى خطوة صغيرة! للوصول إلى هدفك البيئي.",
          "📈 أنت في الطريق الصحيح نحو إكمال هدفك البيئي.",
          "🔥 استمر في دعم البيئة! تبقى خطوات قليلة فقط.",
          "💡 أنت قريب جدًا من الهدف البيئي! استمر في العمل.",
        ];
        response = pointsRemainingResponses[random.nextInt(pointsRemainingResponses.length)];
      } else {
        // يمكن إضافة المزيد من الشروط البيئية هنا إذا لزم الأمر
        response = await apiService.getTextResponse(text);
      }

      await Future.delayed(Duration(seconds: 1));

      final botMessage = Message("${AppLocale.air170.getString(context)}: $response", DateTime.now(), isUser: false);
      setState(() {
        _currentChatPage?.messages.add(botMessage);
        _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
        _isTyping = false;
      });
      _saveChatPages();
      _scrollToBottom();

    } catch (e) {
      final errorMessage = Message(
          "${AppLocale.air170.getString(context)}: An error occurred while processing the message.", DateTime.now(),
          isUser: false);
      setState(() {
        _currentChatPage?.messages.add(errorMessage);
        _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
        _isTyping = false;
      });
      _saveChatPages();
      _scrollToBottom();
    }
  }

  String _generateLearningPlan() {
    List<String> learningPlans = [
      """
✨ إليك خطتك البيئية المقترحة:
        
1. ♻️ **إعادة التدوير**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **30 دقيقة يوميًا**.
2. 💡 **توفير الطاقة**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **20 دقيقة يوميًا**.
3. 🗑️ **تقليل النفايات**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام أو القابلة للتحلل لمدة **15 دقيقة يوميًا**.
4. 💧 **حفظ المياه**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام لمدة **10 دقائق يوميًا**.
5. 🚴 **النقل المستدام**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي لمدة **20 دقيقة يوميًا**.
6. 🌿 **العيش المستدام**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك لمدة **15 دقيقة يوميًا**.
        
💪 استمر على هذه الخطة يوميًا لتحقيق تقدم ملحوظ في دعم البيئة! 🚀
    """,
      """
🚀 خطة بيئية جديدة لك:
        
1. 👂 **إعادة التدوير**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **40 دقيقة**.
2. 💡 **توفير الطاقة**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **25 دقيقة**.
3. 🗑️ **تقليل النفايات**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام أو القابلة للتحلل لمدة **15 دقيقة**.
4. 💧 **حفظ المياه**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام لمدة **20 دقيقة**.
5. 🚴 **النقل المستدام**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي أو النقل العام لمدة **20 دقيقة**.
6. 🌿 **العيش المستدام**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك لمدة **15 دقيقة**.
        
🌱 استمر والتزم لتحقق تقدم بيئي كبير!
    """,
      """
📅 خطة بيئية مخصصة:
        
1. ♻️ **إعادة التدوير النشط**: قم بإعادة تدوير النفايات القابلة لإعادة الاستخدام مثل البلاستيك والزجاج لمدة **25 دقيقة** يوميًا.
2. 💡 **توفير الطاقة المستمر**: استخدم الأجهزة الكهربائية بكفاءة واغلقها عند عدم الاستخدام لمدة **30 دقيقة** يوميًا.
3. 🗑️ **تقليل النفايات المتقدم**: حاول تقليل إنتاج النفايات من خلال استخدام المنتجات القابلة لإعادة الاستخدام أو القابلة للتحلل لمدة **20 دقيقة** يوميًا.
4. 💧 **حفظ المياه الفعّال**: استخدم المياه بشكل فعال من خلال إطفاء الصنابير عند عدم الاستخدام واتباع تقنيات الحفاظ على المياه لمدة **15 دقيقة** يوميًا.
5. 🚴 **النقل المستدام المتقدم**: استخدم وسائل النقل الصديقة للبيئة مثل الدراجة أو المشي أو النقل العام لمدة **25 دقيقة** يوميًا.
6. 🌿 **العيش المستدام الإبداعي**: اعتمد عادات حياتية مستدامة مثل استخدام منتجات طبيعية وتقليل استهلاك البلاستيك وزراعة النباتات لمدة **15 دقيقة** يوميًا.
        
✨ التزامك بهذه الخطة البيئية سيساعدك على تحقيق تقدم مستدام وفعّال في دعم البيئة! 🌟
    """,
    ];

    final Random random = Random();
    return learningPlans[random.nextInt(learningPlans.length)];
  }

  Future<void> _loadChatPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedChatPages = prefs.getStringList('chat_pages');
    if (savedChatPages != null) {
      setState(() {
        _chatPages.addAll(savedChatPages
            .map((pageJson) => ChatPage.fromMap(json.decode(pageJson)))
            .toList());
        if (_chatPages.isNotEmpty) {
          _currentChatPage = _chatPages.first;
        }
      });
    } else {
      // Initialize with a default chat page
      ChatPage defaultPage = ChatPage(name: "EcoAI", messages: []);
      _chatPages.add(defaultPage);
      _currentChatPage = defaultPage;
      _saveChatPages();
    }
  }

  Future<void> _saveChatPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> chatPagesJson =
    _chatPages.map((page) => json.encode(page.toMap())).toList();
    await prefs.setStringList('chat_pages', chatPagesJson);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 60,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _toggleFavorite(Message message) {
    setState(() {
      if (_favorites.contains(message)) {
        _favorites.remove(message);
      } else {
        _favorites.add(message);
      }
    });
    _saveFavorites();
  }
  Future<void> _saveFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteJsonList =
      _favorites.map((favorite) => json.encode(favorite.toMap())).toList();
      await prefs.setStringList('favorite_messages', favoriteJsonList);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  Future<void> _loadFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? favoriteJsonList = prefs.getStringList('favorite_messages');
      if (favoriteJsonList != null) {
        setState(() {
          _favorites = favoriteJsonList
              .map((jsonStr) => Message.fromMap(json.decode(jsonStr)))
              .toList();
        });
      }
    } catch (e) {
      //  print('Error loading favorites: $e');
    }
  }

  void _copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    void showTopSnackBar(BuildContext context, String message) {
      final overlay = Overlay.of(context);
      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 50.0,
          left: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );

      overlay?.insert(overlayEntry);
      Future.delayed(Duration(seconds: 3), () {
        overlayEntry.remove();
      });
    }
    showTopSnackBar(context, 'Text copied to clipboard');
  }

  bool _isFavorite(Message message) {
    return _favorites.contains(message);
  }
  Future<void> _downloadTextAsFile(String text) async {
    try {
      String fileName =
          "chat_${_currentChatPage?.name ?? 'default'}_${DateTime.now().millisecondsSinceEpoch}.txt";
      final bytes = utf8.encode(text);

      // يمكنك استخدام حزمة مثل file_picker أو path_provider لحفظ الملف على الجهاز

      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'The file has been downloaded successfully.');

    } catch (e) {
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'File download error: $e');

    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }

  Future<void> _showNotification(String message) async {
    // يمكنك تفعيل الإشعارات باستخدام حزمة مثل flutter_local_notifications هنا
  }

  void increasePointsByCategory(String category, double amount) async {
    // هذه الدالة لم تعد ضرورية بعد إزالة نظام النقاط
  }
  void increaseRecyclingProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recyclingProgressLevel += 1;
      prefs.setInt('progressRecycling', recyclingProgressLevel);
      if (recyclingProgressLevel % 5 == 0) { // مثال: كل 5 مستويات
        _showNotification('Congratulations! You ve reached the level. $recyclingProgressLevel In recycling.');
      }
    });
  }
  // يمكنك إزالة أو تعديل دوال زيادة مستويات التقدم الأخرى بنفس الطريقة





  // دالة جديدة لجدولة الرسائل
  void scheduleBotMessage(String text, DateTime scheduledTime) {
    Duration delay = scheduledTime.difference(DateTime.now());
    if (delay.isNegative) {
      // print("الوقت المحدد في الماضي");
      return;
    }

    Timer(delay, () {
      _showNotification(text);

      final botMessage = Message("${AppLocale.air170.getString(context)}: $text", DateTime.now(), isUser: false);
      setState(() {
        _currentChatPage?.messages.add(botMessage);
        _listKey.currentState?.insertItem(_currentChatPage!.messages.length - 1);
      });
      _saveChatPages();
      _scrollToBottom();
    });
  }


  Widget _buildInitialOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Choose a topic to start chatting about:",
            style: TextStyle(fontSize: 18)),
        SizedBox(height: 20),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: [


            ElevatedButton(
              onPressed: () => _sendMessage("How can water be conserved?", sentiment: ''),
              child: Text("Water conservation"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("What are the solutions to reduce carbon emissions?", sentiment: ''),
              child: Text("reduce carbon emissions"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("How do we improve air quality in cities?", sentiment: ''),
              child: Text("improve air quality"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("What is the impact of public transport on the environment?", sentiment: ''),
              child: Text("Impact of public transport"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("How do we protect marine organisms from pollution?", sentiment: ''),
              child: Text("Marine life protection"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("What are the benefits of urban afforestation?", sentiment: ''),
              child: Text("Benefits of afforestation"),
            ),
          ],
        ),
      ],
    );
  }

  // إضافة مؤشر الكتابة
  Widget _buildTypingIndicator() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text("He writes..."),
        ],
      ),
    );
  }

  // إضافة إمكانية إرسال الصور
  Future<void> _pickImage() async {
    // هنا يمكنك استخدام حزمة مثل image_picker لاختيار الصور
    // بعد اختيار الصورة، يمكنك إضافتها كرسالة جديدة
  }

  Future<void> _createNewChatPage() async {
    if (_chatPages.length >= 20) {
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'You have reached the maximum number of chat pages.');

      return;
    }

    String? pageName = await _showInputDialog("Environmental chat page naming");
    if (pageName != null && pageName.trim().isNotEmpty) {
      setState(() {
        ChatPage newPage = ChatPage(name: pageName.trim(), messages: []);
        _chatPages.add(newPage);
        _currentChatPage = newPage;
      });
      _saveChatPages();
    }
  }

  Future<void> _renameChatPage(ChatPage page) async {
    String? newName = await _showInputDialog("Rename the environmental chat page", initialValue: page.name);
    if (newName != null && newName.trim().isNotEmpty) {
      setState(() {
        page.name = newName.trim();
      });
      _saveChatPages();
    }
  }

  Future<void> _deleteChatPage(ChatPage page) async {
    bool? confirm = await _showConfirmationDialog("Delete environmental chat page",
        "Are you sure you want to delete the environment chat page? '${page.name}'؟");
    if (confirm == true) {
      setState(() {
        _chatPages.remove(page);
        if (_currentChatPage == page) {
          _currentChatPage = _chatPages.isNotEmpty ? _chatPages.first : null;
        }
      });
      _saveChatPages();
    }
  }

  Future<String?> _showInputDialog(String title, {String initialValue = ''}) async {
    TextEditingController dialogController =
    TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: dialogController,
            decoration: InputDecoration(hintText: "Enter name here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancellation'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('save'),
              onPressed: () {
                Navigator.of(context).pop(dialogController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog(String title, String content) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('no'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void _selectChatPage(ChatPage page) {
    setState(() {
      _currentChatPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocale.air170.getString(context)}"),
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard_voice_outlined,color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VoiceChatPage()),
              );

            },
          ),

          IconButton(
            icon: Icon(Icons.bookmark,color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favorites: _favorites,
                    toggleFavorite: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              if (_currentChatPage != null) {
                setState(() {
                  _currentChatPage!.messages.clear();
                  _listKey.currentState?.setState(() {});
                });
                _saveChatPages();
                void showTopSnackBar(BuildContext context, String message) {
                  final overlay = Overlay.of(context);
                  final overlayEntry = OverlayEntry(
                    builder: (context) => Positioned(
                      top: 50.0,
                      left: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  message,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                  overlay?.insert(overlayEntry);
                  Future.delayed(Duration(seconds: 3), () {
                    overlayEntry.remove();
                  });
                }
                showTopSnackBar(context, "The environment chat history has been cleared.");

              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'create':
                  _createNewChatPage();
                  break;
                case 'rename':
                  if (_currentChatPage != null) {
                    _renameChatPage(_currentChatPage!);
                  }
                  break;
                case 'delete':
                  if (_currentChatPage != null) {
                    _deleteChatPage(_currentChatPage!);
                  }
                  break;
                case 'download':
                  if (_currentChatPage != null) {
                    String allMessages = _currentChatPage!.messages
                        .map((msg) =>
                    "${msg.isUser ? 'You' : 'EcoAI'} (${_formatTimestamp(msg.timestamp)}): ${msg.text}")
                        .join("\n");
                    _downloadTextAsFile(allMessages);
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'create',
                  child: Text('Create a new environmental chat page'),
                ),
                PopupMenuItem(
                  value: 'rename',
                  child: Text('Rename the environmental chat page'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete environmental chat page'),
                ),
                PopupMenuItem(
                  value: 'download',
                  child: Text('Download the environmental chat page'),
                ),
              ];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: _buildChatPagesSelector(),

        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentChatPage == null
                ? Center(child: Text("There are no environmental chat pages."))
                : _currentChatPage!.messages.isEmpty && showInitialOptions
                ? Center(child: _buildInitialOptions())
                : AnimatedList(
              key: _listKey,
              controller: _scrollController,
              initialItemCount: _currentChatPage!.messages.length,
              itemBuilder: (context, index, animation) {
                if (index >= _currentChatPage!.messages.length) {
                  return SizedBox.shrink();
                }
                final message = _currentChatPage!.messages[index];
                return _buildMessageItem(message, animation);
              },
            ),
          ),
          if (_isTyping) _buildTypingIndicator(),
          if (_currentChatPage != null &&
              _currentChatPage!.messages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _quickReplies.map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _sendMessage(text, sentiment: '');
                        },
                        child: Text(text),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          if (_isListening) {
                            _stopListening2();
                          } else {
                            _listen2();
                          }
                        },
                        child: Icon(_isListening ? Icons.stop : Icons.mic),
                      ),
                    ],
                  ),
                ),

                // زر لاختيار الصور
                // IconButton(
                //   icon: Icon(Icons.image),
                //   onPressed: _pickImage,
                // ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Write an environmental letter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onSubmitted: (text) {
                      _sendMessage(text, sentiment: '');
                      _controller.clear();
                    },
                  ),
                ),
                SizedBox(width: 8),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                    CurvedAnimation(
                        parent: _sendButtonController,
                        curve: Curves.easeInOut),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.green),
                    onPressed: () {
                      _sendMessage(_controller.text, sentiment: '');
                      _controller.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatPagesSelector() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _chatPages.length,
        itemBuilder: (context, index) {
          final page = _chatPages[index];
          return GestureDetector(
            onTap: () {
              _selectChatPage(page);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: _currentChatPage == page ? Colors.deepPurple.shade700 : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                page.name,
                style: TextStyle(
                  color: _currentChatPage == page ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(Message message, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Align(
          alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: message.isUser ? Colors.deepPurple.shade700 : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft:
                message.isUser ? Radius.circular(16) : Radius.circular(0),
                bottomRight:
                message.isUser ? Radius.circular(0) : Radius.circular(16),
              ),
            ),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      message.text,
                      textStyle: TextStyle(
                        color: message.isUser ? Colors.white : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      textAlign:
                      message.isUser ? TextAlign.right : TextAlign.left,
                      speed: Duration(milliseconds: 50),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: message.isUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    IconButton(
                      iconSize: 20,
                      icon: Icon(
                        _isFavorite(message)
                            ?Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      onPressed: () => _toggleFavorite(message),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.copy, color: Colors.black),
                      onPressed: () => _copyText(message.text),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.download, color: Colors.black),
                      onPressed: () => _downloadTextAsFile(message.text),
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        if (_currentChatPage != null) {
                          int index =
                          _currentChatPage!.messages.indexOf(message);
                          if (index != -1) {
                            final removedMessage =
                            _currentChatPage!.messages.removeAt(index);
                            _listKey.currentState?.removeItem(
                              index,
                                  (context, animation) =>
                                  _buildMessageItem(removedMessage, animation),
                              duration: Duration(milliseconds: 300),
                            );
                            _saveChatPages();
                            void showTopSnackBar(BuildContext context, String message) {
                              final overlay = Overlay.of(context);
                              final overlayEntry = OverlayEntry(
                                builder: (context) => Positioned(
                                  top: 50.0,
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              message,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              overlay?.insert(overlayEntry);
                              Future.delayed(Duration(seconds: 3), () {
                                overlayEntry.remove();
                              });
                            }
                            showTopSnackBar(context, "Environmental message deleted");

                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// نموذج للرسالة المجدولة
class ScheduledMessage {
  String text;
  DateTime scheduledTime;

  ScheduledMessage({required this.text, required this.scheduledTime});
}


class ApiService {
  String _apiKey = 'AIzaSyALhb262a99kq0E_swAqyz9bJSPCmHSQv4';

  Future<String> getTextResponse(String message) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text': message,
            },
          ],
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Simplified data extraction with null checks
        final generatedText = data?['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return generatedText ?? 'No response text found';
      } else {
        // print('Error: ${response.statusCode}');
        // print('Response body: ${response.body}');
        return 'Error generating response';
      }
    } catch (e) {
      //  print('Exception in getTextResponse: $e');
      return 'Error generating response';
    }
  }

  Future<String?> getImageTextResponse(File image, String prompt) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text': prompt,
            },
          ],
        },
        // Add image data here if the API accepts it, e.g., Base64 encoding of the image
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final generatedText = data?['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return generatedText ?? 'No response text found';
      } else {
        // print('Error: ${response.statusCode}');
        // print('Response body: ${response.body}');
        return 'Error processing image';
      }
    } catch (e) {
      //print('Exception in getImageTextResponse: $e');
      return null;
    }
  }
}


class FavoritesScreen extends StatefulWidget {
  final List<Message> favorites;
  final Function(Message) toggleFavorite;

  FavoritesScreen({required this.favorites, required this.toggleFavorite});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }
  bool _isFavorite(Message message) {
    return _favorites.contains(message);
  }
  List<Message> _favorites = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final message = widget.favorites[index];
          return Align(
            alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatTimestamp(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isUser ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  // إضافة الأيقونات أسفل كل رسالة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 20,
                        icon: Icon(
                          _isFavorite(message)
                              ?Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.toggleFavorite(message);
                          });
                        },
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.copy, color: Colors.black),
                        onPressed: () => Clipboard.setData(ClipboardData(text: message.text)),
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.download, color: Colors.black),
                        onPressed: () => _downloadTextAsFile(context, message.text),
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            widget.favorites.remove(message);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _downloadTextAsFile(BuildContext context, String text) async {
    try {
      String fileName = "favorite_${DateTime.now().millisecondsSinceEpoch}.txt";
      //final bytes = utf8.encode(text);

      // await FileSaver.instance.saveFile(
      //   name: fileName,
      //   ext: "txt",
      // bytes: bytes,
      //   mimeType: MimeType.text,
      //  );
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'File downloaded successfully');

    } catch (e) {
      void showTopSnackBar(BuildContext context, String message) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 50.0,
            left: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );

        overlay?.insert(overlayEntry);
        Future.delayed(Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      showTopSnackBar(context, 'An error occurred while downloading the file: $e');

    }
  }
}
