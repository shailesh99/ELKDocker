#Docker Images
#Beats
#https://www.docker.elastic.co/r/beats/filebeat-oss


#Elasticsearh
#https://www.docker.elastic.co/r/elasticsearch/elasticsearch-oss

#Kibana
#https://www.docker.elastic.co/r/kibana/kibana-oss


docker pull docker.elastic.co/beats/filebeat-oss:7.10.2

#OSS
docker run -d \
--network elk_elastic \
--name filebeat \
docker.elastic.co/beats/filebeat-oss:7.10.2 \
"setup -E setup.kibana.host=kib01:5601 \
-E output.elasticsearch.hosts=["es01:9200"]"






filebeat -e -strict.perms=false \
  -E output.elasticsearch.hosts=["es01:9200"]


#Running this
docker run -d \
  --name=filebeat \
  --user=root \
  --network elk_elastic \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --volume="$(pwd)/data:/home/iislogs" \
docker.elastic.co/beats/filebeat-oss:7.10.2 /bin/bash -c "setup -E setup.kibana.host=kib01:5601 -E output.elasticsearch.hosts=\["es01:9200"\]; filebeat -e"  
  
  
  #filebeat modules enable iis


#docker.elastic.co/beats/filebeat-oss:7.10.2 setup -E setup.kibana.host=kib01:5601 -E output.elasticsearch.hosts=\["es01:9200"\] 
#docker.elastic.co/beats/filebeat-oss:7.10.2 filebeat -e -strict.perms=false -E output.elasticsearch.hosts=\["es01:9200"\]; \

#--volume="$(pwd)/iis.yml.disabled:/usr/share/filebeat/modules.d/iis.yml.disabled" \

#7.10.2
docker run -d \
  --name=filebeat2 \
  --network elk_elastic \
  --user=root \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  docker.elastic.co/beats/filebeat:7.10.2 filebeat -e -strict.perms=false -E output.elasticsearch.hosts=\["es01:9200"\]

#This Worked fb01
#Ref: https://www.bogotobogo.com/DevOps/Docker/Docker_ELK_7_6_Filebeat.php
  docker run --net=elk_elastic --name fb01 docker.elastic.co/beats/filebeat-oss:7.10.2 setup -E setup.kibana.host=kib01:5601 -E output.elasticsearch.hosts=\["es01:9200"\]

#fb02
  docker run -d \
  --name=fb02 \
  --user=root \
  --network=elk_elastic \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --volume="$(pwd)/data:/home/iislogs" \
  docker.elastic.co/beats/filebeat-oss:7.10.2 filebeat -e -strict.perms=false \
  -E output.elasticsearch.hosts=\["es01:9200"\]