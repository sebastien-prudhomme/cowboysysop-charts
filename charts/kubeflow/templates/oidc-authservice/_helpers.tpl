{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.oidcAuthservice.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "oidc-authservice" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kubeflow.oidcAuthservice.metrics.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.oidcAuthservice.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.oidcAuthservice.componentLabels" -}}
app.kubernetes.io/component: oidc-authservice
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.oidcAuthservice.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.oidcAuthservice.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.oidcAuthservice.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.oidcAuthservice.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.oidcAuthservice.serviceAccountName" -}}
{{- if .Values.oidcAuthservice.serviceAccount.create -}}
    {{ default (include "kubeflow.oidcAuthservice.fullname" .) .Values.oidcAuthservice.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.oidcAuthservice.serviceAccount.name }}
{{- end -}}
{{- end -}}
