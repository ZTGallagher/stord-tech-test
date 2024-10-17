{{- define "sre-technical-challenge.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "sre-technical-challenge.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}-{{ .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end }}

{{- define "sre-technical-challenge.chart" -}}
{{- .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "sre-technical-challenge.labels" -}}
app.kubernetes.io/name: {{ include "sre-technical-challenge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
