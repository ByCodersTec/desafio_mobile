// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserLocalizationData extends DataClass
    implements Insertable<UserLocalizationData> {
  final int? id;
  final String uid;
  final String email;
  final String latitude;
  final String longitude;
  UserLocalizationData(
      {this.id,
      required this.uid,
      required this.email,
      required this.latitude,
      required this.longitude});
  factory UserLocalizationData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserLocalizationData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      uid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uid'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      latitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude'])!,
      longitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['uid'] = Variable<String>(uid);
    map['email'] = Variable<String>(email);
    map['latitude'] = Variable<String>(latitude);
    map['longitude'] = Variable<String>(longitude);
    return map;
  }

  UserLocalizationCompanion toCompanion(bool nullToAbsent) {
    return UserLocalizationCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      uid: Value(uid),
      email: Value(email),
      latitude: Value(latitude),
      longitude: Value(longitude),
    );
  }

  factory UserLocalizationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserLocalizationData(
      id: serializer.fromJson<int?>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String>(json['email']),
      latitude: serializer.fromJson<String>(json['latitude']),
      longitude: serializer.fromJson<String>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String>(email),
      'latitude': serializer.toJson<String>(latitude),
      'longitude': serializer.toJson<String>(longitude),
    };
  }

  UserLocalizationData copyWith(
          {int? id,
          String? uid,
          String? email,
          String? latitude,
          String? longitude}) =>
      UserLocalizationData(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        email: email ?? this.email,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  @override
  String toString() {
    return (StringBuffer('UserLocalizationData(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, email, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLocalizationData &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.email == this.email &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class UserLocalizationCompanion extends UpdateCompanion<UserLocalizationData> {
  final Value<int?> id;
  final Value<String> uid;
  final Value<String> email;
  final Value<String> latitude;
  final Value<String> longitude;
  const UserLocalizationCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  UserLocalizationCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required String email,
    required String latitude,
    required String longitude,
  })  : uid = Value(uid),
        email = Value(email),
        latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<UserLocalizationData> custom({
    Expression<int?>? id,
    Expression<String>? uid,
    Expression<String>? email,
    Expression<String>? latitude,
    Expression<String>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  UserLocalizationCompanion copyWith(
      {Value<int?>? id,
      Value<String>? uid,
      Value<String>? email,
      Value<String>? latitude,
      Value<String>? longitude}) {
    return UserLocalizationCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLocalizationCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $UserLocalizationTable extends UserLocalization
    with TableInfo<$UserLocalizationTable, UserLocalizationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLocalizationTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String?> uid = GeneratedColumn<String?>(
      'uid', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<String?> latitude = GeneratedColumn<String?>(
      'latitude', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<String?> longitude = GeneratedColumn<String?>(
      'longitude', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, uid, email, latitude, longitude];
  @override
  String get aliasedName => _alias ?? 'user_localization';
  @override
  String get actualTableName => 'user_localization';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserLocalizationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserLocalizationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserLocalizationData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserLocalizationTable createAlias(String alias) {
    return $UserLocalizationTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserLocalizationTable userLocalization =
      $UserLocalizationTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userLocalization];
}
