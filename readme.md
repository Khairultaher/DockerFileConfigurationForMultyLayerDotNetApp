### Docker file configuration for multy layer .NET app as well as  Run Image & Container 
```
## build image
docker build -t weatherforecast-img .
# with version
docker build -t weatherforecast-img:v1 . 

## check available images
docker images

## create and run container
docker run -p 39177:80 -p 44391:443 weatherforecast-con
# with name & image named version
docker run --name weatherforecast-con -p 39177:80 -p 44391:443 weatherforecast-img:v1
# with name & image latest version
docker run --name weatherforecast-con -p 39177:80 -p 44391:443 weatherforecast-img

http://localhost:39177/weatherforecast
https://localhost:44391/weatherforecast

```