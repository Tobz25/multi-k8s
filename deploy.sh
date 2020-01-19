docker build -t tldevoteam/multi-client:latest -t tldevoteam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tldevoteam/multi-server:latest -t tldevoteam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tldevoteam/multi-worker:latest -t tldevoteam/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tldevoteam/multi-client:latest
docker push tldevoteam/multi-server:latest
docker push tldevoteam/multi-worker:latest

docker push tldevoteam/multi-client:$SHA
docker push tldevoteam/multi-server:$SHA
docker push tldevoteam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tldevoteam/multi-server:$SHA
kubectl set image deployments/client-deployment client=tldevoteam/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tldevoteam/multi-worker:$SHA