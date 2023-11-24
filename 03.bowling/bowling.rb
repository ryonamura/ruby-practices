#!/usr/bin/env ruby
# frozen_string_literal: true

# ここからコードを記述します
score = ARGV[0]
scores = score.split(',') # カンマを区切り文字として分割
shots = []
scores.each do |s|
  shots << if s == 'X'
             10
           elsif s == '/'
             10 - shots.last
           else
             s.to_i
           end
end

frames = []
frame = []
shots.each_with_index do |s, _|
  frame << s
  # ここで最初の９フレーム処理と１０フレーム目がストライクor2投完了した時に終了して、framesにframeを追加
  if frames.length < 9 && (s == 10 || frame.length == 2)
    frames << frame
    frame = []
  end
end
frames << frame unless frame.empty?

point = 0
frames.each_with_index do |current_frame, index|
  frame_score = current_frame.sum

  if current_frame[0] == 10 # ストライク
    next_frame = frames[index + 1] || []
    next_next_frame = frames[index + 2] || []

    frame_score += next_frame[0].to_i
    frame_score += next_frame.length == 1 ? next_next_frame[0].to_i : next_frame[1].to_i
  elsif frame_score == 10 # スペア
    frame_score += frames[index + 1][0].to_i
  end

  point += frame_score
end

puts point
