#!/usr/bin/env bash

echo current dir $(pwd)
echo =====

echo root $(ls -la /)
echo =====

echo github dir $(ls -la /github)
echo =====

echo github dir $(ls -la /github)
echo =====

# Login to Kubernetes Cluster.
if [ -n "$CLUSTER_ROLE_ARN" ]; then
    aws eks \
        --region ${AWS_REGION} \
        update-kubeconfig --name ${CLUSTER_NAME} \
        --role-arn=${CLUSTER_ROLE_ARN}
else
    aws eks \
        --region ${AWS_REGION} \
        update-kubeconfig --name ${CLUSTER_NAME}
fi

# Helm Deployment
helm plugin install https://github.com/databus23/helm-diff
APPLY_COMMAND="helmfile -e $DEPLOY_ENVIRONMENT sync"
echo "Executing: ${APPLY_COMMAND}"
${APPLY_COMMAND}
