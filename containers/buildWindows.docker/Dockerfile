# Use the official Windows image as a base
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Chocolatey package manager
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Install packages required
RUN choco feature enable -n allowGlobalConfirmation
#RUN choco install llvm --version=16.0.6
RUN choco install git
RUN choco install cmake
RUN choco install visualstudio2022buildtools  --package-parameters "--allWorkloads --includeRecommended"
RUN choco install vcredist140
RUN choco install llvm --version=19.1.5
RUN choco install python3
RUN choco install ninja
RUN choco install openssl --version=3.3.2

RUN git config --global --add safe.directory C:/build/arangodb

# Set environment variables
ENV PATH="C:\\Python313;C:\\Program Files\\LLVM\\bin;C:\\Program Files\\CMake\\bin;C:\\Program Files\\Git\\bin;C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0;${PATH}"

# Set the working directory where the build will be done
WORKDIR /build

# Default command
ENTRYPOINT ["C:\\Windows\\SysWOW64\\WindowsPowerShell\\v1.0\\powershell.exe"]
CMD ["-NoLogo", "-ExecutionPolicy", "Bypass"]