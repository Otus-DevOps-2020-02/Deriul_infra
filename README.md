# HW_11 ansible-2
  Working with absible 2.9.6

  We use plugin: 'gcp_compute' to create dynamic invenroty (see inventory.compute.gcp.example)
  We created multiple playboks and tested several different deployment scenarous:
    - one playbook with one scenario
    - one playbook with multiple scenarios
    - multiple playbooks

  We repacked our Packer images using ansible instead of shell commands

# HW_10 ansible-1
  Working with absible 2.9.6

  In this HW we made an initial ansible configuration.
  The difference in json schema is described here https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html in "Tuning the external inventory script" section

# HW_9 terraform-2
  Working with terraform 0.12

# As usual, there is nothing challenging except the starred task
  Problems to solve:
    a) Make unique names for resorces in different environments
    b) Make cross-module db_internal_ip transition
    c) Make bool variable to decide if we want to deploy and configure our app

  Solutions:
    First off, we do not want our instances to be recreated every time we make a change
```
~ initialize_params {
~ image  = "https://www.googleapis.com/compute/v1/.../images/reddit-db-1585320863" -> "reddit-db-base" # forces replacement
```
  Let's hardcode our image:
```
variable db_disk_image {
description = "Disk image for reddit db"
default     = "reddit-db-1585507673"
}
```

## Problem A
  Solved by adding a suffix in root module
```
variable env {}

module "app" {
  env_sfx        = var.env
}
```
  and passing it into app.module
```
resource "google_compute_instance" "app_with_puma" {
  name         = "${lower(var.env_sfx)}-reddit-app"
```

## Problem B
  Do not be like me, use "template_file" not "file", read https://alexharv074.github.io/2019/11/23/adventures-in-the-terraform-dsl-part-x-templates.html#template-providers--21

  You probably also want to rebuild db image with
```
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
```

## Problem C
  Solved by adding
```
count = var.dep_sw ? 1 : 0
```
## HW_8 terraform-1
  Working with terraform 0.12

# Problem with SSH
  If we try and get commonInstanceMetadata, we see that there is no actual key-value storage for ssh keys, all the keys are listed in items.value together.
```
"commonInstanceMetadata": {
    "fingerprint": "SY_FZfnpC_s=",
    "kind": "compute#metadata",
    "items": [
      {
        "value": "appuser:ssh-rsa AAAAB3Nza...mZhwZrunx appuser",
        "key": "ssh-keys"
      }
    ]
  },
  ```
   Therefore, terraform can only keep valid state of ssh-keys if: a) it has never been modified outside of teraform b) it is always modified entirely.

# Problem with LB
  Due to monolithic application structure, data consistency is hardly achievable.

# Other issues
  a) ssh-keys must be optional (will check how to do it later)
  b) yes, I know, main.tf should be divided into modules
  c) no, at this time I'm too lazy to write clean code
  d) I should have used migs
