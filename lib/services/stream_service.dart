import 'package:http/http.dart' as http;
import '../models/channel.dart';

/// Holds the resolved stream URL and any required HTTP headers.
class ResolvedStream {
  final String url;
  final Map<String, String> headers;

  const ResolvedStream({required this.url, this.headers = const {}});
}

/// Resolves the final playable stream URL based on the channel type.
///
/// - **laayone-compatible**: Fetches a token from [channel.tokenGenLink] and
///   appends it to the base URL.
/// - **tele-maroc**: Returns the URL as-is (the player handles 302 redirects).
/// - **with-headers** / **normal**: Returns the URL with any required headers.
class StreamService {
  /// Resolves [channel] into a [ResolvedStream] ready for the video player.
  Future<ResolvedStream> resolve(Channel channel) async {
    switch (channel.type) {
      case 'laayone-compatible':
        return _resolveLaayone(channel);
      case 'tele-maroc':
        return ResolvedStream(url: channel.url);
      case 'with-headers':
        return ResolvedStream(url: channel.url, headers: channel.headers);
      case 'normal':
        return ResolvedStream(url: channel.url);
      default:
        return ResolvedStream(url: channel.url);
    }
  }

  /// Fetches a token and builds the final URL for laayone-compatible channels.
  Future<ResolvedStream> _resolveLaayone(Channel channel) async {
    final response = await http.get(Uri.parse(channel.tokenGenLink));

    if (response.statusCode != 200) {
      throw Exception(
        'Token fetch failed (${response.statusCode}): ${response.body}',
      );
    }

    String token = response.body.trim();

    // If the token doesn't contain '=', prepend 'token='
    if (!token.contains('=')) {
      token = 'token=$token';
    }

    // Append token to the base URL, handling existing query parameters
    final separator = channel.url.contains('?') ? '&' : '?';
    final resolvedUrl = '${channel.url}$separator$token';

    return ResolvedStream(url: resolvedUrl, headers: channel.headers);
  }
}
