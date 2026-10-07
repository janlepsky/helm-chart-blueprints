{{/*
ArgoCD goTemplate passthrough helpers.

The ApplicationSet body contains ArgoCD goTemplate expressions ({{.number}} etc.)
that must survive Helm rendering untouched. These helpers emit the literal
double-brace expressions so Helm does not try to evaluate them.
*/}}
{{- define "pe.repoName" -}}{{ `{{.repoName}}` }}{{- end -}}
{{- define "pe.number" -}}{{ `{{.number}}` }}{{- end -}}
{{- define "pe.port" -}}{{ `{{.port}}` }}{{- end -}}
{{- define "pe.headShortSha" -}}{{ `{{.head_short_sha}}` }}{{- end -}}
{{- define "pe.branchNs" -}}{{ `{{.branch | replace "/" "-" | lower}}` }}{{- end -}}

{{/* Kyverno variable passthrough (keep Kyverno {{ }} literal through Helm) */}}
{{- define "pe.k.nsName" -}}{{ `{{ request.object.metadata.name }}` }}{{- end -}}
{{- define "pe.k.targetIds" -}}{{ `{{ target.spec.resources[].id }}` }}{{- end -}}
{{- define "pe.k.op" -}}{{ `{{ request.operation }}` }}{{- end -}}

{{/* Common labels */}}
{{- define "pe.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}
