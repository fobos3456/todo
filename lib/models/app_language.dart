enum AppLanguage { es, en }

class AppStrings {
  final String appTitle;
  final String appTagline;
  final String emergencyNotice;
  final String emergencyAction;
  final String tutorCardTitle;
  final String tutorCardDesc;
  final String startTutorChat;
  final String medicalContentTitle;
  final String medicalContentDesc;
  final String exploreGuides;
  final String quickQuestionsTitle;
  final String categoryAll;
  final String categoryFirstAid;
  final String categoryVitalSigns;
  final String categoryGlossary;
  final String categoryEmergency;
  final String chatTitle;
  final String chatSubtitle;
  final String inputPlaceholder;
  final String sendButton;
  final String explainSimpler;
  final String whenToSeeDoctor;
  final String preventCare;
  final String tutorThinking;
  final String offlineModeNotice;
  final String stepByStep;
  final String precautions;
  final String disclaimerText;
  final String back;
  final String searchPlaceholder;

  const AppStrings({
    required this.appTitle,
    required this.appTagline,
    required this.emergencyNotice,
    required this.emergencyAction,
    required this.tutorCardTitle,
    required this.tutorCardDesc,
    required this.startTutorChat,
    required this.medicalContentTitle,
    required this.medicalContentDesc,
    required this.exploreGuides,
    required this.quickQuestionsTitle,
    required this.categoryAll,
    required this.categoryFirstAid,
    required this.categoryVitalSigns,
    required this.categoryGlossary,
    required this.categoryEmergency,
    required this.chatTitle,
    required this.chatSubtitle,
    required this.inputPlaceholder,
    required this.sendButton,
    required this.explainSimpler,
    required this.whenToSeeDoctor,
    required this.preventCare,
    required this.tutorThinking,
    required this.offlineModeNotice,
    required this.stepByStep,
    required this.precautions,
    required this.disclaimerText,
    required this.back,
    required this.searchPlaceholder,
  });
}

const stringsEs = AppStrings(
  appTitle: "curae",
  appTagline: "Orientación de salud accesible y preventiva",
  emergencyNotice: "En emergencias graves (dolor opresivo de pecho, desmayo o sangrado abundante), llama de inmediato al número de emergencia local (911).",
  emergencyAction: "Llamar 911",
  tutorCardTitle: "Tutor y Guía Inteligente",
  tutorCardDesc: "Consulta tus dudas de salud en lenguaje sencillo. Tu guía paso a paso con inteligencia artificial.",
  startTutorChat: "Iniciar consulta con el tutor",
  medicalContentTitle: "Contenido Médico Técnico",
  medicalContentDesc: "Guías prácticas de primeros auxilios, signos vitales y términos médicos disponibles 100% sin conexión.",
  exploreGuides: "Explorar guías prácticas",
  quickQuestionsTitle: "Consultas frecuentes de orientación:",
  categoryAll: "Todos",
  categoryFirstAid: "Primeros Auxilios",
  categoryVitalSigns: "Signos Vitales",
  categoryGlossary: "Glosario Médico",
  categoryEmergency: "Cuándo ir a Urgencias",
  chatTitle: "Tutor curae",
  chatSubtitle: "Guía informativo de salud",
  inputPlaceholder: "Escribe tu duda médica aquí...",
  sendButton: "Enviar",
  explainSimpler: "Explícamelo más fácil",
  whenToSeeDoctor: "¿Cuándo acudir al médico?",
  preventCare: "¿Qué cuidados preventivos tener?",
  tutorThinking: "Tu tutor está preparando una respuesta clara...",
  offlineModeNotice: "Modo sin conexión: Acceso a guías técnicas guardadas.",
  stepByStep: "Instrucciones paso a paso:",
  precautions: "Banderas rojas y precauciones:",
  disclaimerText: "Aviso: curae es una herramienta educativa e informativa. No emite diagnósticos ni reemplaza una consulta médica profesional.",
  back: "Volver",
  searchPlaceholder: "Buscar tema o síntoma...",
);

const stringsEn = AppStrings(
  appTitle: "curae",
  appTagline: "Accessible and preventive health guidance",
  emergencyNotice: "In severe emergencies (chest pressure, fainting, or heavy bleeding), call your local emergency service (911) immediately.",
  emergencyAction: "Call 911",
  tutorCardTitle: "Smart Tutor & Guide",
  tutorCardDesc: "Ask health questions in clear, simple language. Step-by-step guidance powered by artificial intelligence.",
  startTutorChat: "Start conversation with tutor",
  medicalContentTitle: "Practical Medical Content",
  medicalContentDesc: "Quick guides for first aid, vital signs, and common medical terms. 100% available offline.",
  exploreGuides: "Explore practical guides",
  quickQuestionsTitle: "Common health inquiries:",
  categoryAll: "All",
  categoryFirstAid: "First Aid",
  categoryVitalSigns: "Vital Signs",
  categoryGlossary: "Medical Glossary",
  categoryEmergency: "When to seek ER",
  chatTitle: "curae Tutor",
  chatSubtitle: "Informational health guide",
  inputPlaceholder: "Type your health question here...",
  sendButton: "Send",
  explainSimpler: "Explain simpler",
  whenToSeeDoctor: "When to see a doctor?",
  preventCare: "Preventive care tips",
  tutorThinking: "Your tutor is preparing a clear explanation...",
  offlineModeNotice: "Offline mode: Saved medical guides available.",
  stepByStep: "Step-by-step instructions:",
  precautions: "Red flags and warnings:",
  disclaimerText: "Notice: curae is an informational educational tool. It does not provide medical diagnoses or replace professional consultation.",
  back: "Back",
  searchPlaceholder: "Search topic or symptom...",
);
