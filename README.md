# ansible-multi-node-testing
Ansible used for running serialized testing between various nodes

## Provisioning two machines

We start by provisioning two machines following

https://www.redhat.com/en/blog/build-VM-fast-ansible

go to kvmlab/ and

```
ansible-playbook -K kvm_provision.yaml
```

That will create and run one vm for testing, named fc42-lab01


```
sudo virsh domifaddr f42-lab01
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet0      52:54:00:80:ff:3c    ipv4         192.168.124.168/24

 sudo bash -c 'echo 192.168.124.168 lab01 >> /etc/hosts'
```

Test connectivity with 'ssh -i ~/.ssh/id_ed25519 root@192.168.124.168'

Repeat for lab02, rerunning the role with:

```
ansible-playbook -K kvm_provision.yaml -e vm=f42-lab02
```

Retrieving the ip address with
```
sudo virsh domifaddr f42-lab02
[sudo] password for pablo:
 Name       MAC address          Protocol     Address
-------------------------------------------------------------------------------
 vnet1      52:54:00:a8:77:2a    ipv4         192.168.124.174/24
```

```
 sudo bash -c 'echo 192.168.124.174 lab02 >> /etc/hosts'
```

## Testing playbook

go to testing/ and replace the addresses in inventory.yml with the ip address
discovered above using virsh

then run

```
ansible-playbook -v -i inventory.yaml testing.yaml
```

The final check will fail, change the grep so it looks for what was sent from
one machine to the other using nc client

