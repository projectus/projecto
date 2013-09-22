module ResumeEntriesHelper
  def bump_position(count)
		x = (count - count%4)/4
		if x == 0
		  "left:60px;top:#{20*(count%4)}px;"
		elsif x == 1
      "left:#{20-20*(count%4-1)}px;top:60px;"
		elsif x == 2
      "left:-20px;top:#{20-20*(count%4-1)}px;"
		elsif x == 3
      "left:#{20*(count%4)}px;top:-20px;"
    end
	end
end
