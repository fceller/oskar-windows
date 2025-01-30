# Use the official Windows image as a base
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Chocolatey package manager
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Install packages required
RUN choco feature enable -n allowGlobalConfirmation
RUN choco install llvm --version=16.0.6
RUN choco install git
RUN choco install cmake
RUN choco install powershell

# Set environment variables
ENV PATH="C:\\Program Files\\LLVM\\bin;C:\\Program Files\\CMake\\bin;C:\\Program Files\\Git\\bin;${PATH}"


# Set the working directory where the build will be done
WORKDIR /build

# Default command
ENTRYPOINT ["cmd.exe"]
CMD ["-NoLogo", "-ExecutionPolicy", "Bypass"]