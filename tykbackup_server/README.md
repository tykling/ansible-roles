Role to configure a tykbackup server/jail - the server receiving the backups (backup "target").

Define the following variables:

tykbackup_authorized_keys is a list of a dict for each server being backed up, each dict having a "comment", a "fromip" and an "authkey" attribute:
```
tykbackup_authorized_keys:
  - comment "someserver.example.com"
    fromip: "192.0.2.233"
    authkey: "ssh-ed25519 AAAAC3......:"
```

Create a ZFS dataset to keep the backups in (and add it to the jail where applicable), set tykbackup_zfs_dataset to the name (not mountpoint):

```tykbackup_zfs_dataset: "tank/backups"```

Add the following special permissions for the backup jail:

```allow.mount.zfs=1 enforce_statfs=1```

