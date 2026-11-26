import 'package:material_ui/material_ui.dart';
import '../models/app_language.dart';
import '../models/chat_message.dart';
import '../models/medical_guide.dart';

class CuraeProvider extends ChangeNotifier {
  AppLanguage _language = AppLanguage.es;
  bool _isTutorTyping = false;
  MedicalCategory _selectedCategory = MedicalCategory.all;
  String _searchQuery = "";

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

  AppLanguage get language => _language;
  AppStrings get strings => _language == AppLanguage.es ? stringsEs : stringsEn;
  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTutorTyping => _isTutorTyping;
  MedicalCategory get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<MedicalGuide> get filteredGuides {
    return MedicalGuide.sampleGuides.where((guide) {
      final matchesCategory = _selectedCategory == MedicalCategory.all || guide.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      if (query.isEmpty) return matchesCategory;

      final title = _language == AppLanguage.es ? guide.titleEs : guide.titleEn;
      final summary = _language == AppLanguage.es ? guide.summaryEs : guide.summaryEn;
      return matchesCategory && (title.toLowerCase().contains(query) || summary.toLowerCase().contains(query));
    }).toList();
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

    _messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: MessageSender.user,
      text: trimmed,
    ));
    _isTutorTyping = true;
    notifyListeners();

    // Simulación de interacción con el backend Python o servicio de Firebase AI
    await Future.delayed(const Duration(milliseconds: 1500));

    final isEs = _language == AppLanguage.es;
    final responseText = isEs
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

    _messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: MessageSender.tutor,
      text: responseText,
      suggestedActions: [
        strings.explainSimpler,
        strings.whenToSeeDoctor,
        strings.preventCare,
      ],
    ));

    _isTutorTyping = false;
    notifyListeners();
  }
}
