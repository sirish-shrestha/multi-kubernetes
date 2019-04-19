docker build -t sirishshr/multi-client:latest -t sirishshr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sirishshr/multi-server -t sirishshr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sirishshr/multi-worker -t sirishshr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sirishshr/multi-client:latest
docker push sirishshr/multi-server:latest
docker push sirishshr/multi-worker:latest

docker push sirishshr/multi-client:$SHA
docker push sirishshr/multi-server:$SHA
docker push sirishshr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sirishshr/multi-server:$SHA 
kubectl set image deployments/client-deployment client=sirishshr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sirishshr/multi-worker:$SHA