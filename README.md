# Raspberry Pi automated configuration

This repo contains an ansible automation to reconfigure my raspberry every time I decide to format de SD card.

## Installing Rasbian

Download the latest version from [here](https://www.raspberrypi.org/downloads/raspbian/)

1. unmount the SD card, than copy the image to the card.

```bash
diskutil unmount /dev/disk2
unzip -p 2020-02-13-raspbian-buster-lite.zip | sudo dd of=/dev/disk2 bs=4m
diskutil mount /dev/disk2
touch /Volumes/boot/ssh # to enable ssh
```

2. Run the initialize ansible playbook

```bash
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook initialize.yaml -i inventories/thspinto
```

3. Run the setup playbook

```bash
ansible-galaxy install -r requirements.yml
ansible-playbook setup.yaml -i inventories/thspinto
```

## References

[Chester's ansible configs](https://github.com/chesterbr/chester-ansible-configs)

[Ansible NAS configuration](https://github.com/davestephens/ansible-nas)
