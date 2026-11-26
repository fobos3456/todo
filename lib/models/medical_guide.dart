enum MedicalCategory { all, firstAid, vitalSigns, glossary, emergency }

class MedicalGuide {
  final String id;
  final MedicalCategory category;
  final String iconEmoji;
  final String titleEs;
  final String titleEn;
  final String summaryEs;
  final String summaryEn;
  final List<String> stepsEs;
  final List<String> stepsEn;
  final String? warningEs;
  final String? warningEn;

  const MedicalGuide({
    required this.id,
    required this.category,
    required this.iconEmoji,
    required this.titleEs,
    required this.titleEn,
    required this.summaryEs,
    required this.summaryEn,
    required this.stepsEs,
    required this.stepsEn,
    this.warningEs,
    this.warningEn,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category.name,
      'iconEmoji': iconEmoji,
      'titleEs': titleEs,
      'titleEn': titleEn,
      'summaryEs': summaryEs,
      'summaryEn': summaryEn,
      'stepsEs': stepsEs,
      'stepsEn': stepsEn,
      'warningEs': warningEs,
      'warningEn': warningEn,
    };
  }

  factory MedicalGuide.fromMap(Map<String, dynamic> map, String docId) {
    return MedicalGuide(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      category: MedicalCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => MedicalCategory.all,
      ),
      iconEmoji: map['iconEmoji'] ?? '🩺',
      titleEs: map['titleEs'] ?? '',
      titleEn: map['titleEn'] ?? '',
      summaryEs: map['summaryEs'] ?? '',
      summaryEn: map['summaryEn'] ?? '',
      stepsEs: List<String>.from(map['stepsEs'] ?? []),
      stepsEn: List<String>.from(map['stepsEn'] ?? []),
      warningEs: map['warningEs'],
      warningEn: map['warningEn'],
    );
  }

  static const List<MedicalGuide> sampleGuides = [
    MedicalGuide(
      id: "fa_choking",
      category: MedicalCategory.firstAid,
      iconEmoji: "🫁",
      titleEs: "Maniobra de Atragantamiento (Heimlich)",
      titleEn: "Choking Relief (Heimlich Maneuver)",
      summaryEs: "Actuación inmediata ante obstrucción grave de la vía aérea en adultos o niños mayores de 1 año.",
      summaryEn: "Immediate action for severe airway obstruction in adults and children over 1 year.",
      stepsEs: [
        "Párate detrás de la persona y rodéala con tus brazos alrededor de la cintura.",
        "Haz un puño con una mano y colócalo justo por encima del ombligo, debajo de las costillas.",
        "Sujeta el puño con tu otra mano y presiona hacia adentro y hacia arriba con impulsos rápidos.",
        "Repite las compresiones hasta que el objeto sea expulsado o la persona comience a toser fuerte."
      ],
      stepsEn: [
        "Stand behind the person and wrap your arms around their waist.",
        "Make a fist with one hand and place it just above the navel, below the ribs.",
        "Grasp the fist with your other hand and press inward and upward with quick thrusts.",
        "Repeat thrusts until the object is expelled or the person coughs strongly."
      ],
      warningEs: "Si la persona pierde el conocimiento, recuéstala suavemente en el suelo y llama inmediatamente al 911.",
      warningEn: "If the person loses consciousness, gently lay them on the floor and call 911 immediately."
    ),
    MedicalGuide(
      id: "fa_burns",
      category: MedicalCategory.firstAid,
      iconEmoji: "🩹",
      titleEs: "Quemaduras Leves y Moderadas",
      titleEn: "Minor and Moderate Burns",
      summaryEs: "Protocolo inicial para refrescar quemaduras de primer y segundo grado sin romper ampollas.",
      summaryEn: "Initial protocol to cool first and second degree burns without breaking blisters.",
      stepsEs: [
        "Enfría la zona afectada inmediatamente con agua corriente a temperatura ambiente durante 10 a 15 minutos.",
        "Retira cuidadosamente prendas ajustadas o anillos cerca de la quemadura antes de que se inflame.",
        "Cubre la quemadura de forma holgada con una gasa estéril o paño limpio.",
        "No apliques hielo, pasta dental ni aceites sobre la piel dañada."
      ],
      stepsEn: [
        "Cool the affected area immediately with room-temperature running water for 10 to 15 minutes.",
        "Carefully remove tight clothing or rings near the burn before swelling starts.",
        "Cover the burn loosely with sterile gauze or a clean cloth.",
        "Do not apply ice, toothpaste, or oils to damaged skin."
      ],
      warningEs: "Busca atención médica si la quemadura es mayor a la palma de la mano o afecta rostro, manos o articulaciones.",
      warningEn: "Seek medical care if the burn is larger than your palm or involves the face, hands, or joints."
    ),
    MedicalGuide(
      id: "vs_bp",
      category: MedicalCategory.vitalSigns,
      iconEmoji: "🩺",
      titleEs: "Presión Arterial: Valores y Significado",
      titleEn: "Blood Pressure: Values and Meaning",
      summaryEs: "Cómo interpretar tus lecturas de presión sistólica y diastólica en reposo.",
      summaryEn: "How to interpret your resting systolic and diastolic blood pressure readings.",
      stepsEs: [
        "Presión Normal: Sistólica menor a 120 mmHg y Diastólica menor a 80 mmHg (ej. 115/75).",
        "Presión Elevada: Sistólica entre 120-129 mmHg y Diastólica menor a 80 mmHg.",
        "Hipertensión Etapa 1: Sistólica 130-139 mmHg o Diastólica 80-89 mmHg.",
        "Mídete la presión tras 5 minutos de reposo, en posición sentada y sin haber tomado café o fumado."
      ],
      stepsEn: [
        "Normal Pressure: Systolic under 120 mmHg and Diastolic under 80 mmHg (e.g. 115/75).",
        "Elevated Pressure: Systolic 120-129 mmHg and Diastolic under 80 mmHg.",
        "Hypertension Stage 1: Systolic 130-139 mmHg or Diastolic 80-89 mmHg.",
        "Measure after 5 minutes of rest, seated, and without recent caffeine or tobacco use."
      ],
      warningEs: "Si tu lectura supera 180/120 y tienes dolor de cabeza intenso o visión borrosa, acude a urgencias.",
      warningEn: "If your reading exceeds 180/120 with severe headache or blurred vision, go to the ER."
    ),
    MedicalGuide(
      id: "em_chest_pain",
      category: MedicalCategory.emergency,
      iconEmoji: "🚨",
      titleEs: "Cuándo Acudir a Urgencias Hospitalarias",
      titleEn: "When to Go to the Emergency Room",
      summaryEs: "Señales de advertencia críticas que requieren evaluación médica inmediata en emergencias.",
      summaryEn: "Critical warning signs that require immediate emergency medical evaluation.",
      stepsEs: [
        "Dolor opresivo o fuerte presión en el centro del pecho que se irradia al brazo izquierdo o mandíbula.",
        "Dificultad súbita para respirar, falta de aire o asfixia sin causa evidente.",
        "Pérdida del habla, debilidad repentina en un lado del cuerpo o parálisis facial.",
        "Fiebre muy alta (>39.5°C) que no baja con antitérmicos o acompañada de rigidez en el cuello."
      ],
      stepsEn: [
        "Chest tightness or severe pressure radiating to left arm or jaw.",
        "Sudden shortness of breath, gasping, or asphyxia without clear reason.",
        "Sudden loss of speech, weakness on one side of the body, or facial drooping.",
        "Very high fever (>39.5°C) unresponsive to antipyretics or accompanied by stiff neck."
      ],
      warningEs: "Ante cualquiera de estas señales, NO conduzcas tú mismo. Llama al 911 o pide auxilio inmediato.",
      warningEn: "With any of these signs, DO NOT drive yourself. Call 911 or request immediate help."
    )
  ];
}
