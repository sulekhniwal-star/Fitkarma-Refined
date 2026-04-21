import 'package:drift/drift.dart';

@DataClassName('LocalUser')
class Users extends Table {
  TextColumn get id => text()(); // Appwrite User ID
  TextColumn get email => text()();
  TextColumn get name => text()();
  IntColumn get karmaTotal => integer().withDefault(const Constant(0))();
  IntColumn get karmaLevel => integer().withDefault(const Constant(1))();
  BoolColumn get onboardingCompleted => boolean().withDefault(const Constant(false))();

  // Wedding Planner fields
  TextColumn get weddingRole => text().nullable()(); // bride|groom|guest|relative|none
  TextColumn get weddingRelationType => text().nullable()(); // father_bride|mother_bride|...
  DateTimeColumn get weddingStartDate => dateTime().nullable()();
  DateTimeColumn get weddingEndDate => dateTime().nullable()();
  IntColumn get weddingPrepWeeks => integer().nullable()(); // 1,2,4,8 or null
  TextColumn get weddingEvents => text().nullable()(); // JSON: ["haldi","mehendi",...]
  TextColumn get weddingPrimaryGoal => text().nullable()(); // tone_up|energised|manage_stress|manage_indulgence
  
  // Ayurveda fields
  IntColumn get doshaVata => integer().nullable()();
  IntColumn get doshaPitta => integer().nullable()();
  IntColumn get doshaKapha => integer().nullable()();
  TextColumn get dominantDosha => text().nullable()(); // vata|pitta|kapha
  BoolColumn get retainOcrText => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

