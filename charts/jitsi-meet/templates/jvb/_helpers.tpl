{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "jitsi-meet.jvb.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "jvb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "jitsi-meet.jvb.componentLabels" -}}
app.kubernetes.io/component: jvb
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.jvb.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jvb.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jitsi-meet.jvb.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jvb.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.jvb.serviceAccountName" -}}
{{- if .Values.jvb.serviceAccount.create -}}
    {{ default (include "jitsi-meet.jvb.fullname" .) .Values.jvb.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jvb.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "jitsi-meet.jvb.secretName" -}}
{{- if .Values.jvb.existingSecret -}}
    {{ .Values.jvb.existingSecret }}
{{- else -}}
    {{ include "jitsi-meet.jvb.fullname" . }}
{{- end -}}
{{- end -}}
