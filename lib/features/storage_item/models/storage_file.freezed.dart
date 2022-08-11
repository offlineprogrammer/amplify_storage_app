// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'storage_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StorageFile _$StorageFileFromJson(Map<String, dynamic> json) {
  return _StorageFile.fromJson(json);
}

/// @nodoc
mixin _$StorageFile {
  String get key => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StorageFileCopyWith<StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageFileCopyWith<$Res> {
  factory $StorageFileCopyWith(
          StorageFile value, $Res Function(StorageFile) then) =
      _$StorageFileCopyWithImpl<$Res>;
  $Res call({String key, String url});
}

/// @nodoc
class _$StorageFileCopyWithImpl<$Res> implements $StorageFileCopyWith<$Res> {
  _$StorageFileCopyWithImpl(this._value, this._then);

  final StorageFile _value;
  // ignore: unused_field
  final $Res Function(StorageFile) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_StorageFileCopyWith<$Res>
    implements $StorageFileCopyWith<$Res> {
  factory _$$_StorageFileCopyWith(
          _$_StorageFile value, $Res Function(_$_StorageFile) then) =
      __$$_StorageFileCopyWithImpl<$Res>;
  @override
  $Res call({String key, String url});
}

/// @nodoc
class __$$_StorageFileCopyWithImpl<$Res> extends _$StorageFileCopyWithImpl<$Res>
    implements _$$_StorageFileCopyWith<$Res> {
  __$$_StorageFileCopyWithImpl(
      _$_StorageFile _value, $Res Function(_$_StorageFile) _then)
      : super(_value, (v) => _then(v as _$_StorageFile));

  @override
  _$_StorageFile get _value => super._value as _$_StorageFile;

  @override
  $Res call({
    Object? key = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_StorageFile(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StorageFile implements _StorageFile {
  const _$_StorageFile({required this.key, required this.url});

  factory _$_StorageFile.fromJson(Map<String, dynamic> json) =>
      _$$_StorageFileFromJson(json);

  @override
  final String key;
  @override
  final String url;

  @override
  String toString() {
    return 'StorageFile(key: $key, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StorageFile &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$$_StorageFileCopyWith<_$_StorageFile> get copyWith =>
      __$$_StorageFileCopyWithImpl<_$_StorageFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StorageFileToJson(
      this,
    );
  }
}

abstract class _StorageFile implements StorageFile {
  const factory _StorageFile(
      {required final String key, required final String url}) = _$_StorageFile;

  factory _StorageFile.fromJson(Map<String, dynamic> json) =
      _$_StorageFile.fromJson;

  @override
  String get key;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_StorageFileCopyWith<_$_StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}
