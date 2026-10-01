{{/*
The Project name. Defaults to .Values.projectName, falling back to the release
name so the composite resource reads cleanly. Lowercased and truncated to the
63-char Kubernetes name limit.
*/}}
{{- define "project.name" -}}
{{- $name := default .Release.Name .Values.projectName -}}
{{- $name | lower | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Chart name and version as used by the chart label.
*/}}
{{- define "project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "project.labels" -}}
helm.sh/chart: {{ include "project.chart" . }}
app.kubernetes.io/name: {{ include "project.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: mogenius-project
{{- end }}
