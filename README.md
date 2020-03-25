## HW_8
  Working with terraform

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
