import jinja2
import os
import pathlib
import shutil
import subprocess
import sys
import yaml

templates_directory = f"{pathlib.Path(__file__).parent}/templates"
charts_directory = f"{pathlib.Path(__file__).parent}/charts"

jinja2_environment = jinja2.Environment(
    block_start_string="[%",
    block_end_string="%]",
    variable_start_string="[[",
    variable_end_string="]]",
    trim_blocks=True,
    lstrip_blocks=True,
    keep_trailing_newline=True,
    extensions=[
        "jinja2_ansible_filters.AnsibleCoreFiltersExtension",
        "jinja2_strcase.StrcaseExtension"
    ],
    loader=jinja2.FileSystemLoader(templates_directory)
)

def render(template_file, file, *args, **kwargs):
    template = jinja2_environment.get_template(template_file)
    output = template.render(*args, **kwargs)

    with open(file, "w") as stream:
        stream.write(output)

with open(sys.argv[1], "r") as stream:
    application = yaml.safe_load(stream)

    # Manage chart directory
    name = application["name"]

    chart_directory = f"{charts_directory}/{name}"

    if os.path.exists(chart_directory):
        shutil.rmtree(chart_directory)

    os.mkdir(chart_directory)

    render(".helmignore", f"{chart_directory}/.helmignore", application=application)
    render("Chart.yaml", f"{chart_directory}/Chart.yaml", application=application)

    if os.path.exists(f"applications/{name}/icon.png"):
        shutil.copyfile(f"applications/{name}/icon.png", f"{chart_directory}/icon.png")

    render("LICENSE", f"{chart_directory}/LICENSE", application=application)
    render("README.md", f"{chart_directory}/README.md", application=application)
    render("values.yaml", f"{chart_directory}/values.yaml", application=application)

    subprocess.run([
      "readme-generator",
      "--values",
      f"{chart_directory}/values.yaml",
      "--readme",
      f"{chart_directory}/README.md",
      "--config",
      f"{pathlib.Path(__file__).parent}/config.json"
    ])

    ci_directory = f"{chart_directory}/ci"
    os.mkdir(ci_directory)

    render("ci/default-values.yaml", f"{ci_directory}/default-values.yaml", application=application)

    templates_directory = f"{chart_directory}/templates"
    os.mkdir(templates_directory)

    render("templates/extra-list.yaml", f"{templates_directory}/extra-list.yaml", application=application)
    render("templates/NOTES.txt", f"{templates_directory}/NOTES.txt", application=application)

    # First rendered helper in case only non main components
    render("templates/_helpers.tpl", f"{templates_directory}/_helpers.tpl", application=application)

    if application.get("components"):
      components = application["components"]

      for component in components:
          # Manage component
          component_name = component["name"]

          if component_name != name:
              component_directory = f"{templates_directory}/{component_name}"
              os.mkdir(component_directory)

          # Manage helper
          if component_name == name:
              render("templates/_helpers.tpl", f"{templates_directory}/_helpers.tpl", application=application, component=component)
          else:
              render("templates/_helpers.tpl", f"{component_directory}/_helpers.tpl", application=application, component=component)

          # Manage ClusterRole/ClusterRoleBinding
          if component.get("clusterRole") or component.get("extraClusterRole"):
              if component_name == name:
                  render("templates/clusterrole.yaml", f"{templates_directory}/clusterrole.yaml", application=application, component=component)
                  render("templates/clusterrolebinding.yaml", f"{templates_directory}/clusterrolebinding.yaml", application=application, component=component)
              else:
                  render("templates/clusterrole.yaml", f"{component_directory}/clusterrole.yaml", application=application, component=component)
                  render("templates/clusterrolebinding.yaml", f"{component_directory}/clusterrolebinding.yaml", application=application, component=component)

          # Manage ConfigMap
          if component.get("configmap"):
              if component_name == name:
                  render("templates/configmap.yaml", f"{templates_directory}/configmap.yaml", application=application, component=component)
              else:
                  render("templates/component/configmap.yaml", f"{component_directory}/configmap.yaml", application=application, component=component)

          # Manage Deployment/Statefulset
          if component.get("deployment"):
              if component_name == name:
                  render(f"templates/deployment.yaml", f"{templates_directory}/{component['deployment']['type']}.yaml", application=application, component=component)
              else:
                  render(f"templates/deployment.yaml", f"{component_directory}/{component['deployment']['type']}.yaml", application=application, component=component)

          # Manage Ingress
          if component.get("ingress"):
              if component_name == name:
                  render("templates/ingress.yaml", f"{templates_directory}/ingress.yaml", application=application, component=component)
              else:
                  render("templates/component/ingress.yaml", f"{component_directory}/ingress.yaml", application=application, component=component)

          # Manage PersistentVolumeClaim
          if component["deployment"]["type"] == "deployment" and component.get("persistentvolumeclaim"):
              if component_name == name:
                  render("templates/persistentvolumeclaim.yaml", f"{templates_directory}/persistentvolumeclaim.yaml", application=application, component=component)
              else:
                  render("templates/component/persistentvolumeclaim.yaml", f"{component_directory}/persistentvolumeclaim.yaml", application=application, component=component)

          # Manage PodDisruptionBudget
          if component_name == name:
              render("templates/pdb.yaml", f"{templates_directory}/pdb.yaml", application=application, component=component)
          else:
              render("templates/pdb.yaml", f"{component_directory}/pdb.yaml", application=application, component=component)

          # Manage Secret
          if component.get("secret"):
              if component_name == name:
                  render("templates/secret.yaml", f"{templates_directory}/secret.yaml", application=application, component=component)
              else:
                  render("templates/component/secret.yaml", f"{component_directory}/secret.yaml", application=application, component=component)

          # Manage TLS Secret
          if component.get("tls"):
              if component_name == name:
                  render("templates/tls-secret.yaml", f"{templates_directory}/tls-secret.yaml", application=application, component=component)
              else:
                  render("templates/tls-secret.yaml", f"{component_directory}/tls-secret.yaml", application=application, component=component)

          # Manage Service
          if component.get("service"):
              if component_name == name:
                  render("templates/service.yaml", f"{templates_directory}/service.yaml", application=application, component=component)
              else:
                  render("templates/service.yaml", f"{component_directory}/service.yaml", application=application, component=component)

          # Manage Headless Service
          if component.get("headless"):
              if component_name == name:
                  render("templates/headless-service.yaml", f"{templates_directory}/headless-service.yaml", application=application, component=component)
              else:
                  render("templates/headless-service.yaml", f"{component_directory}/headless-service.yaml", application=application, component=component)

          # Manage Metrics Service
          if component.get("metrics") and component["metrics"].get("ports"):
              if component_name == name:
                  render("templates/metrics-service.yaml", f"{templates_directory}/metrics-service.yaml", application=application, component=component)
              else:
                  render("templates/metrics-service.yaml", f"{component_directory}/metrics-service.yaml", application=application, component=component)

          # Manage PodMonitor
          if component.get("podMonitor"):
              if component_name == name:
                  render("templates/podmonitor.yaml", f"{templates_directory}/podmonitor.yaml", application=application, component=component)
              else:
                  render("templates/podmonitor.yaml", f"{component_directory}/podmonitor.yaml", application=application, component=component)

          # Manage ServiceAccount
          if component_name == name:
              render("templates/serviceaccount.yaml", f"{templates_directory}/serviceaccount.yaml", application=application, component=component)
          else:
              render("templates/serviceaccount.yaml", f"{component_directory}/serviceaccount.yaml", application=application, component=component)

          # Manage ServiceMonitor
          if component.get("serviceMonitor"):
              if component_name == name:
                  render("templates/servicemonitor.yaml", f"{templates_directory}/servicemonitor.yaml", application=application, component=component)
              else:
                  render("templates/servicemonitor.yaml", f"{component_directory}/servicemonitor.yaml", application=application, component=component)

          # Manage HPA
          if component.get("hpa"):
              if component_name == name:
                  render("templates/hpa.yaml", f"{templates_directory}/hpa.yaml", application=application, component=component)
              else:
                  render("templates/hpa.yaml", f"{component_directory}/hpa.yaml", application=application, component=component)

          # Manage VPA
          if component.get("vpa"):
              if component_name == name:
                  render("templates/vpa.yaml", f"{templates_directory}/vpa.yaml", application=application, component=component)
              else:
                  render("templates/vpa.yaml", f"{component_directory}/vpa.yaml", application=application, component=component)

    # Manage CRDs
    if application.get("crds"):
        files_directory = f"{chart_directory}/files"
        os.makedirs(files_directory, exist_ok=True)

        files_crds_directory = f"{files_directory}/crds"
        shutil.copytree(f"applications/{name}/files/crds", files_crds_directory)

        crds_directory = f"{templates_directory}/crds"
        os.mkdir(crds_directory)

        render("templates/crds/_helpers.tpl", f"{crds_directory}/_helpers.tpl", application=application)
        render("templates/crds/clusterrolebinding.yaml", f"{crds_directory}/clusterrolebinding.yaml", application=application)
        render("templates/crds/clusterrole.yaml", f"{crds_directory}/clusterrole.yaml", application=application)
        render("templates/crds/configmap.yaml", f"{crds_directory}/configmap.yaml", application=application)
        render("templates/crds/job.yaml", f"{crds_directory}/job.yaml", application=application)
        render("templates/crds/serviceaccount.yaml", f"{crds_directory}/serviceaccount.yaml", application=application)

    # Manage Grafana dashboards
    if application.get("grafanaDashboards"):
        files_directory = f"{chart_directory}/files"
        os.makedirs(files_directory, exist_ok=True)

        files_grafana_dashboards_directory = f"{files_directory}/grafana-dashboards"
        shutil.copytree(f"applications/{name}/files/grafana-dashboards", files_grafana_dashboards_directory)

        render("templates/configmap-grafana-dashboards.yaml", f"{templates_directory}/configmap-grafana-dashboards.yaml", application=application)

    # Manage MariaDB
    if application.get("mariadb"):
        if application["mariadb"] == "optional":
            render("ci/mariadb-values.yaml", f"{ci_directory}/mariadb-values.yaml", application=application)

        render("templates/mariadb-secret.yaml", f"{templates_directory}/mariadb-secret.yaml", application=application)

    # Manage PostgreSQL
    if application.get("postgresql"):
        if application["postgresql"] == "optional":
            render("ci/postgresql-values.yaml", f"{ci_directory}/postgresql-values.yaml", application=application)

        render("templates/postgresql-secret.yaml", f"{templates_directory}/postgresql-secret.yaml", application=application)

    # Manage Prometheus rules
    if application.get("prometheusRules"):
        files_directory = f"{chart_directory}/files"
        os.makedirs(files_directory, exist_ok=True)

        files_prometheus_rules_directory = f"{files_directory}/prometheus-rules"
        shutil.copytree(f"applications/{name}/files/prometheus-rules", files_prometheus_rules_directory)

        render("templates/prometheusrule.yaml", f"{templates_directory}/prometheusrule.yaml", application=application)

    # Manage Redis
    if application.get("redis"):
        if application["redis"] == "optional":
            render("ci/redis-values.yaml", f"{ci_directory}/redis-values.yaml", application=application)

        render("templates/redis-secret.yaml", f"{templates_directory}/redis-secret.yaml", application=application)

    if application.get("tests"):
      tests_directory = f"{templates_directory}/tests"
      os.mkdir(tests_directory)

      render("templates/tests/_helpers.tpl", f"{tests_directory}/_helpers.tpl", application=application)
      render("templates/tests/configmap.yaml", f"{tests_directory}/configmap.yaml", application=application)
      render("templates/tests/pod.yaml", f"{tests_directory}/pod.yaml", application=application)

    # Manage Velero backups
    if application.get("veleroBackups"):
        render("templates/schedule-daily.yaml", f"{templates_directory}/schedule-daily.yaml", application=application)
        render("templates/schedule-hourly.yaml", f"{templates_directory}/schedule-hourly.yaml", application=application)
        render("templates/schedule-weekly.yaml", f"{templates_directory}/schedule-weekly.yaml", application=application)
        render("templates/schedule-monthly.yaml", f"{templates_directory}/schedule-monthly.yaml", application=application)
        render("templates/schedule-yearly.yaml", f"{templates_directory}/schedule-yearly.yaml", application=application)
