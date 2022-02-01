docker build -t premium/multi-client-k8s:latest -t premium/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t premium/multi-server-k8s-pgfix:latest -t premium/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t premium/multi-worker-k8s:latest -t premium/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push premium/multi-client-k8s:latest
docker push premium/multi-server-k8s-pgfix:latest
docker push premium/multi-worker-k8s:latest

docker push premium/multi-client-k8s:$SHA
docker push premium/multi-server-k8s-pgfix:$SHA
docker push premium/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=premium/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=premium/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=premium/multi-worker-k8s:$SHA
