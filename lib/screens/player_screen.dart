import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../constants/app_theme.dart';
import '../models/channel.dart';
import '../services/stream_service.dart';

/// Full-screen video player with auto-hiding overlay header,
/// loading/error states, and stream reload support.
class PlayerScreen extends StatefulWidget {
  final Channel channel;

  const PlayerScreen({super.key, required this.channel});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  final StreamService _streamService = StreamService();

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _isLoading = true;
  String? _errorMessage;

  // ── Overlay auto-hide logic ──────────────────────────────────
  bool _showOverlay = true;
  Timer? _overlayTimer;
  late AnimationController _overlayAnimController;
  late Animation<double> _overlayOpacity;

  @override
  void initState() {
    super.initState();

    // Set up overlay fade animation
    _overlayAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _overlayOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _overlayAnimController, curve: Curves.easeInOut),
    );
    _overlayAnimController.value = 1.0; // Start visible

    _startOverlayTimer();
    _initStream();
  }

  @override
  void dispose() {
    _overlayTimer?.cancel();
    _overlayAnimController.dispose();
    _chewieController?.dispose();
    _videoController?.dispose();
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  // ── Stream Initialization ────────────────────────────────────

  Future<void> _initStream() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Dispose previous controllers if reloading
    _chewieController?.dispose();
    _videoController?.dispose();
    _chewieController = null;
    _videoController = null;

    try {
      final resolved = await _streamService.resolve(widget.channel);

      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(resolved.url),
        httpHeaders: resolved.headers,
      );

      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        showControls: true,
        allowFullScreen: true,
        allowMuting: true,
        errorBuilder: (context, errorMessage) {
          return _buildErrorState(errorMessage);
        },
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  // ── Overlay Timer Logic ──────────────────────────────────────

  void _startOverlayTimer() {
    _overlayTimer?.cancel();
    _overlayTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        _overlayAnimController.reverse();
        setState(() => _showOverlay = false);
      }
    });
  }

  void _handleScreenTap() {
    if (_showOverlay) {
      // Hide immediately
      _overlayTimer?.cancel();
      _overlayAnimController.reverse();
      setState(() => _showOverlay = false);
    } else {
      // Show and restart timer
      setState(() => _showOverlay = true);
      _overlayAnimController.forward();
      _startOverlayTimer();
    }
  }

  // ── Build Methods ────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: _handleScreenTap,
        child: Stack(
          children: [
            // Video / Loading / Error area
            _isLoading
                ? _buildLoadingState()
                : _errorMessage != null
                    ? _buildErrorState(_errorMessage!)
                    : _buildPlayer(),

            // ── Auto-hiding overlay header ─────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _overlayOpacity,
                child: _buildOverlayHeader(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 12,
        left: 4,
        right: 4,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.85),
            Colors.black.withValues(alpha: 0.4),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            tooltip: 'Back',
          ),

          // Channel name
          Expanded(
            child: Text(
              widget.channel.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

          // Reload button
          IconButton(
            onPressed: _initStream,
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            tooltip: 'Reload stream',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Loading stream...',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Fetching secure tokens mapping',
            style: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Stream Error',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: const Text(
                'Return to Directory',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _initStream,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Retry'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    if (_chewieController == null) {
      return _buildLoadingState();
    }

    return Center(
      child: AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio.isNaN ||
                _videoController!.value.aspectRatio == 0
            ? 16 / 9
            : _videoController!.value.aspectRatio,
        child: Chewie(controller: _chewieController!),
      ),
    );
  }
}
