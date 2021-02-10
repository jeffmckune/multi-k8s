docker build -t jeffmckune/multi-client:latest -t jeffmckune/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffmckune/multi-server:latest -t jeffmckune/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffmckune/multi-worker:latest -t jeffmckune/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeffmckune/multi-client:latest
docker push jeffmckune/multi-server:latest
docker push jeffmckune/multi-worker:latest

docker push jeffmckune/multi-client:$SHA
docker push jeffmckune/multi-server:$SHA
docker push jeffmckune/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jeffmckune/multi-server:$SHA
kubectl set image deployments/client-deployment server=jeffmckune/multi-client:$SHA
kubectl set image deployments/worker-deployment server=jeffmckune/multi-worker:$SHA
