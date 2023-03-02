-- Script to monitor up to 32 heat exchangers from the Bigger Reactors mod.
-- formatted for advanced monitors set 4 wide by 5 tall.

-- Wrap the monitor attached to the top
local monitor = peripheral.wrap("top")

-- Detect peripherals starting with "BiggerReactors" and inserts them into a table
local exchangers = {}
for _, name in ipairs(peripheral.getNames()) do
  if name:match("^BiggerReactors") then
    table.insert(exchangers, peripheral.wrap(name))
  end
end

while true do
-- Clear the monitor and set the cursor position to the top left corner
  monitor.clear()
  monitor.setCursorPos(1, 1)

-- Create the heading for the table
  monitor.setBackgroundColor(colors.green)
  monitor.setTextColor(colors.black)
  monitor.write("Heat Exchanger ## \tSteam Output\tCoolant Output         \n")
  
-- set the monitor back to black background and white text
  monitor.setBackgroundColor(colors.black)
  monitor.setTextColor(colors.white)

-- Output the names of the exchangers
  for i = 1, 32 do
    monitor.setCursorPos(1, i+1)
  
-- code to make every other line gray or black
    if i % 2 == 0 then 
      monitor.setBackgroundColor(colors.lightGray)
    end
    if i % 2 ~= 0 then
      monitor.setBackgroundColor(colors.black)
    end
  
-- output the exchanger names
    monitor.write("Heat Exchanger " .. i .. "       ")
  
-- output the steam and coolant to the monitor as buckets instead of millibuckets
    if exchangers[i] then
       monitor.setCursorPos(24, i+1)
       monitor.write(exchangers[i].evaporator().maxTransitionedLastTick() / 1000)
       monitor.setCursorPos(38, i+1)
       monitor.write(exchangers[i].condenser().maxTransitionedLastTick() / 1000)
    else
  
-- output N/A if no devices are detected
      monitor.write("N/A\tN/A\n")
    end
  
--sets background back to black
  monitor.setBackgroundColor(colors.black)
  end

-- wait for a second to check again
  os.sleep(1)
end
