import 'package:dio/dio.dart';

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
}

