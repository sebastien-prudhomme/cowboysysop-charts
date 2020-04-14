{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "scaleway-csi.node.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.fullname" .) "node" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "scaleway-csi.node.metrics.fullname" -}}
{{- printf "%s-%s" (include "scaleway-csi.node.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "scaleway-csi.node.componentLabels" -}}
app.kubernetes.io/component: node
{{- end -}}

{{/*
Common labels
*/}}
{{- define "scaleway-csi.node.labels" -}}
{{ include "scaleway-csi.labels" . }}
{{ include "scaleway-csi.node.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "scaleway-csi.node.selectorLabels" -}}
{{ include "scaleway-csi.selectorLabels" . }}
{{ include "scaleway-csi.node.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "scaleway-csi.node.serviceAccountName" -}}
{{- if .Values.node.serviceAccount.create -}}
    {{ default (include "scaleway-csi.node.fullname" .) .Values.node.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.node.serviceAccount.name }}
{{- end -}}
{{- end -}}
