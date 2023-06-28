import jinja2
import os
import pathlib
import shutil
import sys
import yaml

templates_directory = f"{pathlib.Path(__file__).parent}/templates"
charts_directory = f"{pathlib.Path(__file__).parent}/charts"

jinja2_environment = jinja2.Environment(
    block_start_string="[%",
    block_end_string="%]",
    variable_start_string="[[",
    variable_end_string="]]",
    keep_trailing_newline=True,
    extensions=["jinja2_strcase.StrcaseExtension"],
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

    templates_directory = f"{chart_directory}/templates"
    os.mkdir(templates_directory)

    # Manage extra
    render("templates/extra-list.yaml", f"{templates_directory}/extra-list.yaml", application=application)

    components = application["components"]

    for component in components:
        # Manage component
        component_name = component["name"]

        if component_name != name:
            component_directory = f"{templates_directory}/{component_name}"
            os.mkdir(component_directory)

        print(component)

        # Manage Ingress
        if component.get("ingress"):
          if component_name == name:
              render("templates/ingress.yaml", f"{templates_directory}/ingress.yaml", application=application, component=component)
          else:
              render("templates/component/ingress.yaml", f"{component_directory}/ingress.yaml", application=application, component=component)

        # Manage PersistentVolumeClaim
        if component.get("persistentvolumeclaim"):
          if component_name == name:
              render("templates/persistentvolumeclaim.yaml", f"{templates_directory}/persistentvolumeclaim.yaml", application=application, component=component)
          else:
              render("templates/component/persistentvolumeclaim.yaml", f"{component_directory}/persistentvolumeclaim.yaml", application=application, component=component)

        # Manage PodDisruptionBudget
        if component_name == name:
            render("templates/pdb.yaml", f"{templates_directory}/pdb.yaml", application=application, component=component)
        else:
            render("templates/component/pdb.yaml", f"{component_directory}/pdb.yaml", application=application, component=component)

        # Manage Service
        if component_name == name:
            render("templates/service.yaml", f"{templates_directory}/service.yaml", application=application, component=component)
        else:
            render("templates/component/service.yaml", f"{component_directory}/service.yaml", application=application, component=component)

        # Manage ServiceAccount
        if component_name == name:
            render("templates/serviceaccount.yaml", f"{templates_directory}/serviceaccount.yaml", application=application, component=component)
        else:
            render("templates/component/serviceaccount.yaml", f"{component_directory}/serviceaccount.yaml", application=application, component=component)
