FROM docker.elastic.co/beats/filebeat-oss:7.10.2
CMD filebeat -e -strict.perms=false