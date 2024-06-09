This is instructions how to setup Macaulay2 on Windows 10.

Get 'bash' for Windows and M2:
1.) Get Ubuntu "bash" in cmd Install "Linux subsystem for Windows" with ubuntu.
Follow instructions: https://msdn.microsoft.com/en-us/commandline/wsl/install_guide

2.) Open Ubuntu bash.
Hit Start then type "bash", or open command prompt and type "bash".

3.) Install Macaulay 2 through bash.
Follow instructions: http://www.math.uiuc.edu/Macaulay2/Downloads/GNU-Linux/Ubuntu/index.html Tip: use the command in bash "lsb_release -a" to retrieve your Ubuntu's version.

4.) Create a file named "M2.bat" file with the following two lines

@echo off
start /wait bash -l -c "M2 -q %*"

Make sure this file in in your path (runnable from MATLAB as "!M2"). Now you should be able to call Macaulay2 as runM2(eqs) in Matlab