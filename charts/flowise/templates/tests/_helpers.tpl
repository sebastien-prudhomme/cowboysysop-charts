{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "flowise.tests.fullname" -}}
{{- printf "%s-%s" (include "flowise.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "flowise.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "flowise.tests.labels" -}}
{{ include "flowise.labels" . }}
{{ include "flowise.tests.componentLabels" . }}
{{- end -}}
