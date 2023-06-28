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

    components = application["components"]

    for component in components:
        # Manage component
        component_name = component["name"]

        component_directory = f"{templates_directory}/{component_name}"
        os.mkdir(component_directory)

        # Manage PodDisruptionBudget
        pdb_template = jinja2_environment.get_template("templates/component/pdb.yaml")
        pdb_output = pdb_template.render(application=application, component=component)

        with open(f"{component_directory}/pdb.yaml", "w") as pdb_stream:
            pdb_stream.write(pdb_output)

#         serviceaccount_template = jinja2_environment.get_template(
#             "templates/component/serviceaccount.yaml"
#         )
#         serviceaccount_output = serviceaccount_template.render(
#             chart=generator_yaml, component=component
#         )

#         with open(
#             f"{component_directory}/serviceaccount.yaml", "w"
#         ) as serviceaccount_stream:
#             serviceaccount_stream.write(serviceaccount_output)
