# batch-restart-process
This is Windows Batch script that allows you to specify exe file to dynamically kill and restart the process. 

This script uses the [wmic command](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/wmic), [tasklist command](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist), and [taskkill command](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/taskkill).

## How to Use
1. Clone the repository
2. Ensure the process you want to restart is running via Task Manager (ctrl + shift + esc) or the TASKLISST command in a terminal.
3. Ensure you have the exe name for the process you wish to restart such as PowerToys.exe. You can find this by right clicking the shortcut for your process and clicking Open File Location to find the exe.
4. [Open the command prompt in the location of the repository](https://www.itechtics.com/open-command-window-folder/#:~:text=Using%20CMD%20command%20in%20File%20Explorer%20to%20open,command%20prompt%20will%20be%20opened%20in%20the%20folder).
5. Run the command from
If you are using the command prompt without PowerShell, use the following syntax: `restart_process.bat <EXE_NAME>`
For example: `restart_process.bat PowerToys.exe`
If you are using the Powerhell terminal, use the following syntax: `\.restart_process.bat <EXE_NAME>`
For example: `\.restart_process.bat PowerToys.exe`
6. The terminal should show you the PID of the running program from the name of the EXE you specified, its process ID (PID), and that it restarted it successfully if it found the path of the exe.