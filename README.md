## Deriul_infra
Deriul Infra repository

## ProxyJump
The ProxyJump, or the -J flag, was introduced in ssh version 7.3. To use it, specify the bastion host to connect through after the -J flag, plus the remote host:
```
$ ssh -J <bastion-host> <remote-host>
```
You can also set specific usernames and ports if they differ between the hosts:
```
$ ssh -J user@<bastion:port> <user@remote:port>
```
## ProxyJump with one command
This could be easily achieved by modifying ~/.ssh/config

```
# OTUS The Bastion Host
Host bastion
 User appuser
 PreferredAuthentications publickey
 IdentityFile ~/.ssh/apuser.key
 HostName 35.185.231.46

# Otus The Remote Host
Host someinternalhost
 User appuser
 HostName 10.138.0.3
 ProxyJump bastion
 ```

## Hello travis
 bastion_IP = 35.185.231.46
 someinternalhost_IP = 10.138.0.3
