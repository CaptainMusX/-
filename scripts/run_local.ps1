$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$python = Join-Path $root ".venv\Scripts\python.exe"
if (-not (Test-Path $python)) {
    python -m venv .venv
}

& $python -m pip install --disable-pip-version-check -r requirements.txt
& $python ablesci.py
exit $LASTEXITCODE
