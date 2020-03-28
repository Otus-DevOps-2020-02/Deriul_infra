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
default     = "reddit-db-1585320863"
}
```
## Problem A
  A

## Problem B
  B

## Problem C
  C