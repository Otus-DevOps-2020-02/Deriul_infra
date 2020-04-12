gcloud compute instances create reddit-full\
  --boot-disk-size=20GB \
  --image-family reddit-full \
  --image-project=infra-271122 \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
