{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeflow.mpiOperator.fullname" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "mpi-operator" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeflow.mpiOperator.componentLabels" -}}
app.kubernetes.io/component: mpi-operator
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubeflow.mpiOperator.labels" -}}
{{ include "kubeflow.labels" . }}
{{ include "kubeflow.mpiOperator.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kubeflow.mpiOperator.selectorLabels" -}}
{{ include "kubeflow.selectorLabels" . }}
{{ include "kubeflow.mpiOperator.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubeflow.mpiOperator.serviceAccountName" -}}
{{- if .Values.mpiOperator.serviceAccount.create -}}
    {{ default (include "kubeflow.mpiOperator.fullname" .) .Values.mpiOperator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.mpiOperator.serviceAccount.name }}
{{- end -}}
{{- end -}}
