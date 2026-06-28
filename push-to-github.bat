@echo off
echo ========================================
echo   StoryFlow AI - Push to GitHub
echo ========================================
echo.

:: Check git
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Chua co Git! Tai tai: https://git-scm.com/download/win
    pause
    exit /b
)

:: Config
set REPO_URL=https://github.com/dinhkhanhtung/storyflow-ai.git
set FILE=storyflow-ai.html

:: Clone repo
echo [1/4] Clone repo...
if exist "storyflow-temp" rmdir /s /q storyflow-temp
git clone %REPO_URL% storyflow-temp
if %errorlevel% neq 0 (
    echo [LOI] Khong clone duoc repo. Kiem tra internet va quyen truy cap.
    pause
    exit /b
)

:: Copy file
echo [2/4] Copy file HTML vao repo...
copy /y "%~dp0%FILE%" "storyflow-temp\%FILE%"
if %errorlevel% neq 0 (
    echo [LOI] Khong tim thay %FILE% cung thu muc voi file .bat nay
    pause
    exit /b
)

:: Commit & push
echo [3/4] Commit va push...
cd storyflow-temp
git add %FILE%
git commit -m "Update StoryFlow AI v7.2"
git push origin main
if %errorlevel% neq 0 (
    git push origin master
)

:: Done
echo.
echo [4/4] XONG!
echo.
echo GitHub Pages se co tai:
echo https://dinhkhanhtung.github.io/storyflow-ai/storyflow-ai.html
echo.
echo (Cho 1-2 phut de GitHub build xong)
cd ..
rmdir /s /q storyflow-temp
pause
