Weather Application Containerization

1.apt install docker.io

2.sudo usermod -aG docker $USER

3.sudo systemctl status docker

4.sudo systemctl start docker

5.sudo docker build -t weather-app .

6.docker run -d -p 8080:80 --name my-weather-app weather-app:latest

7.Check running containers: docker ps (Should show your my-weather-app container)

8.Check all containers (including stopped): docker ps -a

9.View container logs: docker logs my-weather-app

10.Stop the container: docker stop my-weather-app

11.Start a stopped container: docker start my-weather-app

12.Remove a stopped container: docker rm my-weather-app

13.listing images: docker images
