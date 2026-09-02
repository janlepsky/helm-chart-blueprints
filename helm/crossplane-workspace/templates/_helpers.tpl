{{/*
Expand the name of the chart.
*/}}
{{- define "crossplane-workspace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Name of the Workspace resource. Defaults to the release name so the managed
resource reads cleanly (e.g. "example-azure-rg"), with override escape hatches.
Truncated at 63 chars for the Kubernetes DNS naming limit.
*/}}
{{- define "crossplane-workspace.fullname" -}}
{{- default .Release.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "crossplane-workspace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "crossplane-workspace.labels" -}}
helm.sh/chart: {{ include "crossplane-workspace.chart" . }}
app.kubernetes.io/name: {{ include "crossplane-workspace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: crossplane-workspace
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Name of the Secret that receives the module outputs.
*/}}
{{- define "crossplane-workspace.connectionSecretName" -}}
{{- with .Values.workspace.writeConnectionSecretToRef.name }}
{{- . }}
{{- else }}
{{- printf "opentofu-workspace-%s" (include "crossplane-workspace.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
