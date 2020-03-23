## HW_7
  Working woth packer

## Build image
```
packer build -var-file=variables.json ubuntu16.json
```
  or
```
packer build \
--var 'project_id=infra-271122' \
--var 'source_image_family=ubuntu-1604-lts' \
ubuntu16.json
```
  Available variables are listed in variables.json.examle
  project_id and source_image_family are mandatory

## Deploy instance
```
gcloud compute instances create reddit-full\
  --boot-disk-size=20GB \
  --image-family reddit-full \
  --image-project=infra-271122 \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
```
