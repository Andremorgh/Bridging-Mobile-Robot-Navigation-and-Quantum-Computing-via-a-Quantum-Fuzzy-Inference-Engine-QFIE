@echo off
setlocal EnableExtensions

REM ==========================================================
REM  Velocizza MP4 x2 e SOSTITUISCE i file originali
REM  Cartelle: SIM01..SIM14
REM  File    : SIMxx_N.mp4 e SIMxx_Q.mp4
REM ==========================================================

REM Prova prima ffmpeg.exe nella stessa cartella del .bat, poi nel PATH
set "FFMPEG=%~dp0ffmpeg.exe"
if not exist "%FFMPEG%" set "FFMPEG=ffmpeg.exe"

REM Parametri encoding
set "X264_PRESET=veryfast"
set "X264_CRF=20"
set "AAC_BITRATE=192k"

REM x2
set "V_SETPTS=0.5*PTS"
set "A_ATEMPO=atempo=2.0"

REM Verifica ffmpeg
"%FFMPEG%" -version >nul 2>nul
if errorlevel 1 (
  echo [ERRORE] ffmpeg non trovato. Metti ffmpeg.exe accanto al .bat oppure nel PATH.
  exit /b 1
)

for /L %%I in (1,1,14) do (
  call :SpeedOne %%I N
  call :SpeedOne %%I Q
)

echo.
echo Fatto.
exit /b 0


:SpeedOne
set "IDX=%~1"
set "SUF=%~2"

set "NN=0%IDX%"
set "NN=%NN:~-2%"

set "DIR=SIM%NN%"
set "BASE=SIM%NN%_%SUF%"

if not exist "%DIR%\" (
  echo [SKIP] Cartella "%DIR%" non trovata.
  goto :eof
)

pushd "%DIR%" >nul

set "INFILE="
if exist "%BASE%.mp4" set "INFILE=%BASE%.mp4"
if not defined INFILE if exist "%BASE%.MP4" set "INFILE=%BASE%.MP4"

if not defined INFILE (
  echo [SKIP] File "%DIR%\%BASE%.mp4" non trovato.
  popd >nul
  goto :eof
)

set "TMPFILE=%BASE%.tmp.mp4"

echo.
echo === Sostituisco %DIR%\%INFILE% (x2) ===

if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul

REM Tentativo 1: video + audio
"%FFMPEG%" -hide_banner -v error -stats -y -i "%INFILE%" -filter_complex "[0:v]setpts=%V_SETPTS%[v];[0:a]%A_ATEMPO%[a]" -map "[v]" -map "[a]" -sn -dn -c:v libx264 -preset %X264_PRESET% -crf %X264_CRF% -c:a aac -b:a %AAC_BITRATE% -movflags +faststart "%TMPFILE%"

if errorlevel 1 (
  REM Tentativo 2: solo video (se non c'e' audio)
  if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul
  "%FFMPEG%" -hide_banner -v error -stats -y -i "%INFILE%" -vf "setpts=%V_SETPTS%" -map 0:v:0 -sn -dn -an -c:v libx264 -preset %X264_PRESET% -crf %X264_CRF% -movflags +faststart "%TMPFILE%"
  if errorlevel 1 goto FAIL
)

if not exist "%TMPFILE%" goto FAIL

REM --- Sostituzione atomica: elimina originale e rinomina tmp ---
del /q "%INFILE%" >nul 2>nul
if errorlevel 1 goto FAIL_RENAME

ren "%TMPFILE%" "%INFILE%"
if errorlevel 1 goto FAIL_RENAME

echo [OK] Sostituito "%DIR%\%INFILE%"
popd >nul
goto :eof

:FAIL_RENAME
echo [ERRORE] Creato tmp ma non sono riuscito a sostituire l'originale: "%DIR%\%INFILE%"
echo          Il temporaneo rimane: "%DIR%\%TMPFILE%"
popd >nul
goto :eof

:FAIL
echo [ERRORE] Velocizzazione fallita: "%DIR%\%INFILE%". Originale NON toccato.
if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul
popd >nul
goto :eof