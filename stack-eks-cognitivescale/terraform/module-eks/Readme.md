In oreder to add new users to eks cluster:

1. open ./k8s/users/users.yaml

2. Fill in following block with needed info and add needed user in the section "mapUsers: |"
    - groups:
      - system:masters
      userarn: <ARN_OF_NEW_USER>
      username: <USERNAME>

3. Apply Kubectl file with following command:
    kubectl apply -f <PATH TO THIS YAML.file>