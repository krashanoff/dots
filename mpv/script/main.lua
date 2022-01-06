-- Record GIF from MPV.

current_timer = nil

function stop_recording()
  current_timer:kill()
  mp.osd_message('Creating GIF in background...', 1.0)
end

function start_recording()
  mp.osd_message('Recording GIF...', 1.0)
  current_timer = mpv.add_periodic_timer(1, function()
    -- TODO: screenshot
  end)
end

