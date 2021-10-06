{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.volumesWebApp.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "volumes-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.volumesWebApp.componentLabels" -}}
app.kubernetes.io/component: volumes-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.volumesWebApp.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.volumesWebApp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.volumesWebApp.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.volumesWebApp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.volumesWebApp.serviceAccountName" -}}
{{- if .Values.volumesWebApp.serviceAccount.create -}}
    {{ default (include "kubeflow.volumesWebApp.fullname" .) .Values.volumesWebApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.volumesWebApp.serviceAccount.name }}
{{- end -}}
{{- end -}}
