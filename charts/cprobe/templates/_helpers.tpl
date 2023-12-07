{{/*
Expand the name of the chart.
*/}}
{{- define "cprobe.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "cprobe.namespace" -}}
{{- default .Release.Namespace  -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cprobe.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cprobe.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cprobe.labels" -}}
helm.sh/chart: {{ include "cprobe.chart" . }}
{{ include "cprobe.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cprobe.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cprobe.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cprobe.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cprobe.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create configmaps mount into deployment
*/}}
{{- define "cprobe.deployment.mountConfig" -}}
{{- range $item, $plugin := .Values.plugins }}
{{- $pluginName := $item }}
{{ if $plugin }}
- name: cprobe-{{ $pluginName }}-config
  mountPath: /app/conf.d/{{ $pluginName }}
{{- end}}
{{- end}}
{{- end }}

{{/*
Create configmaps volumes for deployment mountConfig
*/}}
{{- define "cprobe.deployment.mountConfigVolumes" -}}
{{- range $item, $plugin := .Values.plugins }}
{{- $pluginName := $item }}
{{ if $plugin }}
- name: {{ $.Release.Name }}-{{ $pluginName }}-config
  configMap:
    name: {{ $.Release.Name }}-{{ $pluginName }}
{{- end}}
{{- end}}
{{- end }}
