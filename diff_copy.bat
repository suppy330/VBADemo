if "%2" EQU "" (
  set PARAM1=HEAD
  set PARAM2=%1
) else (
  set PARAM1=%1
  set PARAM2=%2
)

setlocal enabledelayedexpansion
set shortparam1=%PARAM1:~0,7%
set shortparam2=%PARAM2:~0,7%

set time=%time: =0%
set TODAY=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%

git bash

rem •ÏXŒã
set afterDir=%USERPROFILE%\git_diff\archive_%TODAY%\2_after
mkdir -p %afterDir%

for /F "usebackq" %%i in (`git diff --name-only --diff-filter=ACMR %PARAM2% %PARAM1%`) do (
  mkdir -p "%afterDir%%%~pi"
  copy "%%~dpi%%~nxi" "%afterDir%%%~pi"
)

git checkout %PARAM2%

rem •ÏX‘O
set beforeDir=%USERPROFILE%\git_diff\archive_%TODAY%\1_before
mkdir -p %beforeDir%

for /F "usebackq" %%i in (`git diff --name-only --diff-filter=DCMR %PARAM1% %PARAM2%`) do (
  mkdir -p "%beforeDir%%%~pi"
  copy "%%~dpi%%~nxi" "%beforeDir%%%~pi"
)

git diff --name-status %param2% %param1% > %USERPROFILE%\git_diff\archive_%TODAY%\DiffFileList_%shortparam2%_to_%shortparam1%.txt
start %USERPROFILE%\git_diff\archive_%TODAY%

git checkout -