import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../models/app_language.dart';
import '../models/medical_guide.dart';
import '../providers/curae_provider.dart';
import '../widgets/curae_app_bar.dart';

class GuideDetailScreen extends StatelessWidget {
  final MedicalGuide guide;

  const GuideDetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuraeProvider>(context);
    final strings = provider.strings;
    final isEs = provider.language == AppLanguage.es;

    final title = isEs ? guide.titleEs : guide.titleEn;
    final summary = isEs ? guide.summaryEs : guide.summaryEn;
    final steps = isEs ? guide.stepsEs : guide.stepsEn;
    final warning = isEs ? guide.warningEs : guide.warningEn;

    return Scaffold(
      appBar: CuraeAppBar(
        title: title,
        subtitle: strings.medicalContentTitle,
        showBackButton: true,
        language: provider.language,
        onLanguageToggle: provider.toggleLanguage,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(guide.iconEmoji, style: const TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(summary, style: const TextStyle(fontSize: 15, height: 1.4)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              strings.stepByStep,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...steps.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final stepText = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        "$index",
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(stepText, style: const TextStyle(fontSize: 15, height: 1.4)),
                    ),
                  ],
                ),
              );
            }),
            if (warning != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDAD6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFBA1A1A), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.warning_amber_rounded, color: Color(0xFF410002)),
                        SizedBox(width: 8),
                        Text(
                          "PRECAUCIÓN",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF410002)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(warning, style: const TextStyle(color: Color(0xFF410002), fontSize: 14, height: 1.4)),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              strings.disclaimerText,
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
