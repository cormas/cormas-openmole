# Cormas OpenMole Integration

Runs Cormas models in [OpenMOLE](https://openmole.org). OpenMOLE receives a model as a zip of its folder, and `cormas.oms` defines the `CormasTask` that runs it in the Docker image `oleks42/cormas-openmole`. See the [tutorial](https://cormas.org/openmole) and the workflows in `examples`.

| Tag | Cormas | Model file |
|---|---|---|
| `latest`, `1.0-dev` | the `dev` branch | a zip of the model folder |
| `0.98` | v0.98 | a `.cmx` file, with the `cormas.oms` of the tag `v0.98` of this repository |

Push changes to Dockerhub. `CORMAS_VERSION` is a branch, a tag or a commit of Cormas, `dev` by default:

```bash
docker buildx build \
  --no-cache \
  --platform linux/amd64,linux/arm64 \
  --build-arg CORMAS_VERSION=dev \
  -t oleks42/cormas-openmole:1.0-dev \
  -t oleks42/cormas-openmole:latest \
  --push .
```

Run one simulation in the image, without OpenMOLE, from a folder holding the zip of a model:

```bash
docker run --rm -v "$PWD":/work oleks42/cormas-openmole:latest bash -c \
  '/app/run.sh /work/Firefighters.zip initSelector=basicCreation stepSelector=basicStep maxSteps=50000 stopCondition=areAllExtinguished seed=1 parameter:numberOfFirefighters=5 probe:currentTimeStep && cat /app/results.json'
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
docker run --privileged -p 8080:8080 -h openmole -v ~/Documents/tmp/openmole:/var/openmole/ openmole/openmole:24.0
```

If it complains about the `.lock` file, manually create the `hash` directory:

```bash
docker exec -it 34e341f5f2e7 bash
```

Then inside `root@openmole:/# `:

```bash
mkdir -p /var/openmole/.openmole/openmole/persistent/container/repos/oleks42/cormas-openmole/latest/hash
```
