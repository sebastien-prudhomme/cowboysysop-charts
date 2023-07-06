{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "[[ application.name ]].name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "[[ application.name ]].fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
[%- if component.headless %]

{{/*
Create a default fully qualified headless name.
*/}}
{{- define "[[ application.name ]].headless.fullname" -}}
{{- printf "%s-%s" (include "[[ application.name ]].fullname" .) "headless" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
[%- endif %]

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "[[ application.name ]].chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "[[ application.name ]].labels" -}}
helm.sh/chart: {{ include "[[ application.name ]].chart" . }}
{{ include "[[ application.name ]].selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "[[ application.name ]].selectorLabels" -}}
app.kubernetes.io/name: {{ include "[[ application.name ]].name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "[[ application.name ]].serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "[[ application.name ]].fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
[%- if component.secret %]

{{/*
Create the name of the secret to use
*/}}
{{- define "[[ application.name ]].secretName" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecret }}
{{- else -}}
    {{ include "[[ application.name ]].fullname" . }}
{{- end -}}
{{- end -}}

[[ component.secretKeyHelpers | trim ]]
[%- endif %]
[%- if application.mariadb %]

{{/*
MariaDB fully qualified app name
*/}}
{{- define "[[ application.name ]].mariadb.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
MariaDB host
*/}}
{{- define "[[ application.name ]].mariadb.host" -}}
{{- if .Values.mariadb.enabled -}}
{{- if eq .Values.mariadb.architecture "replication" -}}
    {{- if .Values.mariadb.fullnameOverride -}}
    {{- printf "%s-%s" .Values.mariadb.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "[[ application.name ]].mariadb.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalMariadb.host }}
{{- end -}}
{{- end -}}

{{/*
MariaDB port
*/}}
{{- define "[[ application.name ]].mariadb.port" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.primary.service.ports.mysql }}
{{- else -}}
    {{ .Values.externalMariadb.port }}
{{- end -}}
{{- end -}}

{{/*
MariaDB user
*/}}
{{- define "[[ application.name ]].mariadb.username" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.username }}
{{- else -}}
    {{ .Values.externalMariadb.username }}
{{- end -}}
{{- end -}}

{{/*
MariaDB secret name
*/}}
{{- define "[[ application.name ]].mariadb.secretName" -}}
{{- if .Values.mariadb.auth.existingSecret -}}
    {{ .Values.mariadb.auth.existingSecret }}
{{- else if .Values.externalMariadb.existingSecret -}}
    {{ .Values.externalMariadb.existingSecret }}
{{- else -}}
    {{ include "[[ application.name ]].mariadb.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
MariaDB password secret key name
*/}}
{{- define "[[ application.name ]].mariadb.secretKeyNamePassword" -}}
{{- if .Values.externalMariadb.existingSecret -}}
    {{ .Values.externalMariadb.existingSecretKeyPassword }}
{{- else -}}
    mariadb-password
{{- end -}}
{{- end -}}

{{/*
MariaDB database
*/}}
{{- define "[[ application.name ]].mariadb.database" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.database }}
{{- else -}}
    {{ .Values.externalMariadb.database }}
{{- end -}}
{{- end -}}
[%- endif %]
[%- if application.postgresql %]

{{/*
PostgreSQL fully qualified app name
*/}}
{{- define "[[ application.name ]].postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL host
*/}}
{{- define "[[ application.name ]].postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- if eq .Values.postgresql.architecture "replication" -}}
    {{- if .Values.postgresql.fullnameOverride -}}
    {{- printf "%s-%s" .Values.postgresql.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "[[ application.name ]].postgresql.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalPostgresql.host }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL port
*/}}
{{- define "[[ application.name ]].postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.primary.service.ports.postgresql }}
{{- else -}}
    {{ .Values.externalPostgresql.port }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL user
*/}}
{{- define "[[ application.name ]].postgresql.username" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.auth.username }}
{{- else -}}
    {{ .Values.externalPostgresql.username }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL secret name
*/}}
{{- define "[[ application.name ]].postgresql.secretName" -}}
{{- if .Values.postgresql.existingSecret -}}
    {{ .Values.postgresql.existingSecret }}
{{- else if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecret }}
{{- else -}}
    {{ include "[[ application.name ]].postgresql.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL password secret key name
*/}}
{{- define "[[ application.name ]].postgresql.secretKeyNamePassword" -}}
{{- if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecretKeyPassword }}
{{- else -}}
    password
{{- end -}}
{{- end -}}

{{/*
PostgreSQL database
*/}}
{{- define "[[ application.name ]].postgresql.database" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.auth.database }}
{{- else -}}
    {{ .Values.externalPostgresql.database }}
{{- end -}}
{{- end -}}
[%- endif %]
