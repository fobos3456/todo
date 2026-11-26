import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../models/app_language.dart';
import '../models/medical_guide.dart';
import '../providers/curae_provider.dart';
import '../widgets/curae_app_bar.dart';
import '../widgets/emergency_banner.dart';
import 'chat_screen.dart';
import 'medical_guides_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuraeProvider>(context);
    final strings = provider.strings;

    return Scaffold(
      appBar: CuraeAppBar(
        title: strings.appTitle,
        subtitle: strings.appTagline,
        language: provider.language,
        onLanguageToggle: provider.toggleLanguage,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmergencyBanner(
              strings: strings,
              onEmergencyClick: () {
                provider.sendMessage(
                  provider.language == AppLanguage.es
                      ? "¿Cuáles son las señales críticas para ir a urgencias hospitalarias?"
                      : "What are the critical warning signs to go to the hospital ER?",
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
              },
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: const Text("🤖", style: TextStyle(fontSize: 24)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(strings.tutorCardTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(strings.tutorCardDesc, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                        },
                        icon: const Icon(Icons.chat_bubble_outline),
                        label: Text(strings.startTutorChat, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          child: const Text("📚", style: TextStyle(fontSize: 24)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(strings.medicalContentTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(strings.medicalContentDesc, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          provider.selectCategory(MedicalCategory.all);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicalGuidesScreen()));
                        },
                        icon: const Icon(Icons.menu_book),
                        label: Text(strings.exploreGuides, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
