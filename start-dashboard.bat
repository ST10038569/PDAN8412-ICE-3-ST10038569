@echo off
setlocal
cd /d "%~dp0"

echo Pulling llama3.1 model...
ollama pull llama3.1
if errorlevel 1 (
    echo Model pull failed. Check that Ollama is installed and running.
    pause
    exit /b 1
)

echo Pulling qwen2.5:3b model...
ollama pull qwen2.5:3b
if errorlevel 1 (
    echo Model pull failed. Check that Ollama is installed and running.
    pause
    exit /b 1
)

start "Ollama llama3.1" cmd /k "ollama run llama3.1"
start "Dashboard API" /D "%~dp0" cmd /k "node server/index.js"
start "Dashboard Vite" /D "%~dp0" cmd /k "npm run dev"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$url = 'http://localhost:5173'; while ($true) { try { $response = Invoke-WebRequest -Uri $url -TimeoutSec 2; if ($response.StatusCode -eq 200) { Start-Process $url; break } } catch { }; Start-Sleep -Seconds 1 }"
