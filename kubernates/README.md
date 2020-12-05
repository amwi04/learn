### Kubernetes 
- https://github.com/ACloudGuru-Resources/Course_Kubernetes_Deep_Dive_NP

#### Networking

- All nodes can talk
- All pods can talk (No NAT)
- Every Pod gets its own IP

- service name and ip will never change 
- enpoint object has all the updated data to route to
* Eg:
```
apiVersion: v1
kind: Service               # This will ensure the service
metadata:
    name: wordpress         # which has to talk to wordpress ip or pod
    labels:
        app: wordpress
    spec:
        ports:
            - port: 80
        selector:
            app: wordpress
            tier: frontend
        type: LoadBalancer      # if its a api service this will contact to service providers loadbalancer and configure it for port 80 to route to app wordpress There are 3 type LoadBalancer public cloud platform,NodePort cluster wide port that service listen on (30,000 to 32,767),ClusterIP(default) it will give that service ip   

---

```

Pod network     - 10.0.0.0/16
Node network    - 192.168.0.0/16
Serivce Networl - 172.11.11.0/24

```
Kubernetes cluster

                Load balancer(SVC) IP:172.11.240.5

    ============================================================
    Pod network (10.0.0.0/16)
        |                   |                       |

 Node 10.0.1.9      Node 10.0.2.11          Node 10.0.3.40
                
    eth0                eth0                    eth0
     |                    |                       |
    ===========================================================

    Node network (192.168.0.0/16)

```

- everynode runs a process called kube-proxy which runs on everynode
- Its proxys into the network
```
kubectl get nodes

kubectl apply -f ./some.yaml

kubectl get deploy

kubectl get pods -o wide

kubectl exec -it some_pod_name

kubectl get svc

```

### Storage in Kubernetes

```
kubectl get pv
kubectl get pvc
```
- pv is persistance volume its a actual hardware conneted through kubernetes yaml 
- pvc persistance volume claim will be the pod which want to access this pv's in another yaml file

- In both yaml files accessMode,storageClassName,resource:storage has to match or it will fail claim can be less not more

- in app yamls use volumes and volume mount in mount path 

- in can have multiple storage class for auto scale check sc.yaml

```
kubectl apply -f sc.yaml
kubectl get sc  #storage cluster
kubectl create secret generic mysql-pass --from-literal=password=Pass123
```





