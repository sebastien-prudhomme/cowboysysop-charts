{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "dependency-track.tests.fullname" -}}
{{- printf "%s-%s" (include "dependency-track.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "dependency-track.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dependency-track.tests.labels" -}}
{{ include "dependency-track.labels" . }}
{{ include "dependency-track.tests.componentLabels" . }}
{{- end -}}
