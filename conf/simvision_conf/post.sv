# SimVision Command Script (日  八  15 廿二時40分33秒 CST 2021)
#
# Version 15.20.s084
#
# You can restore this configuration with:
#
#     simvision -input /home/wei/git/sample_verilog/conf/simvision_conf/post.sv
#


#
# Preferences
#
preferences set plugin-enable-svdatabrowser-new 1
preferences set plugin-enable-groupscope 0
preferences set plugin-enable-interleaveandcompare 0
preferences set plugin-enable-waveformfrequencyplot 0
preferences set whats-new-dont-show-at-startup 1
preferences set txe-navigate-waveform-locate 1
preferences set waveform-space 5
preferences set txe-locate-add-fibers 1
preferences set txe-locate-scroll-x 1
preferences set txe-locate-scroll-y 1
preferences set txe-view-hidden 0
preferences set toolbar-Windows-WatchWindow {
  usual
  shown 0
}
preferences set waveform-height 15
preferences set vhdl-colors {H #00ffff L #00ffff 0 {} X #ff0000 - {} 1 {} U #9900ff Z #ff9900 W #ff0000}
preferences set txe-view-hold 0
preferences set toolbar-SimControl-WatchWindow {
  usual
  shown 0
}
preferences set transaction-height 2
preferences set verilog-colors {Su #ff0099 0 {} 1 {} HiZ #ff9900 We #00ffff Pu #9900ff Sm #00ff99 X #ff0000 StrX #ff0000 other #ffff00 Z #ff9900 Me #0000ff La #ff00ff St {}}
preferences set txe-navigate-search-locate 0
preferences set txe-search-show-linenumbers 1
preferences set toolbar-Standard-WatchWindow {
  usual
  shown 0
}
preferences set txe-locate-pop-waveform 1
preferences set txe-navigate-waveform-next-child 1
preferences set toolbar-TimeSearch-WatchWindow {
  usual
  shown 0
}
preferences set key-bindings {PageUp PageUp Edit>Undo Ctrl+z View>Zoom>Next {Alt+Right arrow} View>Zoom>In Alt+i PageDown PageDown ScrollDown {Down arrow} Edit>Copy Ctrl+c View>Zoom>FullY_widget y Edit>Create>Group Ctrl+g Simulation>NextInScope F7 Edit>Select>All Ctrl+a Format>Radix>Decimal Ctrl+Shift+D Edit>Ungroup Ctrl+Shift+G TopOfPage Home Edit>Create>Condition Ctrl+e {command -console SimVision {%w sidebar access designbrowser selectall}} Alt+a ScrollLeft {Left arrow} View>Zoom>FullX_widget = Edit>SelectAllText Alt+a Edit>TextSearchConsole Alt+s Windows>SendTo>Waveform Ctrl+w Simulation>Return Shift+F5 View>CallstackDown {Ctrl+Down arrow} Select>All Ctrl+a Edit>Delete Del Format>Radix>Octal Ctrl+Shift+O Edit>Cut Ctrl+x Simulation>Run F2 Edit>Create>Marker Ctrl+m View>Center Alt+c View>CallstackInWindow Ctrl+k Edit>SelectAll Ctrl+a File>OpenDatabase Ctrl+o Edit>Redo Ctrl+y Format>Radix>Binary Ctrl+Shift+B View>ExpandSequenceTime>AtCursor Alt+x ScrollUp {Up arrow} File>CloseWindow Ctrl+Shift+w ScrollRight {Right arrow} View>Zoom>FullX Alt+= Edit>Create>Bus Ctrl+b Explore>NextEdge Ctrl+\] View>Zoom>Cursor-Baseline Alt+z View>Zoom>OutX Alt+o Edit>GoToLine Ctrl+g View>Zoom>Fit Alt+= View>Zoom>OutX_widget o View>CallstackUp {Ctrl+Up arrow} View>Bookmarks>Add Ctrl+b Format>Radix>Hexadecimal Ctrl+Shift+H Edit>Search Ctrl+f Simulation>Next F6 View>ShowValues Ctrl+s View>Zoom>InX Alt+i Edit>Create>MarkerAtCursor Ctrl+Shift+M View>Zoom>Out Alt+o Edit>TextSearch Ctrl+f Format>Signed Ctrl+Shift+S Edit>Paste Ctrl+v View>Zoom>Previous {Alt+Left arrow} View>CollapseSequenceTime>AtCursor Alt+s Format>Radix>ASCII Ctrl+Shift+A View>Zoom>InX_widget i Explore>PreviousEdge {Ctrl+[} Simulation>Step F5 BottomOfPage End}
preferences set signal-type-colors {assertion #FF0000 output #FFA500 group #0099FF inout #00FFFF input #FFFF00 fiber #00EEEE errorsignal #FF0000 unknown #FFFFFF overlay #0099FF internal #00FF00 reference #FFFFFF}

#
# Databases
#
database require traffic_light -search {
	./traffic_light.shm/traffic_light.trn
	/home/wei/git/sample_verilog/build/traffic_light.shm/traffic_light.trn
}

#
# Mnemonic Maps
#
mmap new -reuse -name {Boolean as Logic} -radix %b -contents {{%c=FALSE -edgepriority 1 -shape low}
{%c=TRUE -edgepriority 1 -shape high}}
mmap new -reuse -name {Example Map} -radix %x -contents {{%b=11???? -bgcolor orange -label REG:%x -linecolor yellow -shape bus}
{%x=1F -bgcolor red -label ERROR -linecolor white -shape EVENT}
{%x=2C -bgcolor red -label ERROR -linecolor white -shape EVENT}
{%x=* -label %x -linecolor gray -shape bus}}

#
# Waveform windows
#
if {[catch {window new WaveWindow -name "Waveform 1" -geometry 1848x1016+0+23}] != ""} {
    window geometry "Waveform 1" 1848x1016+0+23
}
window target "Waveform 1" on
waveform using {Waveform 1}
waveform sidebar select designbrowser
waveform set \
    -primarycursor TimeA \
    -signalnames name \
    -signalwidth 175 \
    -units ns \
    -valuewidth 75
waveform baseline set -time 0

set id [waveform add -signals  {
	traffic_light::traffic_light_tb.ul.clk
	} ]
set id [waveform add -signals  {
	{traffic_light::traffic_light_tb.ul.next_state[4:0]}
	} ]
set id [waveform add -signals  {
	traffic_light::traffic_light_tb.ul.rst
	} ]
set id [waveform add -signals  {
	traffic_light::traffic_light_tb.ul.R
	} ]
set id [waveform add -signals  {
	traffic_light::traffic_light_tb.ul.G
	} ]
set id [waveform add -signals  {
	traffic_light::traffic_light_tb.ul.Y
	} ]
set id [waveform add -signals  {
	{traffic_light::traffic_light_tb.out[2:0]}
	} ]
waveform hierarchy expand $id

waveform xview limits 0 2000ns

#
# Waveform Window Links
#

#
# Console windows
#
console set -windowname Console
window geometry Console 600x250+210+176

