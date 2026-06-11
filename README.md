# Cormas OpenMole Integration

Push changes to Dockerhub:

```bash
docker buildx build \                 
  --no-cache \
  --platform linux/amd64,linux/arm64 \
  -t oleks42/cormas-openmole:latest \
  --push .
```

Update the container on OpenMole (it is cached so we have to restart it for changes to take effect). First find the container id of OpenMole:

```bash
docker ps
```
Then stop it:

```bash
docker stop d88aed95192e
```

Start OpenMole again:

```bash
docker run --privileged -p 8080:8080 -h openmole -v ~/Documents/tmp/openmole:/var/openmole/ openmole/openmole:22.1
```

If it complains about the `.lock` file, manually create the `hash` directory:

```bash
docker exec -it 34e341f5f2e7 bash
```

Then inside `root@openmole:/# `:

```bash
mkdir -p /var/openmole/.openmole/openmole/persistent/container/repos/oleks42/cormas-openmole/latest/hash
```