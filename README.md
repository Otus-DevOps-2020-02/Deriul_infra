## Deriul_infra
 This is the playground to help me become a better specialist
```
 Created [https://www.googleapis.com/compute/v1/projects/infra-271122/zones/us-west1-a/instances/reddit-app].
 NAME        ZONE        MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP    STATUS
 reddit-app  us-west1-a  g1-small                   10.138.0.8   35.233.176.37  RUNNING
```

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
  --metadata startup-script-url=https://raw.githubusercontent.com/Otus-DevOps-2020-02/Deriul_infra/cloud-testapp/startup.sh
```

## Travis CI check HW_6
 testapp_IP = 35.233.176.37
 testapp_port = 9292
