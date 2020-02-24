docker build -t diablo1031/multi-client -f ./client/Dockerfile ./client
docker build -t diablo1031/multi-server -f ./server/Dockerfile ./server
docker build -t diablo1031/multi-worker -f ./worker/Dockerfile ./worker
docker push diablo1031/multi-client
docker push diablo1031/multi-server
docker push diablo1031/multi-worker
kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=diablo1031/multi-server