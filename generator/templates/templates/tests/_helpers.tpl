{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "[[ application.name ]].tests.fullname" -}}
{{- printf "%s-%s" (include "[[ application.name ]].fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "[[ application.name ]].tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "[[ application.name ]].tests.labels" -}}
{{ include "[[ application.name ]].labels" . }}
{{ include "[[ application.name ]].tests.componentLabels" . }}
{{- end -}}
