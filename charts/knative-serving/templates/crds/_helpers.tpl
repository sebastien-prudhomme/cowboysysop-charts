{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "knative-serving.crds.fullname" -}}
{{- printf "%s-%s" (include "knative-serving.fullname" .) "crds" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "knative-serving.crds.componentLabels" -}}
app.kubernetes.io/component: crds
{{- end -}}

{{/*
Common labels
*/}}
{{- define "knative-serving.crds.labels" -}}
{{ include "knative-serving.labels" . }}
{{ include "knative-serving.crds.componentLabels" . }}
{{- end -}}
