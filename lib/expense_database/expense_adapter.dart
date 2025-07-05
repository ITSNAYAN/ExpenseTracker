import 'package:hive/hive.dart';

part 'expense_adapter.g.dart';

@HiveType(typeId: 0)
class ExpenseAdapter extends HiveObject {
  @HiveField(0)
  String? description;

  @HiveField(1)
  double? amount;

  @HiveField(2)
  DateTime? dateTime;


  ExpenseAdapter({required this.description, required this.amount, required this.dateTime});
}

// | You See This           | It Means                               |
// | ---------------------- | -------------------------------------- |
// | `@HiveType(typeId: 0)` | "I'm registering a new Hive model"     |
// | `@HiveField(0)`        | "This is a field to save"              |
// | `extends HiveObject`   | "Add Hive-powered methods to my class , USE TO FOLLOWS CRUD OPERATION " |
