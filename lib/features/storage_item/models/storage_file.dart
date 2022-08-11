import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_file.freezed.dart';
part 'storage_file.g.dart';

@Freezed()
class StorageFile with _$StorageFile {
  const factory StorageFile({
    required String key,
    required String url,
  }) = _StorageFile;

  factory StorageFile.fromJson(Map<String, dynamic> json) =>
      _$StorageFileFromJson(json);
}
