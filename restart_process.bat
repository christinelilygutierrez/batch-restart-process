::===============================================================
:: Name: restart_process.bat
:: Author: https://github.com/christinelilygutierrez
:: Description: Restart PowerToys.exe automatically
:: Syntax: \.powertoys_restart.bat [<EXE_NAME>]
:: Examples: 
::   \.powertoys_restart.bat
::   \.powertoys_restart.bat PowerToys.exe
:: History : Name - YYYY/MM/DD - Comment
::           Gutierrez, Christine - 2025/01/29 - Created
::===============================================================
::******************** Start of Code Execution ******************
@echo off 
Rem turn off verbose commands to avoid seeing excessive output 

Rem Step 01: Use TASKLIST to find PID of process via executable name 
if [%1]==[] (
  echo Please rerun program and enter in the name of the exe for the process you wish to restart.
  goto :exitLabel
) else (
  set processname=%1
  echo Using Tasklist to find %processname%
)

:: Use /f flag to filter the output
:: Use the parameter tokens=2 to grab the first two tokens of tasklist output
:: Use the parameter delims= to deliminate the tokens by space(s)
:: 'tasklist ^| findstr /i "%processName%"' is a pipe of two commands
::   The command TASKLIST shows the list of exes and their PIDs. 
::   The output of tasklist is fed into the command FINDSTR with /i for name and uses PowerToys.exe as the name to find.
::===============================================================
:: Sample Output:
:: Image Name                     PID Session Name        Session#    Mem Usage
:: ========================= ======== ================ =========== ============
:: PowerToys.exe                40156 Console                    2     44,904 K
for /f "tokens=2 delims= " %%A in ('tasklist ^| findstr /i "%processName%"') do (
    set "PID=%%A"
    Rem PID for PowerToys.exe acquired so jump to code to find exe
    goto :foundPID
)

Rem Step 02: If PID is found, find the exe path
:foundPID
: Use /f flag to filter the output
:: Use the parameter tokens=2 to grab the first two tokens of tasklist output
:: Use the parameter delims=: to deliminate the tokens by colons
:: The command wmic grabs the executable path of the process ID
for /f "tokens=2 delims==" %%i in ('wmic process where "ProcessId=%PID%" get ExecutablePath /value') do (
  set exe_loc=%%i
  Rem Path for PowerToys.exe acquired so jump to code to kill it
  goto :foundExe
)

Rem Step 03: If PID and exe path are found, use TASKKILL to kill task and not show output
:foundExe
if defined PID (
  if defined exe_loc (
    echo The PID of %processName% is %PID% with executable path %exe_loc%. Killing process.
    TASKKILL /f /im %PID%
  ) else (
    echo Could not find exe path for process %processName% with %PID%.
    goto :exitLabel
  )      
) else (
  echo Process %processName% not found in tasklist.
  goto :exitLabel
)

Rem Step 04: Restart process via the exe using the path 
START %exe_loc%
for /f "tokens=2 delims= " %%A in ('tasklist ^| findstr /i "%processName%"') do (
    set "NEWPID=%%A"
    if defined NEWPID (
      echo Congratulations %exe_loc% is restarted!
      goto :exitLabel
    )
)

:exitLabel
exit /B 0
::******************** End of Code Execution ********************