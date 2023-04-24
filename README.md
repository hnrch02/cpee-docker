# cpee-docker

Run the [Cloud Process Execution Engine (CPEE)](https://cpee.org/) in Docker.

## Prerequisites

- Docker + Docker Compose, the easiest way is to use [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- wget or git
- For Windows Users: [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install)

## Getting Started

The easiest way to get started is to use our prebuilt Docker images and Docker compose:

```bash
mkdir cpee && cd cpee
wget https://raw.githubusercontent.com/hnrch02/cpee-docker/main/docker-compose.yml
docker-compose up
```

You can now access your local CPEE at [http://localhost:8080](http://localhost:8080).

### Build it yourself

If no prebuilt image for your architecture is available, or you prefer building the image yourself:

```bash
git clone https://github.com/hnrch02/cpee-docker.git
cd cpee-docker
docker-compose up --build
```

## Windows

We strongly recommend using the [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) with your preferred Linux distribution (if you have none, use Ubuntu) to perform the steps listed above.

If you can't or don't want to use WSL, download the [`docker-compose.yml`](https://raw.githubusercontent.com/hnrch02/cpee-docker/main/docker-compose.yml) file manually and start it with `docker-compose up` in PowerShell.
