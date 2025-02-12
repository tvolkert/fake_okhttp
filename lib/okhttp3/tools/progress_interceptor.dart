import 'package:fake_okhttp/okhttp3/interceptor.dart';

typedef void ProgressListener(
    String url, String method, int progressBytes, int totalBytes, bool isDone);

abstract class ProgressInterceptor extends Interceptor {}
