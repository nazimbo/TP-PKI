docker build -t my-apache .

docker run -d -p 80:80 -p 443:443 --name my-apache-container my-apache
