{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "[[ application.name ]].crds.fullname" -}}
{{- printf "%s-%s" (include "[[ application.name ]].fullname" .) "crds" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "[[ application.name ]].crds.componentLabels" -}}
app.kubernetes.io/component: crds
{{- end -}}

{{/*
Common labels
*/}}
{{- define "[[ application.name ]].crds.labels" -}}
{{ include "[[ application.name ]].labels" . }}
{{ include "[[ application.name ]].crds.componentLabels" . }}
{{- end -}}
