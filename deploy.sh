docker build -t skete/multi-client:latest -t skete/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skete/multi-server:latest -t skete/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skete/multi-worker:latest -t skete/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skete/multi-client:latest
docker push skete/multi-server:latest
docker push skete/multi-worker:latest

docker push skete/multi-client:$SHA
docker push skete/multi-server:$SHA
docker push skete/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skete/multi-server:$SHA
kubectl set image deployments/client-deployment client=skete/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skete/multi-worker:$SHA