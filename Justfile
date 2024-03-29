etcd *cmd:
  @echo "etcd {{cmd}}"
  @etcdctl --cacert ./share/etcd-ca.crt --cert ./share/etcd-admin.crt \
    --key ./share/etcd-admin.key \
    --endpoints=https://192.168.56.2:2379,https://192.168.56.3:2379,https://192.168.56.4:2379 \
    {{cmd}}
