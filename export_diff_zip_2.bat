if "%2" EQU "" (
  set PARAM1=HEAD
  set PARAM2=%1
) else (
  set PARAM1=%1
  set PARAM2=%2
)

setlocal enabledelayedexpansion
set SHORTPARAM1=%PARAM1:~0,7%
set SHORTPARAM2=%PARAM2:~0,7%
set time=%time: =0%
set TODAY=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%

rem •ÏXŒã
set RET_DIR=
for /F "usebackq" %%i in (`git diff --name-only --diff-filter=ACMR %PARAM2% %PARAM1%`) do (
  set RET_DIR=!RET_DIR! "%%i"
)

git archive --format=zip --prefix=archive_%TODAY%/2_after/ %PARAM1% %RET_DIR% -o %USERPROFILE%\git_diff\archive_2_aft_%TODAY%.zip
powershell -command Expand-Archive -Path %USERPROFILE%\git_diff\archive_2_aft_%TODAY%.zip -DestinationPath %USERPROFILE%\git_diff\
del %USERPROFILE%\git_diff\archive_2_aft_%TODAY%.zip

rem •ÏX‘O
set RET_DIR=
for /F "usebackq" %%i in (`git diff --name-only --diff-filter=DCMR %PARAM1% %PARAM2%`) do (
  set RET_DIR=!RET_DIR! "%%i"
)

git archive --format=zip --prefix=archive_%TODAY%/1_before/ %PARAM2% %RET_DIR% -o %USERPROFILE%\git_diff\archive_1_bef_%TODAY%.zip
powershell -command Expand-Archive -Path %USERPROFILE%\git_diff\archive_1_bef_%TODAY%.zip -DestinationPath %USERPROFILE%\git_diff\
del %USERPROFILE%\git_diff\archive_1_bef_%TODAY%.zip
start %USERPROFILE%\git_diff\archive_%TODAY%

git diff --name-status %PARAM2% %PARAM1% > %USERPROFILE%\git_diff\archive_%TODAY%\DiffFileList_%SHORTPARAM2%_to_%SHORTPARAM1%.txt