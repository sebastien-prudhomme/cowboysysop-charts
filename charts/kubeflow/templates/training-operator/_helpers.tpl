{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.trainingOperator.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "training-operator" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kubeflow.trainingOperator.metrics.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.trainingOperator.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.trainingOperator.componentLabels" -}}
app.kubernetes.io/component: training-operator
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.trainingOperator.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.trainingOperator.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.trainingOperator.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.trainingOperator.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.trainingOperator.serviceAccountName" -}}
{{- if .Values.trainingOperator.serviceAccount.create -}}
    {{ default (include "kubeflow.trainingOperator.fullname" .) .Values.trainingOperator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.trainingOperator.serviceAccount.name }}
{{- end -}}
{{- end -}}
