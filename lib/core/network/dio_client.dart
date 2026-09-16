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
  );

  static final Dio refreshDio = Dio(
    BaseOptions(
      baseUrl: 'https://dnjndajnhincyjrwdiqb.supabase.co',
      headers: {
        'apikey': 'sb_publishable_QueY0ZPN1k1QBbohEHT4EQ_QG6mlGIK',
        'Content-Type': 'application/json',
      },
    ),
  );

  static void setupInterceptors() {
    dio.interceptors.add(
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

        onError: (error, handler) async {
          if (error.response?.statusCode != 401) {
            handler.next(error);
            return;
          }

          final storage = SecureTokenStorage();
          final refreshToken = await storage.getRefreshToken();

          if (refreshToken == null) {
            handler.next(error);
            return;
          }

          try {
            final response = await refreshDio.post(
              '/auth/v1/token?grant_type=refresh_token',
              data: {
                'refresh_token': refreshToken,
              },
            );

            final newAccessToken =
                response.data['access_token'];

            final newRefreshToken =
                response.data['refresh_token'];

            await storage.saveTokens(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken,
            );

            final request = error.requestOptions;

            request.headers['Authorization'] =
                'Bearer $newAccessToken';

            final retryResponse = await dio.fetch(request);

            handler.resolve(retryResponse);
          } catch (e) {
            await storage.clearTokens();
            handler.next(error);
          }
        },
      ),
    );
  }
}

