SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cScx, loc_cTask
loc_cScx = "C:\\4c\\tasks\\task485\\SIGCDPEN.SCX"
loc_cTask = "C:\\4c\\tasks\\task485"
DO "C:\\4c\\automation\\vfp_helpers\\ExtratorLayout.prg" WITH loc_cScx, loc_cTask
QUIT
