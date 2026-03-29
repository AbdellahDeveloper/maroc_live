import '../models/channel.dart';

/// All available categories for filtering.
const List<String> categories = [
  'All',
  'Arriadia Sports',
  '2M',
  'Arriadia HD',
  'Arriadia SAT',
  'Other',
];

/// The complete list of Moroccan TV channels.
const List<Channel> channels = [
  // ── Arriadia Sports ──────────────────────────────────────────
  Channel(
    name: 'Arriadia TNT (Player I)',
    type: 'with-headers',
    url: 'https://stream-lb.livemediama.com/arryadia-tnt/hls/master.m3u8',
    headers: {
      'Origin': 'https://livemediama.com',
      'Referer': 'https://livemediama.com/',
    },
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/a371aa94-d0e5-4a58-b9a5-a9e772e1b0e4.png',
    category: 'Arriadia Sports',
  ),
  Channel(
    name: 'Arriadia TNT (Player II)',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_arryadia-tnt_zcmwjdc/corp/73_arryadia-tnt_zcmwjdc_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_arryadia-tnt_zcmwjdc%2Fcorp%2F73_arryadia-tnt_zcmwjdc_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/a371aa94-d0e5-4a58-b9a5-a9e772e1b0e4.png',
    category: 'Arriadia Sports',
  ),

  // ── Arriadia HD ──────────────────────────────────────────────
  Channel(
    name: 'Arriadia HD 1',
    type: 'with-headers',
    url: 'https://stream-lb.livemediama.com/arryadia-hd-01/hls/master.m3u8',
    headers: {
      'Origin': 'https://livemediama.com',
      'Referer': 'https://livemediama.com/',
    },
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/a371aa94-d0e5-4a58-b9a5-a9e772e1b0e4.png',
    category: 'Arriadia HD',
  ),
  Channel(
    name: 'Arriadia HD 2',
    type: 'with-headers',
    url: 'https://stream-lb.livemediama.com/arryadia-hd-02/hls/master.m3u8',
    headers: {
      'Origin': 'https://livemediama.com',
      'Referer': 'https://livemediama.com/',
    },
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/a371aa94-d0e5-4a58-b9a5-a9e772e1b0e4.png',
    category: 'Arriadia HD',
  ),
  Channel(
    name: 'Arriadia HD 3',
    type: 'with-headers',
    url: 'https://stream-lb.livemediama.com/arryadia-hd-03/hls/master.m3u8',
    headers: {
      'Origin': 'https://livemediama.com',
      'Referer': 'https://livemediama.com/',
    },
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/a371aa94-d0e5-4a58-b9a5-a9e772e1b0e4.png',
    category: 'Arriadia HD',
  ),

  // ── Arriadia SAT ─────────────────────────────────────────────
  Channel(
    name: 'Arriadia SAT',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_arryadia_k2tgcj0/corp/73_arryadia_k2tgcj0_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_arryadia_k2tgcj0%2Fcorp%2F73_arryadia_k2tgcj0_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/a371aa94-d0e5-4a58-b9a5-a9e772e1b0e4.png',
    category: 'Arriadia SAT',
  ),

  // ── Other ────────────────────────────────────────────────────
  Channel(
    name: 'Télé-Maroc',
    type: 'tele-maroc',
    url: 'https://vr-eight-eta.vercel.app/live.m3u8',
    imageLink:
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhaNJhRK4ngpdLyU_2LipQ3SVGDRPO-kvvXqKJbx8Y9m2UAB5KWjqN1KPRyl9HokcrRsttgm3YCDRsm1VlCL6tkYUrCIC0tdkwSDmlL0QCuMV2FkdkO8CsGRuedNs6c43f6mwmr2uWhr9fW/s1600/%25D8%25AA%25D8%25B1%25D8%25AF%25D8%25AF+%25D9%2582%25D9%2586%25D8%25A7%25D8%25A9+t%25C3%25A9l%25C3%25A9+maroc+ALT.png',
    category: 'Other',
  ),
  Channel(
    name: 'Laayoune',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_laayoune_pgagr52/corp/73_laayoune_pgagr52_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_laayoune_pgagr52%2Fcorp%2F73_laayoune_pgagr52_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/71efd4f0-67bc-4b41-a15d-fc0021b08bf8.png',
    category: 'Other',
  ),
  Channel(
    name: 'Maghribia',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_almaghribia_83tz85q/corp/73_almaghribia_83tz85q_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_almaghribia_83tz85q%2Fcorp%2F73_almaghribia_83tz85q_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/cbfa1eb4-a1b9-4f46-b959-9f46e2857380.png',
    category: 'Other',
  ),
  Channel(
    name: 'Al Aoula',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_aloula_w1dqfwm/corp/73_aloula_w1dqfwm_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_aloula_w1dqfwm%2Fcorp%2F73_aloula_w1dqfwm_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/735c63ba-fe1d-4687-acb1-cb02f48b514e.png',
    category: 'Other',
  ),
  Channel(
    name: 'Medi1TV',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/83_medi1tv-arabic_g90v4ec/playlist_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F83_medi1tv-arabic_g90v4ec%2Fplaylist_dvr.m3u8',
    imageLink: 'https://www.medi1tv.com/assets/imgs/medi1_circule_ar.png',
    category: 'Other',
  ),
  Channel(
    name: '2M Live (Player I)',
    type: 'with-headers',
    url:
        'https://cdn-globecast.akamaized.net/live/eds/2m_monde/hls_video_ts_tuhawxpiemz257adfc/2m_monde.m3u8',
    headers: {'Referer': 'https://2m.ma'},
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/2/29/2M_TV_logo.svg',
    category: '2M',
  ),
  Channel(
    name: '2M Live (Player II)',
    type: 'with-headers',
    url: 'https://maonline.xyz:8443/hls/test.m3u8',
    headers: {'Origin': 'https://foutni.com', 'Referer': 'https://foutni.com/'},
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/2/29/2M_TV_logo.svg',
    category: '2M',
  ),
  Channel(
    name: 'Al Takafia',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_arrabia_hthcj4p/corp/73_arrabia_hthcj4p_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_arrabia_hthcj4p%2Fcorp%2F73_arrabia_hthcj4p_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/eb8856ce-89f5-40f4-997b-d499fb5a1df8.png',
    category: 'Other',
  ),
  Channel(
    name: 'Chada TV',
    type: 'normal',
    url:
        'https://edge14.vedge.infomaniak.com/livecast/ik:chadatv/playlist.m3u8',
    headers: {'Origin': 'https://chada.ma', 'Referer': 'https://chada.ma/'},
    imageLink:
        'https://chada.ma/wp-content/uploads/2022/09/cropped-LOGO-CHADA-NEW-1.png',
    category: 'Other',
  ),
  Channel(
    name: 'Asadissa',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_assadissa_7b7u5n1/corp/73_assadissa_7b7u5n1_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_assadissa_7b7u5n1%2Fcorp%2F73_assadissa_7b7u5n1_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/d4257b2c-6e26-4d27-b320-ef1195cc1f92.png',
    category: 'Other',
  ),
  Channel(
    name: 'Tamazight',
    type: 'laayone-compatible',
    url:
        'https://cdn.live.easybroadcast.io/abr_corp/73_tamazight_tccybxt/corp/73_tamazight_tccybxt_480p/chunks_dvr.m3u8',
    tokenGenLink:
        'https://token.easybroadcast.io/all?url=https%3A%2F%2Fcdn.live.easybroadcast.io%2Fabr_corp%2F73_tamazight_tccybxt%2Fcorp%2F73_tamazight_tccybxt_480p%2Fchunks_dvr.m3u8',
    imageLink:
        'https://snrtlive.atlashoster.net/uploads/channels/fr/201867eb-61c7-4e5e-9eef-952d26609b8e.png',
    category: 'Other',
  ),
];
