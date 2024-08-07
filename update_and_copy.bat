@echo off
cd "Batch Scripts"
git pull
copy "ADMIN_PREP-DCU-BDE-AD-RDS.bat" "..\ADMIN_PREP-DCU-BDE-AD-RDS.bat"
cd ..
echo Update complete and file copied to USB root.
pause