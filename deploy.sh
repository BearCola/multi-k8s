docker build -t diablo1031/multi-client:latest -t diablo1031/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diablo1031/multi-server:latest -t diablo1031/multi-client:$SHA -f ./server/Dockerfile ./server
docker build -t diablo1031/multi-worker:latest -t diablo1031/multi-client:$SHA -f ./worker/Dockerfile ./worker

docker push diablo1031/multi-client:latest
docker push diablo1031/multi-server:latest
docker push diablo1031/multi-worker:latest

docker push diablo1031/multi-client:$SHA
docker push diablo1031/multi-server:$SHA
docker push diablo1031/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=diablo1031/multi-server:$SHA
kubectl set image deployments/client-deployment client=diablo1031/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diablo1031/multi-worker:$SHA