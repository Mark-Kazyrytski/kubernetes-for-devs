{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "chart.labels" -}}
helm.sh/chart: {{ include "chart.chart" . }}
{{ include "chart.selectorLabels" . }}
current.date: {{ now | date "20060102150405" | quote }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
DB related labels
*/}}
{{- define "chart.db.labels" -}}
helm.sh/chart: {{ include "chart.chart" . }}
{{ include "chart.selectorLabels" . }}
current.date: {{ now | date "20060102150405" | quote }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ .Values.postgres.label }}
{{- end }}

{{/*
DB related labels
*/}}
{{- define "chart.secret.annotations" -}}
meta.helm.sh/release-name: {{ .Values.release.name }}
meta.helm.sh/release-namespace: {{ .Values.namespase }}
{{- end }}

{{- define "serviceappname" -}}
{{- $appName := default  .Chart.Name -}}
{{- printf "%s-%s-%s" $appName .Values.api "service" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "deploymentappname" -}}
{{- $appName := default .Chart.Name -}}
{{- printf "%s-%s-%s" $appName .Values.api "deployment" | trunc 63 | trimSuffix "-" -}}
{{- end -}}