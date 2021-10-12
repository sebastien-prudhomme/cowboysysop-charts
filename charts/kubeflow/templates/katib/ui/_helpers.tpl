{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.katib.ui.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "katib-ui" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.katib.ui.componentLabels" -}}
app.kubernetes.io/component: katib-ui
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.katib.ui.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.katib.ui.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.katib.ui.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.katib.ui.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.katib.ui.serviceAccountName" -}}
{{- if .Values.katib.ui.serviceAccount.create -}}
    {{ default (include "kubeflow.katib.ui.fullname" .) .Values.katib.ui.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.katib.ui.serviceAccount.name }}
{{- end -}}
{{- end -}}
