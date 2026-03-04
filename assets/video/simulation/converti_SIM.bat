@echo off
setlocal EnableExtensions

set "FFMPEG=ffmpeg.exe"
set "X264_PRESET=veryfast"
set "X264_CRF=20"
set "AAC_BITRATE=192k"

where "%FFMPEG%" >nul 2>nul
if errorlevel 1 (
  echo [ERRORE] ffmpeg non trovato nel PATH.
  exit /b 1
)

for /L %%I in (1,1,14) do call :ConvertOne "SIM%%I" "SIM%%I_N"
for /L %%I in (1,1,14) do call :ConvertOne "SIM%%I" "SIM%%I_Q"

echo.
echo Fatto.
exit /b 0

:ConvertOne
set "DIR=%~1"
set "BASE=%~2"

if not exist "%DIR%\" (
  echo [SKIP] Cartella "%DIR%" non trovata.
  goto :eof
)

pushd "%DIR%" >nul

set "INFILE="
if exist "%BASE%.mkv" set "INFILE=%BASE%.mkv"
if not defined INFILE if exist "%BASE%.MKV" set "INFILE=%BASE%.MKV"

if not defined INFILE (
  echo [SKIP] File "%DIR%\%BASE%.mkv" non trovato.
  popd >nul
  goto :eof
)

set "OUTFILE=%BASE%.mp4"
set "TMPFILE=%BASE%.tmp.mp4"

echo.
echo === %BASE% ===

if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul

REM Tentativo 1: remux (senza ricodifica)
"%FFMPEG%" -hide_banner -y -i "%INFILE%" -map 0:v:0 -map 0:a? -sn -dn -c copy -movflags +faststart "%TMPFILE%" >nul 2>&1
if not errorlevel 1 goto CHECKTMP

REM Tentativo 2: ricodifica H.264/AAC
if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul
echo Remux non compatibile, ricodifico in H.264/AAC...
"%FFMPEG%" -hide_banner -y -i "%INFILE%" -map 0:v:0 -map 0:a? -sn -dn -c:v libx264 -preset %X264_PRESET% -crf %X264_CRF% -c:a aac -b:a %AAC_BITRATE% -movflags +faststart "%TMPFILE%"
if errorlevel 1 goto FAIL

:CHECKTMP
if not exist "%TMPFILE%" goto FAIL

REM Sostituzione: prima metto l'MP4 al suo posto, poi elimino l'MKV
move /y "%TMPFILE%" "%OUTFILE%" >nul 2>nul
if errorlevel 1 goto FAIL

del /q "%INFILE%" >nul 2>nul
echo [OK] Creato "%DIR%\%OUTFILE%" e rimosso l'MKV.

popd >nul
goto :eof

:FAIL
echo [ERRORE] Conversione/sostituzione fallita: "%DIR%\%INFILE%". Originale NON cancellato.
if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul
popd >nul
goto :eof