class HttpUrl {
  static const String SCHEME_HTTP = 'http';
  static const String SCHEME_HTTPS = 'https';

  final Uri _uri;

  HttpUrl._(HttpUrlBuilder builder) : _uri = builder._uri;

  String scheme() {
    return _uri.scheme;
  }

  bool isHttps() {
    return _uri.isScheme(SCHEME_HTTPS);
  }

  String host() {
    return _uri.host;
  }

  int port() {
    return _uri.port;
  }

  String userInfo() {
    return _uri.userInfo;
  }

  String path() {
    return _uri.path;
  }

  List<String> pathSegments() {
    return _uri.pathSegments;
  }

  String query() {
    return _uri.query;
  }

  String queryParameter(String name) {
    List<String> values = _uri.queryParametersAll[name];
    return values != null ? values.first : null;
  }

  Set<String> queryParameterNames() {
    return Set.from(_uri.queryParametersAll.keys);
  }

  List<String> queryParameterValues(String name) {
    return _uri.queryParametersAll[name];
  }

  Map<String, List<String>> queryParametersAll() {
    return _uri.queryParametersAll;
  }

  HttpUrlBuilder newBuilder() {
    return new HttpUrlBuilder._(this);
  }

  Uri uri() {
    return _uri;
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }
    return other is HttpUrl &&
        runtimeType == other.runtimeType &&
        _uri == other._uri;
  }

  @override
  int get hashCode {
    return _uri.hashCode;
  }

  @override
  String toString() {
    return _uri.toString();
  }

  static HttpUrl parse(String url) {
    HttpUrlBuilder builder = new HttpUrlBuilder();
    builder._uri = Uri.parse(url);
    return builder.build();
  }

  static HttpUrl from(Uri uri) {
    HttpUrlBuilder builder = new HttpUrlBuilder();
    builder._uri = uri;
    return builder.build();
  }

  static int defaultPort(String scheme) {
    if (scheme == SCHEME_HTTP) {
      return 80;
    } else if (scheme == SCHEME_HTTPS) {
      return 443;
    } else {
      return -1;
    }
  }
}

class HttpUrlBuilder {
  Uri _uri;

  HttpUrlBuilder();

  HttpUrlBuilder._(HttpUrl url) : _uri = url._uri;

  HttpUrlBuilder scheme(String scheme) {
    _uri = _uri.replace(scheme: scheme);
    return this;
  }

  HttpUrlBuilder userInfo(String userInfo) {
    _uri = _uri.replace(userInfo: userInfo);
    return this;
  }

  HttpUrlBuilder host(String host) {
    _uri = _uri.replace(host: host);
    return this;
  }

  HttpUrlBuilder port(int port) {
    _uri = _uri.replace(port: port);
    return this;
  }

  HttpUrlBuilder addPathSegment(String pathSegment) {
    List<String> pathSegments = List.from(_uri.pathSegments);
    pathSegments.add(pathSegment);
    _uri = _uri.replace(pathSegments: pathSegments);
    return this;
  }

  HttpUrlBuilder addQueryParameter(String name, String value) {
    Map<String, List<String>> queryParametersAll =
        Map.from(_uri.queryParametersAll);
    List<String> values = queryParametersAll[name];
    if (values == null) {
      values = [];
      queryParametersAll.putIfAbsent(name, () => values);
    }
    values.add(value);
    _uri = _uri.replace(queryParameters: queryParametersAll);
    return this;
  }

  HttpUrlBuilder removeAllQueryParameters(String name) {
    Map<String, List<String>> queryParametersAll =
        Map.from(_uri.queryParametersAll);
    queryParametersAll.remove(name);
    _uri = _uri.replace(queryParameters: queryParametersAll);
    return this;
  }

  HttpUrlBuilder setQueryParameter(String name, String value) {
    removeAllQueryParameters(name);
    addQueryParameter(name, value);
    return this;
  }

  HttpUrlBuilder fragment(String fragment) {
    _uri = _uri.replace(fragment: fragment);
    return this;
  }

  HttpUrl build() {
    return new HttpUrl._(this);
  }
}