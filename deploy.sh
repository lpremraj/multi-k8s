docker build -t lpremraj/multi-client-k8s:latest -t lpremraj/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t lpremraj/multi-server-k8s-pgfix:latest -t lpremraj/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t lpremraj/multi-worker-k8s:latest -t lpremraj/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push lpremraj/multi-client-k8s:latest
docker push lpremraj/multi-server-k8s-pgfix:latest
docker push lpremraj/multi-worker-k8s:latest

docker push lpremraj/multi-client-k8s:$SHA
docker push lpremraj/multi-server-k8s-pgfix:$SHA
docker push lpremraj/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lpremraj/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=lpremraj/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=lpremraj/multi-worker-k8s:$SHA