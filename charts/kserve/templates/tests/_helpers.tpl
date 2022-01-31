{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kserve.tests.fullname" -}}
{{- printf "%s-%s" (include "kserve.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kserve.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kserve.tests.labels" -}}
{{ include "kserve.labels" . }}
{{ include "kserve.tests.componentLabels" . }}
{{- end -}}
