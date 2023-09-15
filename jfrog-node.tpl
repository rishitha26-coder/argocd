apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: @@SHORT_NAME@@-{{ .Values.apps.environment }}"
  annotations:
    notifications.argoproj.io/subscribe.on-sync-succeeded.slack: devops-argocd
spec:
  destination:
    name: {{ .Values.apps.mogoCluster }}
    namespace: @@NAMESPACE@@
  source:
    repoURL: 'https://mogo.jfrog.io/artifactory/helm-nonprod/'
    chart: {{ .Values.apps.name }}
    targetRevision: @@REVISION@@
  project: {{ .Values.apps.project }}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
