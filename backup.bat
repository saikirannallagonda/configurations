@echo off
echo.
echo Mirroring Desktop...
ROBOCOPY C:\Users\sai_kiran_n\Desktop D:\asus1\Desktop /MIR /LOG:C:\Users\sai_kiran_n\Desktop\asus1_backup_log.txt
echo.
echo Mirroring Documents...
ROBOCOPY C:\Users\sai_kiran_n\Documents D:\asus1\Documents /MIR /LOG:C:\Users\sai_kiran_n\Documents\asus1_backup_log.txt
echo.
echo Mirroring Pictures...
ROBOCOPY C:\Users\sai_kiran_n\Pictures D:\asus1\Pictures /MIR /LOG:C:\Users\sai_kiran_n\Pictures\asus1_backup_log.txt
echo.
echo Mirroring Music...
ROBOCOPY C:\Users\sai_kiran_n\Music D:\asus1\Music /MIR /LOG:C:\Users\sai_kiran_n\Music\asus1_backup_log.txt
echo.
echo Mirroring Videos...
ROBOCOPY C:\Users\sai_kiran_n\Videos D:\asus1\Videos /MIR /LOG:C:\Users\sai_kiran_n\Videos\asus1_backup_log.txt
echo.
echo Mirroring .vimrc file...
ROBOCOPY C:\Users\sai_kiran_n D:\asus1 .vimrc /LOG:C:\Users\sai_kiran_n\asus1_backup_log.txt
echo.
:end
echo 	asus1 mirrored to D drive.
exit /B 0
