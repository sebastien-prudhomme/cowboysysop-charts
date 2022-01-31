{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kserve.crds.fullname" -}}
{{- printf "%s-%s" (include "kserve.fullname" .) "crds" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kserve.crds.componentLabels" -}}
app.kubernetes.io/component: crds
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kserve.crds.labels" -}}
{{ include "kserve.labels" . }}
{{ include "kserve.crds.componentLabels" . }}
{{- end -}}
