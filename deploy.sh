if [ "$1" == "" ]; then
    echo "No SHA supplied"
    export SHA="$(git rev-parse HEAD)"
fi
echo $SHA
docker build -t christiandietrich/docker-complex-example-client:latest -t christiandietrich/docker-complex-example-client:$SHA ./client
docker build -t christiandietrich/docker-complex-example-server:latest -t christiandietrich/docker-complex-example-server:$SHA ./server
docker build -t christiandietrich/docker-complex-example-fibonacci-worker:latest -t christiandietrich/docker-complex-example-fibonacci-worker:$SHA ./worker
# Take those images and push them to docker hub
docker push christiandietrich/docker-complex-example-client:$SHA
docker push christiandietrich/docker-complex-example-client:latest
docker push christiandietrich/docker-complex-example-server:$SHA
docker push christiandietrich/docker-complex-example-server:latest
docker push christiandietrich/docker-complex-example-fibonacci-worker:$SHA
docker push christiandietrich/docker-complex-example-fibonacci-worker:latest

# Apply all configs in the k8s folder
#kubectl apply -f k8s
# Imperatively set latest images on each deployment
#kubectl set image deployments/server-deployment server=christiandietrich/docker-complex-example-server:$SHA
#kubectl set image deployments/client-deployment client=christiandietrich/docker-complex-example-client:$SHA
#kubectl set image deployments/worker-deployment worker=christiandietrich/docker-complex-example-fibonacci-worker:$SHA