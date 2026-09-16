import 'package:dio/dio.dart';
import 'package:instagram_clone/core/storage/secure_token_storage.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dnjndajnhincyjrwdiqb.supabase.co',
      headers: {
        'apikey': 'sb_publishable_QueY0ZPN1k1QBbohEHT4EQ_QG6mlGIK',
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = SecureTokenStorage();
          final accessToken = await storage.getAccessToken();

          if (accessToken != null) {
            options.headers['Authorization'] =
                'Bearer $accessToken';
          }

          handler.next(options);
        },
      ),
    );
}

