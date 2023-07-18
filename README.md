# Cloud Workstations Customer Image
Document how to prepare a custom image for Cloud Workstations - Start with JIT and Native Java

## Build a costum Docker image with Java 17 and Oracle GraalVM 17.0.8+9.1 (latest LTS)
```shell
docker build . -t <ArtifactRegistry-regional>/<Your-Project-ID>/workstations/custom-native:1.0.0

# Ex.:
docker build . -t us-central1-docker.pkg.dev/optimize-serverless-apps/workstations/custom-native:1.0.0
```

*Push the image to Artifact Registry*
```shell
docker push <ArtifactRegistry-regional>/<Your-Project-ID>/workstations/custom-native:1.0.0

# Ex.:
docker push us-central1-docker.pkg.dev/optimize-serverless-apps/workstations/custom-native:1.0.0
```

## Build a costum Docker image with Java 20 and GraalVM 20.0.0)
Update the ```011_customize-user.sh``` by uncomenting the Java 20 environment variables

```shell
docker build . -f Dockerfile-Java20 -t <ArtifactRegistry-regional>/<Your-Project-ID>/workstations/custom-native-20:1.0.0

# Ex.:
docker build . -f Dockerfile-Java20 -t us-central1-docker.pkg.dev/optimize-serverless-apps/workstations/custom-native-20:1.0.0
```

*Push the image to Artifact Registry*
```shell
docker push <ArtifactRegistry-regional>/<Your-Project-ID>/workstations/custom-native-20:1.0.0

# Ex.:
docker push us-central1-docker.pkg.dev/optimize-serverless-apps/workstations/custom-native-20:1.0.0
```

*Configure the Cloud Workstations Configuration*
- [documentation](https://cloud.google.com/workstations)
- for Native Java images, allocate a larger size machine for increased performance