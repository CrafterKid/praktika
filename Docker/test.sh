runPostgres() {
    docker run -d \
        --name postgres \
        -p 5432:5432 \
        -e POSTGRES_USER=program \
        -e POSTGRES_PASSWORD=test \
        -e POSTGRES_DB=todo_list \
        --volume postgres-data:/var/lib/postgresql/data \
        --network=network-backend \
        postgres:13
}

runBackend() {
    docker run -d \
        --name backend \
        -e SPRING_PROFILES_ACTIVE=docker \
        -p 8080:8080 \
        --network=network-backend \
        backend:v1.0

        docker network connect --alias backend-service network-frontend bakend
}

runFrontend() {
    docker run -d \
        --name frontend \
        -p 3000:80 \
        --network=network-frontend \
        frontend:v1.0
}        
