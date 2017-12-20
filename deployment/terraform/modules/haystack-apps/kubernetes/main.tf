module "span-timeseries-transformer" {
  source = "span-timeseries-transformer"
  image = "expediadotcom/haystack-span-timeseries-transformer:${var.trends_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
  kafka_endpoint = "${var.kafka_hostname}:${var.kafka_port}"
}
module "timeseries-transformer" {
  source = "timeseries-aggregator"
  image = "expediadotcom/haystack-timeseries-aggregator:${var.trends_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
  kafka_endpoint = "${var.kafka_hostname}:${var.kafka_port}"
}
module "pipes-json-transformer" {
  source = "pipes-json-transformer"
  image = "expediadotcom/haystack-pipes-json-transformer:${var.pipes_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
  graphite_hostname = "${var.kafka_hostname}"
  kafka_endpoint = "${var.kafka_hostname}:${var.kafka_port}"
}
module "pipes-kafka-producer" {
  source = "pipes-kafka-producer"
  image = "expediadotcom/haystack-pipes-kafka-producer:${var.pipes_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
  graphite_hostname = "${var.graphite_hostname}"
  kafka_endpoint = "${var.kafka_hostname}:${var.kafka_port}"
}

module "trace-reader" {
  source = "trace-reader"
  image = "expediadotcom/haystack-trace-reader:${var.traces_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
}
module "trace-indexer" {
  source = "trace-indexer"
  image = "expediadotcom/haystack-trace-indexer:${var.traces_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
  kafka_endpoint = "${var.kafka_hostname}:${var.kafka_port}"
}
module "ui" {
  source = "ui"
  image = "expediadotcom/haystack-ui:${var.ui_version}"
  replicas = "1"
  namespace = "${var.k8s_app_namespace}"
  k8s_cluster_name = "${var.k8s_cluster_name}"
}