import 'package:realm/realm.dart';

import 'database.dart';

final config = Configuration.local([Reclamation.schema],shouldDeleteIfMigrationNeeded: true);
final realm = Realm(config);
