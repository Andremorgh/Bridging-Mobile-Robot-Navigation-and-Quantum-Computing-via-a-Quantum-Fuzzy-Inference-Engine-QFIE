@echo off
setlocal EnableExtensions

REM ==========================================================
REM  CROP QUADRATO (1:1) centrato + sostituisce gli originali
REM  Cartelle: SIM01..SIM14
REM  File    : SIMxx_N.mp4 e SIMxx_Q.mp4
REM ==========================================================

REM ffmpeg.exe vicino al .bat oppure nel PATH
set "FFMPEG=%~dp0ffmpeg.exe"
if not exist "%FFMPEG%" set "FFMPEG=ffmpeg.exe"

REM Parametri video (crop => ricodifica video)
set "X264_PRESET=veryfast"
set "X264_CRF=20"

REM Verifica ffmpeg
"%FFMPEG%" -version >nul 2>nul
if errorlevel 1 (
  echo [ERRORE] ffmpeg non trovato. Metti ffmpeg.exe accanto al .bat oppure nel PATH.
  exit /b 1
)

REM Crop dinamico a 1:1 centrato:
REM - Se iw>ih: taglia i lati (rimuove barre nere laterali)
REM - Se ih>iw: taglia sopra/sotto
set "VF=crop='if(gt(iw,ih),ih,iw)':'if(gt(iw,ih),ih,iw)':'if(gt(iw,ih),(iw-ih)/2,0)':'if(gt(iw,ih),0,(ih-iw)/2)'"

for /L %%I in (1,1,14) do (
  call :CropOne %%I N
  call :CropOne %%I Q
)

echo.
echo Fatto.
exit /b 0


:CropOne
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
echo === CROP QUADRATO: %DIR%\%INFILE% ===

if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul

REM Nota: -map 0:a? rende l'audio opzionale (se non c'e', non fallisce)
"%FFMPEG%" -hide_banner -v error -stats -y -i "%INFILE%" ^
  -vf "%VF%" ^
  -map 0:v:0 -map 0:a? -sn -dn ^
  -c:v libx264 -preset %X264_PRESET% -crf %X264_CRF% ^
  -c:a copy ^
  -movflags +faststart "%TMPFILE%"

if errorlevel 1 goto FAIL
if not exist "%TMPFILE%" goto FAIL

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
echo [ERRORE] Crop fallito: "%DIR%\%INFILE%". Originale NON toccato.
if exist "%TMPFILE%" del /q "%TMPFILE%" >nul 2>nul
popd >nul
goto :eof