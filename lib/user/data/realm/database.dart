import 'package:realm/realm.dart';
part 'database.g.dart';


@RealmModel()
class _Reclamation {
  @PrimaryKey()
  late ObjectId id;
  late String images;
  late String? problem;
  late String? commentaire;
  late String? status;
  late String? color;
  late bool? isOpen;
  late DateTime? date;
  late String? imageconfirmed;
}

