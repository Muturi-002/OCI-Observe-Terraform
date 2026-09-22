# OCI-Observe-Terraform
This is a simple project that seeks to define infrastructure with provision of monitoring capabilities to the cloud/infra/devops engineer/architect. This will be implemented via manual creation of resources, monitoring resources and alarms, followed by a Terraform scripts for automating such a provision. This project will also delve into state management and module configuration.

Cloud provider: [OCI](https://registry.terraform.io/providers/oracle/oci/)

## Key characteristics of this project
1. Dedicated compartment, user group and user, with minimal policies in place.
2. OCI Terraform remote state management and locking.

## Project Structure

```
├── Bucket-objects.png
├── Deleted-objects.png
├── notes.md                            # Documentation/ Note taken on setup
├── README.md
├── Terminal-output-on-objects.png
└── terraform
    ├── backend-storage.tf              # Remote backend storage setup
    ├── cloud-init.sh                   
    ├── compute.tf                      # Instance setup
    ├── datasources.tf                  # Get sources
    ├── main.tf                         # modules configuration
    ├── network.tf                      # Network setup
    ├── outputs.tf                      
    ├── provider.tf
    ├── variables.tf
    ├── identity
    │   ├── iam.tf                      # IAM setup 
    │   ├── outputs.tf
    │   └── variables.tf
    └── Observability-config            # Monitoring and alarm setup
        ├── alarms.tf
        ├── monitor.tf
        ├── notifications.tf
        └── variables.tf
```

## OCI Services Provisioned/Used
- Infrastructure: Instances (1), VCN (1), Object Storage (1, *optional*)
- IAM: Compartment (1), User Group (1), Policies
- Monitoring: Notifications (Topic (1), Subscription (1)), Alarm (1), Metrics


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
    tenancy_ocid="<tenancy_ocid>"
    tenancy_region="<tenancy_region>"
    user_ocid="<user_ocid>"
    fingerprint="<fingerprint>"             # Generated via the OCI CLI command `oci session config`
    path_to_key_file="<path_to_key_file>"   # Generated via the CLI command `oci session authenticate`
    compartment_ocid="<compartment_ocid>"
    vm_instance_shape="<vm_instance_shape>" # e.g., VM-Standard-2.1
    vm_instance_OS="<vm_instance_OS>"       # e.g., Ubuntu 20.04, Oracle Linux 9/8/10
    instance_ssh_key='public_key_contents' # Optional, VM can be accessed via its remote console/console connection from the web console

    objectstorage_namespace="<OCI_OS_Namespace>
    ```
2. Certain variables, `observability-user` and `user_email`, have to be included in the variable file under the root module so as to be used as intended. Create a text file with this variables.
    ```
    observability_user="<dedicated_user_account_name>"
    user_email="<email_of_user>"
    ```
2. Run these commands
    ```bash
    terraform init
    terraform plan  --var-file=<name_of_text_file>.txt
    terraform apply  --var-file=<name_of_text_file>.txt       # Optional to add '--auto-approve' if you are sure of your desired configurations
    ```
3. Monitor your costs, then destroy your infrastructure.
    ```bash
    terraform destroy --auto-approve --var-file=<name_of_text_file>.txt
    ```

Check the [Notes file](./notes.md) on the remote state management configuration.
