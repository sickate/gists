# start a docker image registry
docker run -d \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:5001 \
  -p 5001:5001 \
  --name registry-test \
  registry:2


docker run -d -p 3000:3000 \
                -e "MB_DB_TYPE=postgres" \
                -e "MB_DB_DBNAME=metabase_qa" \
                -e "MB_DB_PORT=5432" \
                -e "MB_DB_USER=userx" \
                -e "MB_DB_PASS=userxpass" \
                -e "MB_DB_HOST=pg1" \
                --restart=always
                --name metabase metabase/metabase


# list dangling images
docker images -f 'dangling=true' -q

# delete dangling images/containers
# WARN: not tried!
docker rmi $(docker images -q)
docker rm $(docker ps -a -q)
