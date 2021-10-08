{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.jupyterWebApp.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "jupyter-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.jupyterWebApp.componentLabels" -}}
app.kubernetes.io/component: jupyter-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.jupyterWebApp.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.jupyterWebApp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.jupyterWebApp.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.jupyterWebApp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.jupyterWebApp.serviceAccountName" -}}
{{- if .Values.jupyterWebApp.serviceAccount.create -}}
    {{ default (include "kubeflow.jupyterWebApp.fullname" .) .Values.jupyterWebApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jupyterWebApp.serviceAccount.name }}
{{- end -}}
{{- end -}}
