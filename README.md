# Apache Marmotta Docker Container

A container for the [Apache Marmotta Linked Data Platform](https://marmotta.apache.org)

To startup a marmotta container on port localhost:8080 simply:

```
docker run -d -p 8080:8080  nicholsn/docker-marmotta
```

Then visit http://localhost:8080/marmotta

If you are running with boot2docker or via vagrant, you may want to change the hostname by:

```
curl -v -X POST -H "Content-Type: application/json" -d '["http://{HOSTNAME}:8080/marmotta"]' http://{HOSTNAME}:8080/marmotta/config/data/kiwi.context -u admin:pass123
curl -v -X POST -H "Content-Type: application/json" -d '["http://{HOSTNAME}:8080/marmotta"]' http://{HOSTNAME}:8080/marmotta/config/data/kiwi.context -u admin:pass123
```

Note that that username and password is `admin:pass123`, please change it once you have access.
