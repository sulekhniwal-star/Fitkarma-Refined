import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Media type for accessibility descriptions
enum MediaType { workoutVideo, exerciseDemo, guidedSession, tutorial }

/// Audio track type for accessibility
enum AudioTrackType {
  original,
  descriptive, // Audio description for visually impaired
  dubbed, // Alternative language dubbing
  commentary, // Instructor commentary
}

/// Represents an audio track available for media
class AudioTrack {
  final String id;
  final String name;
  final String languageCode;
  final AudioTrackType type;
  final String? url;
  final bool isDefault;

  const AudioTrack({
    required this.id,
    required this.name,
    required this.languageCode,
    required this.type,
    this.url,
    this.isDefault = false,
  });
}

/// Workout media with accessibility support
class AccessibleWorkoutMedia {
  final String id;
  final String title;
  final String description;
  final MediaType mediaType;
  final Duration duration;
  final String thumbnailUrl;
  final String videoUrl;
  final List<AudioTrack> audioTracks;
  final String? transcript;
  final List<SubtitleTrack> subtitles;

  const AccessibleWorkoutMedia({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaType,
    required this.duration,
    required this.thumbnailUrl,
    required this.videoUrl,
    this.audioTracks = const [],
    this.transcript,
    this.subtitles = const [],
  });

  /// Get the default audio description track if available
  AudioTrack? get descriptiveAudioTrack {
    try {
      return audioTracks.firstWhere(
        (track) => track.type == AudioTrackType.descriptive,
      );
    } catch (_) {
      return null;
    }
  }

  /// Check if audio descriptions are available
  bool get hasAudioDescription => descriptiveAudioTrack != null;
}

/// Subtitle track for media
class SubtitleTrack {
  final String id;
  final String name;
  final String languageCode;
  final String url;
  final bool isDefault;

  const SubtitleTrack({
    required this.id,
    required this.name,
    required this.languageCode,
    required this.url,
    this.isDefault = false,
  });
}

/// Media accessibility settings state
class MediaAccessibilitySettings {
  final bool enableAudioDescriptions;
  final bool enableSubtitles;
  final bool enableClosedCaptions;
  final String preferredLanguage;
  final double playbackSpeed;
  final bool autoPlayNext;

  const MediaAccessibilitySettings({
    this.enableAudioDescriptions = false,
    this.enableSubtitles = false,
    this.enableClosedCaptions = false,
    this.preferredLanguage = 'en',
    this.playbackSpeed = 1.0,
    this.autoPlayNext = true,
  });

  MediaAccessibilitySettings copyWith({
    bool? enableAudioDescriptions,
    bool? enableSubtitles,
    bool? enableClosedCaptions,
    String? preferredLanguage,
    double? playbackSpeed,
    bool? autoPlayNext,
  }) {
    return MediaAccessibilitySettings(
      enableAudioDescriptions:
          enableAudioDescriptions ?? this.enableAudioDescriptions,
      enableSubtitles: enableSubtitles ?? this.enableSubtitles,
      enableClosedCaptions: enableClosedCaptions ?? this.enableClosedCaptions,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      autoPlayNext: autoPlayNext ?? this.autoPlayNext,
    );
  }
}

/// Media accessibility settings notifier
class MediaAccessibilityNotifier extends Notifier<MediaAccessibilitySettings> {
  @override
  MediaAccessibilitySettings build() {
    return const MediaAccessibilitySettings();
  }

  void setEnableAudioDescriptions(bool enabled) {
    state = state.copyWith(enableAudioDescriptions: enabled);
  }

  void setEnableSubtitles(bool enabled) {
    state = state.copyWith(enableSubtitles: enabled);
  }

  void setEnableClosedCaptions(bool enabled) {
    state = state.copyWith(enableClosedCaptions: enabled);
  }

  void setPreferredLanguage(String languageCode) {
    state = state.copyWith(preferredLanguage: languageCode);
  }

  void setPlaybackSpeed(double speed) {
    state = state.copyWith(playbackSpeed: speed.clamp(0.5, 2.0));
  }

  void setAutoPlayNext(bool enabled) {
    state = state.copyWith(autoPlayNext: enabled);
  }
}

/// Provider for media accessibility settings
final mediaAccessibilityProvider =
    NotifierProvider<MediaAccessibilityNotifier, MediaAccessibilitySettings>(
      MediaAccessibilityNotifier.new,
    );

/// Provider for checking if audio descriptions are enabled
final isAudioDescriptionEnabledProvider = Provider<bool>((ref) {
  return ref.watch(mediaAccessibilityProvider).enableAudioDescriptions;
});

/// Provider for checking if subtitles are enabled
final isSubtitlesEnabledProvider = Provider<bool>((ref) {
  return ref.watch(mediaAccessibilityProvider).enableSubtitles;
});

/// Sample workout media data with accessibility features
/// In production, this would come from an API
class SampleWorkoutMedia {
  static List<AccessibleWorkoutMedia> getSamples() {
    return [
      AccessibleWorkoutMedia(
        id: 'morning-yoga-1',
        title: 'Morning Yoga Flow',
        description:
            'A gentle 20-minute yoga sequence to start your day. This workout includes audio descriptions for visually impaired users.',
        mediaType: MediaType.workoutVideo,
        duration: const Duration(minutes: 20),
        thumbnailUrl: 'https://example.com/yoga-thumb.jpg',
        videoUrl: 'https://example.com/yoga-video.mp4',
        audioTracks: [
          const AudioTrack(
            id: 'en-original',
            name: 'English - Original',
            languageCode: 'en',
            type: AudioTrackType.original,
            isDefault: true,
          ),
          const AudioTrack(
            id: 'en-descriptive',
            name: 'English - Audio Described',
            languageCode: 'en',
            type: AudioTrackType.descriptive,
            url: 'https://example.com/yoga-audio-desc.mp3',
          ),
          const AudioTrack(
            id: 'hi-dubbed',
            name: 'Hindi - Dubbed',
            languageCode: 'hi',
            type: AudioTrackType.dubbed,
            url: 'https://example.com/yoga-hindi.mp3',
          ),
        ],
        transcript:
            '''Welcome to your morning yoga flow. Today we'll be practicing a gentle sequence to awaken your body and mind.

Let's begin in Mountain Pose. Stand tall with feet together, arms at your sides. Breathe deeply and ground yourself.

Now, inhale and raise your arms overhead. Exhale and fold forward, letting your head hang heavy. Bend your knees if needed.

Continue to the next pose - Downward-Facing Dog. Press your hands into the mat and lift your hips high...

(This transcript continues with detailed instructions for each pose)''',
        subtitles: const [
          SubtitleTrack(
            id: 'en-subtitles',
            name: 'English',
            languageCode: 'en',
            url: 'https://example.com/yoga-en.vtt',
            isDefault: true,
          ),
          SubtitleTrack(
            id: 'hi-subtitles',
            name: 'Hindi',
            languageCode: 'hi',
            url: 'https://example.com/yoga-hi.vtt',
          ),
        ],
      ),
      AccessibleWorkoutMedia(
        id: 'hiit-cardio-1',
        title: 'HIIT Cardio Blast',
        description:
            'High-intensity interval training workout. Includes audio descriptions describing all movements for accessibility.',
        mediaType: MediaType.workoutVideo,
        duration: const Duration(minutes: 30),
        thumbnailUrl: 'https://example.com/hiit-thumb.jpg',
        videoUrl: 'https://example.com/hiit-video.mp4',
        audioTracks: [
          const AudioTrack(
            id: 'en-original',
            name: 'English - Original',
            languageCode: 'en',
            type: AudioTrackType.original,
            isDefault: true,
          ),
          const AudioTrack(
            id: 'en-descriptive',
            name: 'English - Audio Described',
            languageCode: 'en',
            type: AudioTrackType.descriptive,
            url: 'https://example.com/hiit-audio-desc.mp3',
          ),
        ],
        transcript: '''Get ready for an intense 30-minute HIIT workout!

We're starting with a 5-minute warm-up. March in place, lifting your knees high. Swing your arms to get your blood flowing.

Now the first interval - Jumping Jacks! Jump your feet out while raising your arms overhead. Keep a strong core engaged.

Rest for 30 seconds, then burpees! Start in a standing position, drop into a squat, kick your feet back, do a push-up, return to squat, and jump up...

(The transcript continues with detailed exercise instructions)''',
        subtitles: const [
          SubtitleTrack(
            id: 'en-subtitles',
            name: 'English',
            languageCode: 'en',
            url: 'https://example.com/hiit-en.vtt',
            isDefault: true,
          ),
        ],
      ),
    ];
  }
}
