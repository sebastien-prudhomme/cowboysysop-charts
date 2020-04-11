{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "jitsi-meet.jicofo.fullname" -}}
{{- printf "%s-%s" (include "jitsi-meet.fullname" .) "jicofo" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "jitsi-meet.jicofo.componentLabels" -}}
app.kubernetes.io/component: jicofo
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.jicofo.labels" -}}
{{ include "jitsi-meet.labels" . }}
{{ include "jitsi-meet.jicofo.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jitsi-meet.jicofo.selectorLabels" -}}
{{ include "jitsi-meet.selectorLabels" . }}
{{ include "jitsi-meet.jicofo.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.jicofo.serviceAccountName" -}}
{{- if .Values.jicofo.serviceAccount.create -}}
    {{ default (include "jitsi-meet.jicofo.fullname" .) .Values.jicofo.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jicofo.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "jitsi-meet.jicofo.secretName" -}}
{{- if .Values.jicofo.existingSecret -}}
    {{ .Values.jicofo.existingSecret }}
{{- else -}}
    {{ include "jitsi-meet.jicofo.fullname" . }}
{{- end -}}
{{- end -}}
