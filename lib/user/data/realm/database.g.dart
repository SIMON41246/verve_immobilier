// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Reclamation extends _Reclamation
    with RealmEntity, RealmObjectBase, RealmObject {
  Reclamation(
    ObjectId id,
    String images, {
    String? problem,
    String? commentaire,
    String? status,
    String? color,
    bool? isOpen,
    DateTime? date,
    String? imageconfirmed,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'images', images);
    RealmObjectBase.set(this, 'problem', problem);
    RealmObjectBase.set(this, 'commentaire', commentaire);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'isOpen', isOpen);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'imageconfirmed', imageconfirmed);
  }

  Reclamation._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get images => RealmObjectBase.get<String>(this, 'images') as String;
  @override
  set images(String value) => RealmObjectBase.set(this, 'images', value);

  @override
  String? get problem =>
      RealmObjectBase.get<String>(this, 'problem') as String?;
  @override
  set problem(String? value) => RealmObjectBase.set(this, 'problem', value);

  @override
  String? get commentaire =>
      RealmObjectBase.get<String>(this, 'commentaire') as String?;
  @override
  set commentaire(String? value) =>
      RealmObjectBase.set(this, 'commentaire', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  String? get color => RealmObjectBase.get<String>(this, 'color') as String?;
  @override
  set color(String? value) => RealmObjectBase.set(this, 'color', value);

  @override
  bool? get isOpen => RealmObjectBase.get<bool>(this, 'isOpen') as bool?;
  @override
  set isOpen(bool? value) => RealmObjectBase.set(this, 'isOpen', value);

  @override
  DateTime? get date =>
      RealmObjectBase.get<DateTime>(this, 'date') as DateTime?;
  @override
  set date(DateTime? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get imageconfirmed =>
      RealmObjectBase.get<String>(this, 'imageconfirmed') as String?;
  @override
  set imageconfirmed(String? value) =>
      RealmObjectBase.set(this, 'imageconfirmed', value);

  @override
  Stream<RealmObjectChanges<Reclamation>> get changes =>
      RealmObjectBase.getChanges<Reclamation>(this);

  @override
  Reclamation freeze() => RealmObjectBase.freezeObject<Reclamation>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Reclamation._);
    return const SchemaObject(
        ObjectType.realmObject, Reclamation, 'Reclamation', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('images', RealmPropertyType.string),
      SchemaProperty('problem', RealmPropertyType.string, optional: true),
      SchemaProperty('commentaire', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('color', RealmPropertyType.string, optional: true),
      SchemaProperty('isOpen', RealmPropertyType.bool, optional: true),
      SchemaProperty('date', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('imageconfirmed', RealmPropertyType.string,
          optional: true),
    ]);
  }
}
