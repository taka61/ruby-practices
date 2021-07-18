# frozen_string_literal: true

score = ARGV[0]
scores = score.split(",")
shots = []
scores.each do |s|
  if s == "X"
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

# 1-9フレーム目の計算
point = frames[0..8].each_with_index.sum do |frame, i|
  if frame == [10, 0] && frames[i + 1][0] == 10 # ストライクが続いたら
    10 + 10 + frames[i + 2][0] # 20点+次の次の配列の1投目を加える
  elsif frame == [10, 0] # ストライクだったら
    10 + frames[i + 1][0] + frames[i + 1][1] # 次の配列の1投目+次の配列の2投目を加える
  elsif frame.sum == 10 # スペアだったら
    10 + frames[i + 1][0] # 次の配列の1投目を加える
  else
    frame.sum # その他
  end
end

# 10フレーム目の計算
point += if frames[9] == [10, 0] && frames[10][0] == 10 # ストライクが続いたら
    10 + 10 + frames[11][0]
  elsif frames[9] == [10, 0] # ストライクだったら
    10 + frames[10][0] + frames[10][1]
  elsif frames[9].sum == 10 # スペアだったら
    10 + frames[10][0]
  else
    frames[9].sum # その他
  end
puts point
