{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.katib.dbManager.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "katib-db-manager" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.katib.dbManager.componentLabels" -}}
app.kubernetes.io/component: katib-db-manager
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.katib.dbManager.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.katib.dbManager.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.katib.dbManager.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.katib.dbManager.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.katib.dbManager.serviceAccountName" -}}
{{- if .Values.katib.dbManager.serviceAccount.create -}}
    {{ default (include "kubeflow.katib.dbManager.fullname" .) .Values.katib.dbManager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.katib.dbManager.serviceAccount.name }}
{{- end -}}
{{- end -}}
