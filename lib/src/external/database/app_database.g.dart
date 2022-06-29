// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserData extends DataClass implements Insertable<UserData> {
  final String uid;
  final String email;
  UserData({required this.uid, required this.email});
  factory UserData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserData(
      uid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uid'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['email'] = Variable<String>(email);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      uid: Value(uid),
      email: Value(email),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserData(
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String>(email),
    };
  }

  UserData copyWith({String? uid, String? email}) => UserData(
        uid: uid ?? this.uid,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('uid: $uid, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData && other.uid == this.uid && other.email == this.email);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<String> uid;
  final Value<String> email;
  const UserCompanion({
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
  });
  UserCompanion.insert({
    required String uid,
    required String email,
  })  : uid = Value(uid),
        email = Value(email);
  static Insertable<UserData> custom({
    Expression<String>? uid,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
    });
  }

  UserCompanion copyWith({Value<String>? uid, Value<String>? email}) {
    return UserCompanion(
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('uid: $uid, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String?> uid = GeneratedColumn<String?>(
      'uid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uid, email];
  @override
  String get aliasedName => _alias ?? 'user';
  @override
  String get actualTableName => 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class LocalizationData extends DataClass
    implements Insertable<LocalizationData> {
  final int? id;
  final String latitude;
  final String longitude;
  final String uidUser;
  LocalizationData(
      {this.id,
      required this.latitude,
      required this.longitude,
      required this.uidUser});
  factory LocalizationData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalizationData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      latitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude'])!,
      longitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude'])!,
      uidUser: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uid_user'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['latitude'] = Variable<String>(latitude);
    map['longitude'] = Variable<String>(longitude);
    map['uid_user'] = Variable<String>(uidUser);
    return map;
  }

  LocalizationCompanion toCompanion(bool nullToAbsent) {
    return LocalizationCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      latitude: Value(latitude),
      longitude: Value(longitude),
      uidUser: Value(uidUser),
    );
  }

  factory LocalizationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalizationData(
      id: serializer.fromJson<int?>(json['id']),
      latitude: serializer.fromJson<String>(json['latitude']),
      longitude: serializer.fromJson<String>(json['longitude']),
      uidUser: serializer.fromJson<String>(json['uidUser']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'latitude': serializer.toJson<String>(latitude),
      'longitude': serializer.toJson<String>(longitude),
      'uidUser': serializer.toJson<String>(uidUser),
    };
  }

  LocalizationData copyWith(
          {int? id, String? latitude, String? longitude, String? uidUser}) =>
      LocalizationData(
        id: id ?? this.id,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        uidUser: uidUser ?? this.uidUser,
      );
  @override
  String toString() {
    return (StringBuffer('LocalizationData(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('uidUser: $uidUser')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, latitude, longitude, uidUser);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizationData &&
          other.id == this.id &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.uidUser == this.uidUser);
}

class LocalizationCompanion extends UpdateCompanion<LocalizationData> {
  final Value<int?> id;
  final Value<String> latitude;
  final Value<String> longitude;
  final Value<String> uidUser;
  const LocalizationCompanion({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.uidUser = const Value.absent(),
  });
  LocalizationCompanion.insert({
    this.id = const Value.absent(),
    required String latitude,
    required String longitude,
    required String uidUser,
  })  : latitude = Value(latitude),
        longitude = Value(longitude),
        uidUser = Value(uidUser);
  static Insertable<LocalizationData> custom({
    Expression<int?>? id,
    Expression<String>? latitude,
    Expression<String>? longitude,
    Expression<String>? uidUser,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (uidUser != null) 'uid_user': uidUser,
    });
  }

  LocalizationCompanion copyWith(
      {Value<int?>? id,
      Value<String>? latitude,
      Value<String>? longitude,
      Value<String>? uidUser}) {
    return LocalizationCompanion(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      uidUser: uidUser ?? this.uidUser,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String>(longitude.value);
    }
    if (uidUser.present) {
      map['uid_user'] = Variable<String>(uidUser.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizationCompanion(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('uidUser: $uidUser')
          ..write(')'))
        .toString();
  }
}

class $LocalizationTable extends Localization
    with TableInfo<$LocalizationTable, LocalizationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizationTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
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
  final VerificationMeta _uidUserMeta = const VerificationMeta('uidUser');
  @override
  late final GeneratedColumn<String?> uidUser = GeneratedColumn<String?>(
      'uid_user', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, latitude, longitude, uidUser];
  @override
  String get aliasedName => _alias ?? 'localization';
  @override
  String get actualTableName => 'localization';
  @override
  VerificationContext validateIntegrity(Insertable<LocalizationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('uid_user')) {
      context.handle(_uidUserMeta,
          uidUser.isAcceptableOrUnknown(data['uid_user']!, _uidUserMeta));
    } else if (isInserting) {
      context.missing(_uidUserMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalizationData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalizationTable createAlias(String alias) {
    return $LocalizationTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserTable user = $UserTable(this);
  late final $LocalizationTable localization = $LocalizationTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [user, localization];
}
