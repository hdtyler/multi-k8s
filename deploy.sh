docker build -t hdtyler/multi-client:latest -t hdtyler/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hdtyler/multi-server:latest -t hdtyler/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hdtyler/multi-worker:latest -t hdtyler/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hdtyler/multi-client:latest
docker push hdtyler/multi-server:latest
docker push hdtyler/multi-worker:latest

docker push hdtyler/multi-client:$SHA
docker push hdtyler/multi-server:$SHA
docker push hdtyler/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=hdtyler/client-deployment:$SHA
kubectl set image deployments/server-deployment server=hdtyler/server-deployment:$SHA
kubectl set image deployments/worker-deployment worker=hdtyler/worker-deployment:$SHA