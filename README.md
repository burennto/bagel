# Bagel

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Usage](#usage)
  - [Example YAML File](#example-yaml-file)
  - [Configure and Start](#configure-and-start)
- [Sample Output](#sample-output)
- [Testing](#testing)
- [License](#license)
- [What Did I Use to Record My Videos?](#what-did-i-use-to-record-my-videos)
- [TODOs](#todos)

## Introduction
Bagel is a tennis video editor/annotator.

## Features

- Trim and concatenate videos
- Generate and overlay scoreboard/stat graphics

## Dependencies

- [FFmpeg][ffmpeg]
- [ImageMagick][imagemagick]

## Installation

Install native dependencies using [Homebrew][homebrew]:
```
$ brew install ffmpeg pkg-config imagemagick
```

Add this line to your application's Gemfile:
```ruby
gem 'bagel'
```
And then execute:
```
$ bundle install
```
Or install it yourself as:
```ruby
$ gem install bagel
```

## Usage

1. Make sure your source video is a single file. If your camera splits the recorded video into smaller chunks like mine does, concatenate them first:

```ruby
require 'bagel'

Bagel::Video.::FFMPEG.concat(
  source: 'path/to/chunks',
  destination: 'path/to/output.mp4',
  transcode: false
)
```

2. Chart the match and build the "clips file" using YAML. This file will be used to build the final video.

Every clip must specify:
- `type`
  - has to be either `intro`, `point`, or `stats`
- `start` and `finish` timestamps
  - which part of the source video to trim (e.g. `'01:23'`)

`intro` clips must also specify:
- `title` and `description`
  - e.g. the location and date/time of when the match was played

`point` clips must also specify:
- `server`
  - the player who served the point (`1` or `2`)
- `score`
  - a nested array representing the current score AT THE TIME OF SERVE
  - e.g. 6-4, 2-0, 40-15 is represented as [[[6, 4], [2, 0]], [3, 1]])
- `faults`
  - number of faults during serve
- `winner`
  - the player who won the point (`1` or`2`)
- `reason`
  - the circumstance under which the point was won
  - has to be either `W` for winner, `UE` for unforced error, or `FE` for forced error
- `shot`
  - the type of shot that ended the point
  - has to be either `S` for serve, `FH` for forehand, `BH` for backhand, or `OH` for overhead.
- `net` (optional)
  - an array containing details about whether the point was a net point for either player and the subsequent outcome
  - `true` = won the net point, `false` = lost the net point, `null` = player did not play a net point
  - e.g. [ true, null ] = player 1 won a net point, player 2 was not at the net
  - e.g. [ null, false ] = player 1 was not at the net, player 2 lost a net point (volley error etc.)

`stats` clips must also specify:
- `score`
  - a nested array representing the current score AT THE END OF THE SET
  - e.g. 6-4, 2-6 is represented as [[[6, 4], [2, 6]]]

### Example YAML File

```yaml
# Intro
- { type: intro, start: '00:00', finish: '00:08', title: 'My Tennis Club', description: 'May 16, 2021' }

# Set 1 points
- { type: point, server: 1, score: [[[0, 0]], [0, 0]], start: '02:02', faults: 1, finish: '02:07', winner: 1, reason: UE, shot: BH }
# ...
- { type: point, server: 2, score: [[[5, 4]], [3, 2]], start: '37:53', faults: 1, finish: '38:03', winner: 1, reason: W, shot: FH, net: [ true, false ] }

# Set 1 stats
- { type: stats, start: '38:35', finish: '38:47', score: [[[6, 4]]] }

# Set 2 points
- { type: point, server: 1, score: [[[6, 4], [0, 0]], [0, 0]], start: '40:41', faults: 1, finish: '40:55', winner: 1, reason: W, shot: BH, net: [ true, false ] }
# ...
- { type: point, server: 2, score: [[[6, 4], [2, 5]], [1, 3]], start: '1:14:05', faults: 0, finish: '1:14:11', winner: 2, reason: UE, shot: FH }

# Set 2 stats
- { type: stats, start: '1:14:24', finish: '1:14:36', score: [[[6, 4], [2, 6]]] }
```

### Configure and Start

```ruby
require 'bagel'

Bagel.configure do |config|
  config.name = '2021-05-16' # this will be used to namespace the temp clip/graphic files
  config.source_video = 'path/to/source/video.mp4'
  config.clip_data = 'path/to/data/file.yml'
  config.destination_video = 'path/to/destination/video.mp4'
  config.names = %w(Alice Bob)
end

Bagel.make_video
```

## Sample Output

![intro]
![point-1]
![point-2]
![stats]

## Testing

```
$ rspec
```
Tested on
- Ruby 3.0.1
- ffmpeg 4.4
- ImageMagick 7.0.11-12

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Useful Links
- https://stackoverflow.com/questions/57045900/how-to-find-a-safe-point-for-ss-using-ffmpeg-to-avoid-breaking-a-v-sync
- https://stackoverflow.com/questions/42943805/ffmpeg-is-it-possible-to-overlay-multiple-images-over-a-video-at-specified-inte
- https://trac.ffmpeg.org/wiki/Seeking#Seekingwhiledoingacodeccopy
- https://itectec.com/superuser/video-cut-with-missing-frames-in-ffmpeg/
- http://www.markbuckler.com/post/cutting-ffmpeg/

## What Did I Use to Record My Videos?
- [QM-1 Portable Camera Mount][qm-1]
- Sony Action Cam HDR-AS200V

# TODOs
- customizable audio/video quality
- customizable stats
- customizable scoreboards
- themed scoreboards (AO, RG, Wimbledon, USO, etc.)
- more details (deuce #, breakpoint #, etc.)

[ffmpeg]: https://www.ffmpeg.org
[imagemagick]: https://imagemagick.org
[homebrew]: https://brew.sh
[intro]: https://www.dropbox.com/s/64xc8xw15fxdton/intro.jpg?raw=1 "intro"
[point-1]: https://www.dropbox.com/s/ny6h5ja5d5doheg/point-1.jpg?raw=1 "point"
[point-2]: https://www.dropbox.com/s/gyvfkxx389y8pac/point-2.jpg?raw=1 "point"
[stats]: https://www.dropbox.com/s/gjm6bhshuchfwi9/stats.jpg?raw=1 "stats"
[qm-1]: https://mytennistools.com/play-smarter-with-the-qm-1
