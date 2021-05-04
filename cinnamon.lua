require 'os'
require 'io'
utils = require("mp.utils")


function on_next_center()
  timepos = mp.get_property("time-pos")
  duration = mp.get_property("duration")
  pid = utils.getpid()
  if pid and timepos and duration then
    progress = timepos*100/duration

    mpv_windowid = io.popen("xdotool search --pid " .. pid):read("*all*")
    if mpv_windowid ~= "" then
      mpv_windowid = string.gsub(mpv_windowid, "\n", "")
      os.execute("xprop -id " .. mpv_windowid .. " -f _NET_WM_XAPP_PROGRESS 32c -set _NET_WM_XAPP_PROGRESS "..progress)
    end
  end
end

mp.register_event("playback-restart", on_next_center)

mp.add_periodic_timer(1, on_next_center)

