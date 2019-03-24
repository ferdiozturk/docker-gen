#FROM mcr.microsoft.com/windows/nanoserver:latest
FROM mcr.microsoft.com/windows/nanoserver/insider:10.0.18356.1
LABEL maintainer="Ferdi Oeztuerk foerdi@gmail.com"

ENV DOCKER_GEN_VERSION 0.7.4-windows
ENV PWSH_CORE_VERSION 6.1.3

ENV PATH C:\\Windows\\System32;C:\\Windows;C:\\openssl;C:\\docker-gen

# UNUSED Download PowerShell Core
#RUN curl.exe -kfSL -o pwsh.zip https://github.com/PowerShell/PowerShell/releases/download/v%PWSH_CORE_VERSION%/PowerShell-%PWSH_CORE_VERSION%-win-x64.zip && \
#  mkdir "C:\pwsh" && \
#  tar.exe -xf pwsh.zip -C "C:\pwsh"

# Download docker-gen(-windows) in specified version
RUN curl.exe -kfSL -o docker-gen.exe https://github.com/ferdiozturk/docker-gen-windows/releases/download/%DOCKER_GEN_VERSION%/docker-gen.exe && \
  mkdir "C:\docker-gen" && \
  move docker-gen.exe C:\docker-gen

# Download openssl
RUN curl.exe -kfSL -o openssl.zip http://wiki.overbyte.eu/arch/openssl-1.1.1b-win64.zip && \
  mkdir "C:\openssl" && \
  tar.exe -xf openssl.zip -C "C:\openssl"

# Setting DOCKER_HOST on Windows is a little bit more complicated than under Linux
# Change the Docker "daemon.json" according to this URL before using 127.0.0.1:2375
# https://dille.name/blog/2017/11/29/using-the-docker-named-pipe-as-a-non-admin-for-windowscontainers/
ENV DOCKER_HOST tcp://host.docker.internal:2375

COPY nginx.tmpl .

#ENTRYPOINT ["docker-gen.exe"]
ENTRYPOINT ["cmd"]
