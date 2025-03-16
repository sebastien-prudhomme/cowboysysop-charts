ASSETS="
https://raw.githubusercontent.com/monitoring-mixins/website/refs/heads/master/assets/cert-manager/dashboards/overview.json;applications/cert-manager-common/files/grafana-dashboards/overview.json
https://raw.githubusercontent.com/monitoring-mixins/website/refs/heads/master/assets/cert-manager/alerts.yaml;applications/cert-manager-common/files/prometheus-rules/alerts.yaml
"

for asset in ${ASSETS}; do
  source=$(echo "${asset}" | cut -f 1 -d ";")
  destination=$(echo "${asset}" | cut -f 2 -d ";")

  curl ${source} -o ${destination}
done
