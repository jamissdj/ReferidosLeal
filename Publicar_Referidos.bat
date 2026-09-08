@echo off
chcp 65001 >nul
REM ============================================================
REM   Publicar Referidos Leal en GitHub
REM   Sube el Index_Referidos.html y los CV nuevos, y hace push.
REM   Uso: doble clic en este archivo.
REM ============================================================

cd /d "%~dp0"

echo.
echo ====================================================
echo   PUBLICAR REFERIDOS LEAL EN GITHUB
echo ====================================================
echo.
echo Carpeta: %cd%
echo.

REM Mostrar que se va a subir (respetando .gitignore)
echo Detectando cambios...
git add -A
echo.
echo --- Archivos que se subiran ---
git status --short
echo -------------------------------
echo.

REM Confirmacion del usuario
set /p CONFIRM="Deseas publicar estos cambios en GitHub? (S/N): "
if /i not "%CONFIRM%"=="S" (
    echo.
    echo Operacion cancelada. No se subio nada.
    echo.
    pause
    exit /b 0
)

REM Commit con fecha y hora
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set FECHA=%%a-%%b-%%c
git commit -m "Actualizar referidos - %FECHA%"

echo.
echo Subiendo a GitHub...
git push origin main

echo.
if %errorlevel%==0 (
    echo ====================================================
    echo   LISTO! Cambios publicados correctamente.
    echo ====================================================
) else (
    echo ====================================================
    echo   Hubo un problema al subir. Revisa el mensaje arriba.
    echo ====================================================
)
echo.
pause
