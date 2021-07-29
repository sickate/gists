# create mapping template
curl -XPUT "http://alpha:9200/_template/ip-ua-matching" -H 'Content-Type: application/json' -d'
{
  "index_patterns": "ip-ua-matching-*",
  "settings": {
    "number_of_replicas": 1,
    "number_of_shards": 5
  },
  "mappings": {
    "_doc": {
      "_source": {
        "enabled": true
      },
      "properties": {
        "device_id":{
          "type": "keyword"
        },
        "ip_address": {
          "type": "ip"
        },
        "ua": {
          "type": "text"
        }
      }
    }
  }
}'


# list all pipelines
GET _ingest/pipeline







# doc indexes

# search docs
GET ip-ua-matching-wexin/_doc/_search

# complex search
GET ip-ua-matching-pbs/_search
{
  "query": {
    "bool": {
      "must": [
        { "match": { "ip_address":   "180.109.26.150"} },
        { "match": { "user_agent.name.keyword": "Chrome Mobile WebView" } }
      ]
    }
  }
}

# indexing docs with pipeline defined
PUT ip-ua-matching-wexin/_doc/d5387258af8f84406a1ff044877dd476?pipeline=hy-event-pipeline
{
    "device_id" : "d5387258af8f84406a1ff044877dd476",
    "ip_address" : "112.64.68.13",
    "ua" : "HUAWEI-VTR-AL00__weibo__9.6.0__android__android7.0"
}



