#!/bin/sh

export changes=$(git diff HEAD~1 --name-only | xargs dirname | sort | uniq)
for b in $changes 
  do
  echo "------"
  file="./${b}/version.yaml"
  if [ -f "$file" ]; then echo $b 
  repo=$(yq '.repo' $file)
  chart=$(yq '.chart' $file)
  version=$(yq '.version' $file)
  release=$(yq '.release' $file)
  namespace=$(yq '.namespace' $file)
  helm repo add "${b}-repo" $repo
  helm repo update "${b}-repo"

  file2="./${b}/values.yaml"
  if [ -f "$file2" ]; 
  then 
    helm upgrade --install $release -n $namespace "${b}-repo"/$chart --version=$version -f $file2
  else
    helm upgrade --install $release -n $namespace "${b}-repo"/$chart --version=$version
  fi
  fi
done
