docker build -t premrajai/multi-client-k8s:latest -t premrajai/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t premrajai/multi-server-k8s-pgfix:latest -t premrajai/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t premrajai/multi-worker-k8s:latest -t premrajai/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push premrajai/multi-client-k8s:latest
docker push premrajai/multi-server-k8s-pgfix:latest
docker push premrajai/multi-worker-k8s:latest

docker push premrajai/multi-client-k8s:$SHA
docker push premrajai/multi-server-k8s-pgfix:$SHA
docker push premrajai/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=premrajai/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=premrajai/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=premrajai/multi-worker-k8s:$SHA
