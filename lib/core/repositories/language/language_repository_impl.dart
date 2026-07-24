import 'package:dio/dio.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_general_response.dart';
import 'package:sfrigola/core/models/language.dart';

// Project Network
import 'package:sfrigola/core/utils/be_mapper.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/language/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final Dio _dio;
  const LanguageRepositoryImpl(this._dio);

  @override
  Future<List<Language>> getLanguages({bool? isActive}) async {
    final response = await _dio.get(
      '/languages',
      queryParameters: {'isActive': ?isActive},
    );

    final parsed = BeGeneralResponse<List<Language>, void>.fromJson(
      response.data as Map<String, dynamic>,
      (raw) => (raw as List)
          .map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return BeMapper.mapBeResponse(parsed);
  }
}
