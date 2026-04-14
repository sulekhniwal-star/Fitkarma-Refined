import 'package:drift/drift.dart';

@DataClassName('LocalUser')
class Users extends Table {
  TextColumn get id => text()(); // Appwrite User ID
  TextColumn get email => text()();
  TextColumn get name => text()();
  IntColumn get karmaTotal => integer().withDefault(const Constant(0))();
  IntColumn get karmaLevel => integer().withDefault(const Constant(1))();
  BoolColumn get onboardingCompleted => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column> get primaryKey => {id};
}
