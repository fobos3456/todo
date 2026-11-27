import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/chat_message.dart';
import '../models/medical_guide.dart';

class SqliteService {
  static final SqliteService instance = SqliteService._internal();
  static Database? _database;

  SqliteService._internal();

  Future<Database?> get database async {
    if (kIsWeb) return null; // SQLite no se soporta nativamente en Web puro
    if (_database != null) return _database;
    try {
      _database = await _initDatabase();
      return _database;
    } catch (e) {
      debugPrint("Info SQLite Init: $e");
      return null;
    }
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'curae_local.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE medical_guides (
            id TEXT PRIMARY KEY,
            category TEXT,
            iconEmoji TEXT,
            titleEs TEXT,
            titleEn TEXT,
            summaryEs TEXT,
            summaryEn TEXT,
            stepsEs TEXT,
            stepsEn TEXT,
            warningEs TEXT,
            warningEn TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE messages (
            id TEXT PRIMARY KEY,
            sender TEXT,
            text TEXT,
            timestamp INTEGER,
            suggestedActions TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveMedicalGuides(List<MedicalGuide> guides) async {
    final db = await database;
    if (db == null) return;

    final batch = db.batch();
    for (final guide in guides) {
      batch.insert(
        'medical_guides',
        {
          'id': guide.id,
          'category': guide.category.name,
          'iconEmoji': guide.iconEmoji,
          'titleEs': guide.titleEs,
          'titleEn': guide.titleEn,
          'summaryEs': guide.summaryEs,
          'summaryEn': guide.summaryEn,
          'stepsEs': guide.stepsEs.join('||'),
          'stepsEn': guide.stepsEn.join('||'),
          'warningEs': guide.warningEs ?? '',
          'warningEn': guide.warningEn ?? '',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<MedicalGuide>> getMedicalGuides() async {
    final db = await database;
    if (db == null) return [];

    final List<Map<String, dynamic>> maps = await db.query('medical_guides');
    if (maps.isEmpty) return [];

    return maps.map((map) {
      return MedicalGuide(
        id: map['id'] ?? '',
        category: MedicalCategory.values.firstWhere(
          (e) => e.name == map['category'],
          orElse: () => MedicalCategory.all,
        ),
        iconEmoji: map['iconEmoji'] ?? '🩺',
        titleEs: map['titleEs'] ?? '',
        titleEn: map['titleEn'] ?? '',
        summaryEs: map['summaryEs'] ?? '',
        summaryEn: map['summaryEn'] ?? '',
        stepsEs: (map['stepsEs'] as String? ?? '').split('||').where((s) => s.isNotEmpty).toList(),
        stepsEn: (map['stepsEn'] as String? ?? '').split('||').where((s) => s.isNotEmpty).toList(),
        warningEs: (map['warningEs'] as String? ?? '').isNotEmpty ? map['warningEs'] : null,
        warningEn: (map['warningEn'] as String? ?? '').isNotEmpty ? map['warningEn'] : null,
      );
    }).toList();
  }

  Future<void> saveMessage(ChatMessage msg) async {
    final db = await database;
    if (db == null) return;

    await db.insert(
      'messages',
      {
        'id': msg.id,
        'sender': msg.sender.name,
        'text': msg.text,
        'timestamp': msg.timestamp.millisecondsSinceEpoch,
        'suggestedActions': msg.suggestedActions.join('||'),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatMessage>> getMessages() async {
    final db = await database;
    if (db == null) return [];

    final List<Map<String, dynamic>> maps = await db.query('messages', orderBy: 'timestamp ASC');
    if (maps.isEmpty) return [];

    return maps.map((map) {
      return ChatMessage(
        id: map['id'] ?? '',
        sender: map['sender'] == 'user' ? MessageSender.user : MessageSender.tutor,
        text: map['text'] ?? '',
        timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? DateTime.now().millisecondsSinceEpoch),
        suggestedActions: (map['suggestedActions'] as String? ?? '').split('||').where((s) => s.isNotEmpty).toList(),
      );
    }).toList();
  }
}
