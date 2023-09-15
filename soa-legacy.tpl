apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: "@@SHORT_NAME@@-{{ .Values.apps.environment }}"
  annotations:
    notifications.argoproj.io/subscribe.on-sync-succeeded.slack: devops-argocd
spec:
  destination:
    name: {{ .Values.apps.mogoCluster }}
    namespace: {{ .Values.apps.mogoNamespace }}
    server: '' # No need to pass if using name
  source:
    path: "{{ .Values.apps.repoDir }}/{{ .Values.apps.name }}/{{ .Values.apps.environment }}" # used only if the path of chart repo is different from chart variable
    repoURL: {{ .Values.apps.repo }}
    targetRevision: {{ .Values.apps.revision }}
    helm:
      valueFiles: 
        - ../../../Values/{{ .Values.apps.name }}/values-{{ .Values.apps.environment }}.yaml
  project: {{ .Values.apps.project }}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
