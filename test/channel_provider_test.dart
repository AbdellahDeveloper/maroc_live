import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maroc_live/providers/channel_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('ChannelProvider parses inline M3U URLs correctly', () async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    const m3uData = '''
#EXTM3U
#EXTINF:0,BEIN MAX 1 **
https://live.aab1.top:443/odai/123321/9087.ts
#EXTINF:0,BEIN SPORTS 1 https://live.aab1.top:443/odai/123321/3.ts
#EXTINF:0,BEIN SPORTS 2
https://live.aab1.top:443/odai/123321/6820.ts
''';

    // Mock the asset loading for world_cup_matches.m3u
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          // Return the m3uData when requested
          return ByteData.sublistView(Uint8List.fromList(m3uData.codeUnits));
        });

    final provider = ChannelProvider();

    // Wait for the async channel loading to complete
    while (provider.isLoading) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    final worldCupChannels = provider.filteredChannels
        .where((c) => c.category == 'Bein Sports')
        .toList();

    expect(worldCupChannels.length, 3);

    expect(worldCupChannels[0].name, 'BEIN MAX 1 **');
    expect(
      worldCupChannels[0].url,
      'https://live.aab1.top:443/odai/123321/9087.ts',
    );

    expect(worldCupChannels[1].name, 'BEIN SPORTS 1');
    expect(
      worldCupChannels[1].url,
      'https://live.aab1.top:443/odai/123321/3.ts',
    );

    expect(worldCupChannels[2].name, 'BEIN SPORTS 2');
    expect(
      worldCupChannels[2].url,
      'https://live.aab1.top:443/odai/123321/6820.ts',
    );
  });
}
