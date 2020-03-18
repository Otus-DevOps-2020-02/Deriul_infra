## Deriul_infra
 This is the playground to help me become a better specialist

## Create FW Rule
```
gcloud compute --project=infra-271122 firewall-rules create puma-9292 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```

## Deploooooooy the instance
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure\
  --metadata startup-script-url=https://github.com/Otus-DevOps-2020-02/Deriul_infra/blob/cloud-testapp/startup.sh
```

## Travis CI check HW_6
 testapp_IP = ???
 testapp_port = 9292
