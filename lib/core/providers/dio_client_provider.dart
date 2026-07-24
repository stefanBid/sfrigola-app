import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Network
import 'package:sfrigola/core/network/dio_client.dart';

part 'dio_client_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) => buildDioClient(ref);
