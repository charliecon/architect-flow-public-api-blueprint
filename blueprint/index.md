---
title: Integrate a public API call into an Architect flow
author: charlie.conneely
indextype: blueprint
icon: blueprint
image: 
category: 5
summary: |
  This Genesys Cloud Developer Blueprint provides an example of how to integrate a public API call into an Architect flow to check if any agents are available on a given queue and make routing decisions based on the outcome. 
--- 

This Genesys Cloud Developer Blueprint provides an example of how to integrate a public API call into an Architect flow to check if any agents are available on a given queue and make routing decisions based on the outcome.

### Instructions

- Save [this exported architect flow file](https://github.com/charliecon/architect-flow-public-api-blueprint/blob/main/files/archy_flow.yml) to the same directory as your `main.tf` file.

- Import the remote module
```hcl
module "check_queue_flow" {
    source = "github.com/charliecon/architect-flow-public-api-blueprint//files/modules/check-queue-flow"

    archy_flow_file_name        = "<archy file name>.yml"
    did_numbers                 = ["+1 234-567-8910"]
    primary_queue_member_ids   = []
    secondary_queue_member_ids = ["<user ID>"]
}
```

- From your terminal, run:
```
$ terraform init
$ terraform apply --auto-approve
```