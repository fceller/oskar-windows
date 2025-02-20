# Use the official Windows image as a base
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Chocolatey package manager
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Install packages required
RUN choco feature enable -n allowGlobalConfirmation

RUN choco install git
RUN choco install cmake
RUN choco install visualstudio2022buildtools  --package-parameters "--allWorkloads --includeRecommended"
RUN choco install vcredist140
RUN choco install llvm --version=19.1.5
RUN choco install python3
RUN choco install ninja
RUN choco install ccache
RUN choco install nodejs
RUN choco install yarn

# Set environment variables
ENV MSYS2_PATH_TYPE inherit
ENV MSYS2_DIR C:\\msys64

# Download and install MSYS2
RUN powershell -Command Invoke-WebRequest -Uri https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.sfx.exe -OutFile msys2-installer.exe; Start-Process -FilePath msys2-installer.exe -NoNewWindow -Wait; Remove-Item -Force msys2-installer.exe

# Update MSYS2 and install base development tools
RUN C:\\msys64\\usr\\bin\\bash.exe -lc "pacman -Syu --noconfirm" && C:\\msys64\\usr\\bin\\bash.exe -lc "pacman -S --noconfirm base-devel mingw-w64-x86_64-toolchain"

# Clone the Vcpkg repository
RUN git clone --verbose --progress https://github.com/microsoft/vcpkg.git C:\vcpkg

# Bootstrap Vcpkg
RUN C:\vcpkg\bootstrap-vcpkg.bat

# Set the Vcpkg toolchain file environment variable
ENV VCPKG_ROOT=C:\vcpkg
ENV CMAKE_TOOLCHAIN_FILE="C:\\vcpkg\\scripts\\buildsystems\\vcpkg.cmake"

RUN git config --global --add safe.directory C:/build/*

# Set environment variables
ENV PATH="c:\\Program Files\\nodejs;c:\\Program Files (x86)\\Yarn\\bin;c:\\ProgramData\\chocolatey\\bin;C:\\Python313;C:\\Program Files\\LLVM\\bin;C:\\Program Files\\CMake\\bin;C:\\Program Files\\Git\\bin;C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0;C:\\msys64\\usr\\bin;C:\\msys64\\mingw64\\bin;${PATH}"

# Install autotools
RUN pacman -S -q --confirm --noconfirm mingw-w64-x86_64-autotools
RUN pacman -S -q --confirm --noconfirm autotools

# Set the working directory where the build will be done
WORKDIR /

# Default command
ENTRYPOINT ["C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0\\powershell.exe"]
CMD ["-NoLogo", "-ExecutionPolicy", "Bypass"]
