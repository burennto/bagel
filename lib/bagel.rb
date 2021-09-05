# frozen_string_literal: true

require 'fileutils'
require 'forwardable'
require 'ostruct'
require 'tempfile'
require 'yaml'
require 'rmagick'
include Magick

require 'bagel/version'
require 'bagel/colors'
require 'bagel/fonts'

require 'bagel/video'
require 'bagel/graphic'
require 'bagel/tennis'
require 'bagel/timeframe'

include Bagel
include Bagel::Graphic
include Bagel::Tennis
include Bagel::Tennis::Stats
include Bagel::Video
include Bagel::Video::ClipBuilders
include Bagel::Video::FFMPEG

module Bagel
  TMP_DIR = 'tmp'
  GRAPHIC_DIR = 'graphics'
  TRIM_DIR = 'trims'
  CLIP_DIR = 'clips'

  def self.config
    @config ||= OpenStruct.new
  end

  def self.configure
    yield(config)
    check_values
    set_default_values
    init_directories
  end

  def self.check_values
    raise 'source_video does not exist' unless File.exist?(config.source_video.to_s)
    raise 'score_sheet does not exist' unless File.exist?(config.clip_data.to_s)
  end

  def self.set_default_values
    @config.show_scores = true if config.show_scores.nil?
    @config.show_second_serve_indicator = true if config.show_second_serve_indicator.nil?
  end

  def init_directories
    @config.tmp_dir = File.join(TMP_DIR, @config.name)
    @config.graphic_dir = File.join(@config.tmp_dir, GRAPHIC_DIR)
    @config.trim_dir = File.join(@config.tmp_dir, TRIM_DIR)
    @config.clip_dir = File.join(@config.tmp_dir, CLIP_DIR)

    [
      @config.graphic_dir,
      @config.trim_dir,
      @config.clip_dir
    ].each do |path|
      FileUtils.rm_rf(path, secure: true)
      FileUtils.mkdir_p(path)
    end
  end

  def self.make_video
    data = Bagel.config.clip_data
    clips = ClipDataParser.new(data).parse_clips
    Video::Video.new(clips).save
  end
end
