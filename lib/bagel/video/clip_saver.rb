module Bagel::Video
  class ClipSaver
    private attr_reader :clip

    def initialize(clip)
      @clip = clip
    end

    def save
      FFMPEG.trim(
        source: Bagel.config.source_video,
        start: clip.start,
        duration: clip.duration,
        destination: clip.trim_path
      )

      FFMPEG.filter(
        inputs: inputs,
        filters: filters,
        destination: clip.clip_path
      )
    end

    private

    def inputs
      [ clip.trim_path ] + clip.overlays.map(&:asset)
    end

    def filters
      fade_filter_clip + fade_filters_overlay + overlay_filters
    end

    def fade_filter_clip
      clip.fade ? [ FFMPEG::FadeFilter.for_clip(clip.fade) ] : []
    end

    def fade_filters_overlay
      clip.overlays.map.with_index do |overlay, index|
        next unless overlay.fade
        FFMPEG::FadeFilter.for_overlay(overlay.fade, index)
      end.compact
    end

    def overlay_filters
      clip.overlays.map.with_index do |overlay, index|
        is_last = index == clip.overlays.count - 1

        FFMPEG::OverlayFilter.new(
          fade: overlay.fade,
          padding: overlay.padding,
          orientation: overlay.orientation,
          index: index,
          is_last: is_last
        ).to_s
      end
    end
  end
end
