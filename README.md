# HW_9
  Working with terraform 0.12

# As usual, there is nothing challenging except the starred task
  Problems to solve:
    a) Make unique names for resorces in different environments
    b) Make cross-modure db_internal_ip transition
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
  Solved by adding a suffix in root module...
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
sudo sed -i 's/0.0.0.2/0.0.0.0/g' /etc/mongod.conf
```

## Problem C
  Solved by adding
```
count = var.dep_sw ? 1 : 0
```
