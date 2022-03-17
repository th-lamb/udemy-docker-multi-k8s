# Build the images with the 2 tags (latest and Git-SHA)
docker build -t tlambeck/udemy-docker-multi-client:latest -t tlambeck/udemy-docker-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tlambeck/udemy-docker-multi-server:latest -t tlambeck/udemy-docker-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tlambeck/udemy-docker-multi-worker:latest -t tlambeck/udemy-docker-multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push (all tags) to Docker Hub
docker push tlambeck/udemy-docker-multi-client:latest
docker push tlambeck/udemy-docker-multi-server:latest
docker push tlambeck/udemy-docker-multi-worker:latest
docker push tlambeck/udemy-docker-multi-client:$SHA
docker push tlambeck/udemy-docker-multi-server:$SHA
docker push tlambeck/udemy-docker-multi-worker:$SHA

# Apply the configs in folder k8s
kubectl apply -f k8s/
kubectl set image deployments/client-deployment client=tlambeck/udemy-docker-multi-client:$SHA
kubectl set image deployments/server-deployment server=tlambeck/udemy-docker-multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tlambeck/udemy-docker-multi-worker:$SHA
