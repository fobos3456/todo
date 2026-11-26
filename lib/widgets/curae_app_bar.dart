import 'package:material_ui/material_ui.dart';
import '../models/app_language.dart';

class CuraeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final AppLanguage language;
  final VoidCallback onLanguageToggle;

  const CuraeAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    required this.language,
    required this.onLanguageToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ActionChip(
            avatar: Icon(language == AppLanguage.es ? Icons.language : Icons.translate, size: 18),
            label: Text(language == AppLanguage.es ? "ES | en" : "en | ES"),
            onPressed: onLanguageToggle,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
