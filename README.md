# OCI-Observe-Terraform
This is a simple project that seeks to define infrastructure with provision of monitoring capabilities to the cloud/infra/devops engineer/architect. This will be implemented via manual creation of resources, event rules and alarms, followed by a Terraform scripts for automating such a provision. This project will also delve into state management.

Cloud provider: OCI

## Project Structure (In Design)

```
├── terraform
│   ├── terraform.tfstate.backup
│   ├── provider.tf
│   ├── datasources.tf
│   ├── terraform.tfvars
│   ├── Observability-config
│   │   ├── logs
│   │   ├── notifications.tf
│   │   └── monitor.tf
│   ├── terraform.tfstate
│   ├── compute.tf
│   ├── network.tf
│   ├── outputs.tf
│   └── variables.tf
├── .gitignore
└── README.md
```

## Steps
### *Prerequisites* 
- OCI CLI installed on your local machine
- Terraform v1.15.x or higher
- Have an updated list of active session profiles both in the `~/.oci/config` file. The profiles have fingerprints, API Keys that are used by Terraform to communicate with OCI when creating, provisioning and deploying infrastructure. To add an API Key,
    * login to your cloud console
    * Click on your profile icon and select `User settings` from the pop-up menu.
    * Navigate to `Tokens and Keys` and click on `Add API Key`
    * From your local machine, navigate to the OCI config file and copy a fingerprint from one of the user profiles, and paste it in the cloud console under the previous step.

1. Navigate to the directory `terraform/`, and create a new file, `terraform.tfvars`, with the following variables to be filled:
    ```hcl
    tenancy_ocid='<tenancy_ocid>'
    tenancy_region='<tenancy_region>'
    user_ocid='<user_ocid>'
    fingerprint='<fingerprint>'             # Generated via the OCI CLI command `oci session config`
    path_to_key_file="<path_to_key_file>"   # Generated via the CLI command `oci session authenticate`
    compartment_ocid=<compartment_ocid>
    vm_instance_shape='<vm_instance_shape>' # e.g., VM-Standard-2.1
    vm_instance_OS='<vm_instance_OS>'       # e.g., Ubuntu 20.04, Oracle Linux 9/8/10
    instance_ssh_key='private_key_contents' # Optional, VM can be accessed via its remote console/console connection from the web console
    ```
2. Run these commands
    ```bash
    terraform init
    terraform plan
    terraform apply         # Optional to add '--auto-approve' if you are sure of your desired configurations
    ```
3. Monitor your costs, then destroy your infrastructure.
    ```hcl
    terraform destroy --auto-approve
    ```

