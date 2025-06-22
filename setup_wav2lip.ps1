# Ensure running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator."
    exit
}

$env:SSL_CERT_FILE = $null
$env:SSL_CERT_DIR = $null
$env:REQUESTS_CA_BUNDLE = $null
$env:CURL_CA_BUNDLE = $null

# Paths
$pythonPath = "C:\Users\YS864XN\AppData\Local\Programs\Python\Python36\python.exe"
$projectDir = "C:\Samriddha\lab\Wav2Lip"

# Step 1: Navigate to project directory
Set-Location $projectDir

# Step 2: Remove existing virtual environment if any
if (Test-Path .\venv) {
    Write-Host "Removing existing virtual environment..."
    Remove-Item -Recurse -Force .\venv
}

# Step 3: Create new virtual environment
Write-Host "Creating new virtual environment..."
& $pythonPath -m venv venv

# Step 4: Activate virtual environment
Write-Host "Activating virtual environment..."
& .\venv\Scripts\Activate

# Step 5: Upgrade pip with SSL workaround
Write-Host "Upgrading pip with SSL bypass..."
c:\samriddha\lab\wav2lip\venv\Scripts\python.exe -m pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --upgrade pip setuptools wheel


# Step 6: Install PyTorch first from archive, then other requirements
Write-Host "Installing PyTorch 1.1.0 from archive..."
# Use PyTorch 1.2.0+cpu instead
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org torch==1.2.0+cpu torchvision==0.4.0+cpu -f https://download.pytorch.org/whl/torch_stable.html

# c:\samriddha\lab\wav2lip\venv\Scripts\pip.exe install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org torch==1.1.0+cpu torchvision==0.3.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
# c:\samriddha\lab\wav2lip\venv\Scripts\pip.exe install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org torch==1.1.0 torchvision==0.3.0 -f https://download.pytorch.org/whl/torch_stable.html

Write-Host "Installing remaining requirements..."
c:\samriddha\lab\wav2lip\venv\Scripts\pip.exe install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org librosa==0.7.0 numpy==1.17.1 opencv-contrib-python==4.2.0.34 opencv-python==4.1.0.25 tqdm==4.45.0 numba==0.48

Write-Host "Setup complete. Remember to activate the venv before running your code:"
Write-Host "`n    .\venv\Scripts\Activate`n"