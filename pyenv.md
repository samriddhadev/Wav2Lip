python38 -m venv venv
.\venv\Scripts\Activate
pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt
# work on your project
deactivate

python inference.py --checkpoint_path C:\Samriddha\lab\Wav2Lip\test-data\model\wav2lip_gan.pth --face "C:\Samriddha\lab\Wav2Lip\test-data\stranger.png" --audio "C:\Samriddha\lab\Wav2Lip\test-data\stranger.mp3"

## Windows:
The DLL load failed error is a common issue with PyTorch on Windows. Here are several solutions to fix this:

## Solution 1: Install Visual C++ Redistributables (Most Common Fix)

Download and install these Microsoft Visual C++ Redistributables:

1. **VC++ 2019 Redistributable (x64)**: https://aka.ms/vs/16/release/vc_redist.x64.exe
2. **VC++ 2017 Redistributable (x64)**: https://aka.ms/vs/15/release/vc_redist.x64.exe
3. **VC++ 2015 Redistributable (x64)**: https://www.microsoft.com/en-us/download/details.aspx?id=48145

Install all three, then restart your command prompt.

## Solution 2: Use CPU-Only PyTorch Version

Update your pyenv.md:

````markdown
python38 -m venv venv
.\venv\Scripts\Activate

# Uninstall existing PyTorch
pip uninstall torch torchvision

# Install CPU-only PyTorch (more stable on Windows)
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org torch==1.2.0+cpu torchvision==0.4.0+cpu -f https://download.pytorch.org/whl/torch_stable.html

# Install remaining packages
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org librosa==0.7.0 numpy==1.17.1 opencv-contrib-python==4.2.0.34 opencv-python==4.1.0.25 tqdm==4.45.0 numba==0.48 face_detection

# work on your project
deactivate

python inference.py --checkpoint_path C:\Samriddha\lab\Wav2Lip\test-data\model\wav2lip_gan.pth --face "C:\Samriddha\lab\Wav2Lip\test-data\stranger.png" --audio "C:\Samriddha\lab\Wav2Lip\test-data\stranger.mp3"
````

## Solution 3: Fix Missing DLL Dependencies

Install missing dependencies:

````bash
# Activate your environment first
.\venv\Scripts\Activate

# Install Intel MKL (often fixes DLL issues)
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org mkl

# Or try installing conda's numpy/scipy stack
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org numpy scipy --force-reinstall
````

## Solution 4: Use Conda Instead of Pip

If you have Anaconda/Miniconda installed:

````bash
# Create conda environment
conda create -n wav2lip python=3.8
conda activate wav2lip

# Install PyTorch via conda (more reliable)
conda install pytorch==1.2.0 torchvision==0.4.0 cpuonly -c pytorch

# Install other packages
pip install librosa==0.7.0 opencv-contrib-python==4.2.0.34 opencv-python==4.1.0.25 tqdm==4.45.0 numba==0.48 face_detection
````

## Solution 5: Check System Dependencies

Run this PowerShell command to check for missing DLLs:

````powershell
# Check if you have the required DLLs
Get-ChildItem -Path "C:\Windows\System32" -Filter "*vcruntime*"
Get-ChildItem -Path "C:\Windows\System32" -Filter "*msvcp*"
````

## Solution 6: Alternative PyTorch Installation

Try installing an older, more compatible version:

````bash
pip uninstall torch torchvision
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org torch==1.0.1 torchvision==0.2.2
````

## Quick Test After Fix

After trying any solution, test PyTorch:

````bash
python -c "import torch; print('PyTorch version:', torch.__version__); print('CUDA available:', torch.cuda.is_available())"
````

**Start with Solution 1** (installing Visual C++ Redistributables) as this fixes the majority of DLL load failed errors on Windows. If that doesn't work, try Solution 2 (CPU-only PyTorch).