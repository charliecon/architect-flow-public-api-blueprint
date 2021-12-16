terraform {
    required_version = ">= 0.12"
    required_providers {
        genesyscloud = {
            source  = "mypurecloud/genesyscloud"
            version = "0.14.0"
        }
    }
}

provider "genesyscloud" {    
    sdk_debug = true
}

module "check_queue_flow" {
    source = "./modules/check-queue-flow"

    archy_flow_file_name        = "archy_flow.yml"
    did_numbers                 = ["+1 720-588-4555"]
    primary_queue_member_ids   = []
    secondary_queue_member_ids = [data.genesyscloud_user.user1.id, data.genesyscloud_user.user2.id]
}

data "genesyscloud_user" "user1" {
    email = "charlie.conneely@genesys.com"
}

data "genesyscloud_user" "user2" {
    email = "hollywoo+bojack.horseman@mydevspace.com"
}