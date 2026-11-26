import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../models/app_language.dart';
import '../models/medical_guide.dart';
import '../providers/curae_provider.dart';
import '../widgets/curae_app_bar.dart';
import 'guide_detail_screen.dart';

class MedicalGuidesScreen extends StatelessWidget {
  const MedicalGuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuraeProvider>(context);
    final strings = provider.strings;
    final guides = provider.filteredGuides;

    return Scaffold(
      appBar: CuraeAppBar(
        title: strings.medicalContentTitle,
        subtitle: strings.offlineModeNotice,
        showBackButton: true,
        language: provider.language,
        onLanguageToggle: provider.toggleLanguage,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: provider.updateSearchQuery,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: strings.searchPlaceholder,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: MedicalCategory.values.map((cat) {
                final isSelected = provider.selectedCategory == cat;
                String catName;
                switch (cat) {
                  case MedicalCategory.all:
                    catName = strings.categoryAll;
                    break;
                  case MedicalCategory.firstAid:
                    catName = strings.categoryFirstAid;
                    break;
                  case MedicalCategory.vitalSigns:
                    catName = strings.categoryVitalSigns;
                    break;
                  case MedicalCategory.glossary:
                    catName = strings.categoryGlossary;
                    break;
                  case MedicalCategory.emergency:
                    catName = strings.categoryEmergency;
                    break;
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(catName),
                    onSelected: (_) => provider.selectCategory(cat),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                final title = provider.language == AppLanguage.es ? guide.titleEs : guide.titleEn;
                final summary = provider.language == AppLanguage.es ? guide.summaryEs : guide.summaryEn;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Text(guide.iconEmoji, style: const TextStyle(fontSize: 22)),
                    ),
                    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(summary, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => GuideDetailScreen(guide: guide)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
