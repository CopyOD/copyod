FROM debian:10-slim

ADD ttyd /usr/bin/ttyd
ADD copyod.ps1 /home/OneDrive

RUN apt-get update -y \
    && apt-get install -y curl gnupg apt-transport-https ca-certificates \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list' \
    && apt-get update -y \
    && apt-get install -y powershell \    
    && chmod +x /usr/bin/ttyd

WORKDIR /home
RUN pwsh -c "Install-Module -Scope AllUsers PnP.PowerShell -Force"
CMD ttyd --port $PORT --ping-interval 30 pwsh OneDrive
