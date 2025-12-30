#!/bin/bash

param=$1
varsPath="../terraform/creds.tfvars"
path="../terraform"

cd $path

case $param in
    "init")
        terraform $param
        ;;
    "fmt")
        terraform $param -recursive
        ;;
    "validate")
        terraform $param
        ;;
    "plan")
        terraform $param -var-file=$varsPath 
        ;;
    "apply")
        terraform $param -var-file=$varsPath --auto-approve
        ;;
    "destroy")
        terraform $param -var-file=$varsPath --auto-approve
        ;;
    "rm")
        terraform destroy -var-file=$varsPath --auto-approve && terraform state $param $(terraform state list)
        ;;
    *)
        echo "Please use terraform options > init,fmt,validate,plan,apply,destroy,rm"
        ;;
esac
