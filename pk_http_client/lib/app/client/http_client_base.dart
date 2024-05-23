abstract class HttpClientBase {
  Future get(String endpoint);
  Future post(String endpoint, Map<String, dynamic> data);
  Future put(String endpoint, Map<String, dynamic> data);
  Future patch(String endpoint, Map<String, dynamic> data);
  Future delete(String endpoint);
}
