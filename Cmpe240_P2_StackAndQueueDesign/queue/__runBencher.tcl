set TBWFile "qtest.tbw"
if [file exists $TBWFile] { file delete -force $TBWFile }
set BencherCmdFile "_hb_cmds"
execVisible C:/Programlar/Xilinx/bin/nt/tb.exe -f \"_hb_cmds\"
