#!/bin/bash


is_docker_desktop_running() {
    if docker info &> /dev/null; then
        return 0
    else
        return 1
    fi
}


run_docker_desktop() {
    echo "starting docker desktop"
    powershell.exe -Command "& { Start-Process -FilePath 'C:\\Program Files\\Docker\\Docker\\Docker Desktop.exe' -WindowStyle Hidden }"
}


if ! is_docker_desktop_running; then
    run_docker_desktop
fi


until is_docker_desktop_running; do
    sleep 2
done


echo "docker desktop is running"

cd ..

docker build -t insight-api-gateway .

docker run -p 5000:5000 insight-api-gateway
