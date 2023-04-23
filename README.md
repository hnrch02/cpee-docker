# cpee-docker

Run [Cloud Process Execution Engine (CPEE)](https://cpee.org/) in Docker.

podman images
podman build -t test .

# for testing

podman run --rm -it -p 8298:8298 -p 8080:8080 test

# for testing

podman run --rm -p 8298:8298 -p 8080:8080 test
