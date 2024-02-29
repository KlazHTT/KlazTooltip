local addon, ns = ...
local T = {}
ns.T = T

--------------------------------------------------------------------------------
-- # CORE > FUNCTIONS
--------------------------------------------------------------------------------

T.ShortValue = function(value)
  if value >= 1e11 then
    return ('%.0fb'):format(value / 1e9)
  elseif value >= 1e10 then
    return ('%.1fb'):format(value / 1e9):gsub('%.?0+([km])$', '%1')
  elseif value >= 1e9 then
    return ('%.2fb'):format(value / 1e9):gsub('%.?0+([km])$', '%1')
  elseif value >= 1e8 then
    return ('%.0fm'):format(value / 1e6)
  elseif value >= 1e7 then
    return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
  elseif value >= 1e6 then
    return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
  elseif value >= 1e5 then
    return ('%.0fk'):format(value / 1e3)
  elseif value >= 1e3 then
    return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
  else
    return value
  end
end
