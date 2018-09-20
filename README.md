EC2 Provisioning and Termination with Terraform
=======================

An experiment of provisioning and termination of AWS EC2 instances with Terraform.

Requirements
------------

- AWS private key
- Shared credentials file with AWS keys (default location: ~/.aws/credentials)

Dependencies
------------

AWS (Free Tier) account.

Example #1
------------

$ terraform init
$ terraform plan
$ terraform apply

...

Plan: 9 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

...

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Example #2
------------

$ terraform destroy

...

Plan: 0 to add, 0 to change, 9 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

...

Destroy complete! Resources: 9 destroyed.
