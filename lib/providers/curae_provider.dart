import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/app_language.dart';
import '../models/chat_message.dart';
import '../models/medical_guide.dart';
import '../services/api_service.dart';
import '../services/sqlite_service.dart';

class CuraeProvider extends ChangeNotifier {
  AppLanguage _language = AppLanguage.es;
  bool _isTutorTyping = false;
  MedicalCategory _selectedCategory = MedicalCategory.all;
  String _searchQuery = "";
  List<MedicalGuide> _guides = MedicalGuide.sampleGuides;

  final SqliteService _sqlite = SqliteService.instance;
  final ApiService _api = ApiService();

  FirebaseFirestore? _firestoreInstance;
  FirebaseFirestore? get _firestore {
    try {
      _firestoreInstance ??= FirebaseFirestore.instance;
      return _firestoreInstance;
    } catch (_) {
      return null;
    }
  }

  final List<ChatMessage> _messages = [
    ChatMessage(
      id: "1",
      sender: MessageSender.tutor,
      text: "¡Hola! Soy tu tutor y guía de salud en curae. "
          "Estoy aquí para orientarte con información médica general explicada paso a paso y en palabras sencillas. "
          "¿Sobre qué síntoma, concepto o cuidado de salud te gustaría aprender hoy?",
      suggestedActions: const [
        "¿Cómo aliviar un dolor de cabeza?",
        "¿Qué hacer en caso de fiebre?",
        "¿Qué significa presión 120/80?"
      ],
    )
  ];

  CuraeProvider() {
    _initDataPipeline();
  }

  AppLanguage get language => _language;
  AppStrings get strings => _language == AppLanguage.es ? stringsEs : stringsEn;
  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTutorTyping => _isTutorTyping;
  MedicalCategory get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<MedicalGuide> get filteredGuides {
    return _guides.where((guide) {
      final matchesCategory = _selectedCategory == MedicalCategory.all || guide.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      if (query.isEmpty) return matchesCategory;

      final title = _language == AppLanguage.es ? guide.titleEs : guide.titleEn;
      final summary = _language == AppLanguage.es ? guide.summaryEs : guide.summaryEn;
      return matchesCategory && (title.toLowerCase().contains(query) || summary.toLowerCase().contains(query));
    }).toList();
  }

  void _initDataPipeline() async {
    // 1. Cargar almacenamiento local de SQLite inmediatamente (Respuesta ultra rápida sin conexión)
    try {
      final localGuides = await _sqlite.getMedicalGuides();
      if (localGuides.isNotEmpty) {
        _guides = localGuides;
        notifyListeners();
      } else {
        await _sqlite.saveMedicalGuides(MedicalGuide.sampleGuides);
      }

      final localMessages = await _sqlite.getMessages();
      if (localMessages.isNotEmpty) {
        _messages.clear();
        _messages.addAll(localMessages);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Info SQLite Local: $e");
    }

    // 2. Conectar e igualar datos con Firebase Cloud Firestore
    try {
      final db = _firestore;
      if (db == null) return;

      final guidesRef = db.collection('medical_guides');
      final snapshot = await guidesRef.get();

      if (snapshot.docs.isEmpty) {
        for (final guide in MedicalGuide.sampleGuides) {
          await guidesRef.doc(guide.id).set(guide.toMap());
        }
      } else {
        _guides = snapshot.docs
            .map((doc) => MedicalGuide.fromMap(doc.data(), doc.id))
            .toList();
        await _sqlite.saveMedicalGuides(_guides);
        notifyListeners();
      }

      db.collection('messages').orderBy('timestamp', descending: false).snapshots().listen((chatSnapshot) {
        if (chatSnapshot.docs.isNotEmpty) {
          _messages.clear();
          for (final doc in chatSnapshot.docs) {
            final msg = ChatMessage.fromMap(doc.data(), doc.id);
            _messages.add(msg);
            _sqlite.saveMessage(msg);
          }
          notifyListeners();
        }
      });
    } catch (e) {
      debugPrint("Info Firebase Firestore Sync: $e");
    }
  }

  void toggleLanguage() {
    _language = _language == AppLanguage.es ? AppLanguage.en : AppLanguage.es;
    notifyListeners();
  }

  void selectCategory(MedicalCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: MessageSender.user,
      text: trimmed,
    );

    _messages.add(userMsg);
    _isTutorTyping = true;
    notifyListeners();

    // Guardar mensaje de usuario localmente en SQLite y Firebase
    await _sqlite.saveMessage(userMsg);
    try {
      await _firestore?.collection('messages').doc(userMsg.id).set(userMsg.toMap());
    } catch (_) {}

    final isEs = _language == AppLanguage.es;
    final langCode = isEs ? 'es' : 'en';

    // Intento 1: Consultar al Servidor Local en Python (FastAPI/Flask)
    String? responseText = await _api.consultarServidorPython(trimmed, langCode);

    // Intento 2: Fallback local si el servidor Python no está activo
    if (responseText == null) {
      responseText = isEs
          ? "Gracias por consultar. Como tu tutor de salud, te oriento sobre '$trimmed':\n\n"
              "1. Descansa en un lugar tranquilo y mantente bien hidratado.\n"
              "2. No te automediques con medicamentos fuertes sin indicación previa.\n"
              "3. Observa la evolución de tus síntomas en las próximas horas.\n\n"
              "⚠️ Consulta a un médico o centro de salud si el malestar persiste más de 48 horas, o si presentas dolor intenso o fiebre alta."
          : "Thank you for asking. As your health tutor, here is guidance on '$trimmed':\n\n"
              "1. Rest in a comfortable place and stay properly hydrated.\n"
              "2. Avoid self-medicating with strong medications without medical guidance.\n"
              "3. Observe how your symptoms evolve over the next hours.\n\n"
              "⚠️ Consult a healthcare provider if symptoms persist more than 48 hours or if you develop severe pain or high fever.";
    }

    final tutorMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: MessageSender.tutor,
      text: responseText,
      suggestedActions: [
        strings.explainSimpler,
        strings.whenToSeeDoctor,
        strings.preventCare,
      ],
    );

    _messages.add(tutorMsg);
    _isTutorTyping = false;
    notifyListeners();

    // Guardar respuesta del Tutor localmente en SQLite y en Firebase
    await _sqlite.saveMessage(tutorMsg);
    try {
      await _firestore?.collection('messages').doc(tutorMsg.id).set(tutorMsg.toMap());
    } catch (_) {}
  }
}
