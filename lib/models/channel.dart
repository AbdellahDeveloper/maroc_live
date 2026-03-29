/// Represents a TV channel in the Maroc Live directory.
///
/// Each channel has a [type] that determines how its stream URL
/// should be resolved before playback.
class Channel {
  final String name;
  final String type; // 'normal', 'with-headers', 'laayone-compatible', 'tele-maroc'
  final String url;
  final Map<String, String> headers;
  final String tokenGenLink;
  final String imageLink;
  final String category;

  const Channel({
    required this.name,
    required this.type,
    required this.url,
    this.headers = const {},
    this.tokenGenLink = '',
    this.imageLink = '',
    this.category = 'Other',
  });
}
