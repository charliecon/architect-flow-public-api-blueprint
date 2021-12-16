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

module "check_queue_data_action" {
    source                        = "./modules/data-actions"
    data_actions_integration_name = "Genesys Cloud Data Actions"
}

module "primary_queue" {
    source           = "./modules/queues"
    name             = "Primary Queue 1"
    description      = "The primary queue called from 'Queue Members Check' inbound call flow."
    queue_member_ids = []
}

module "secondary_queue" {
    source           = "./modules/queues"
    name             = "Secondary Queue 1"
    description      = "The secondary queue called from 'Queue Members Check' inbound call flow."
    queue_member_ids = [data.genesyscloud_user.user1.id, data.genesyscloud_user.user2.id]
}

module "call_ivr" {
    source            = "./modules/ivr"
    architect_flow_id = data.genesyscloud_flow.my_flow.id
    did_numbers       = ["+1 720-588-4553"]
}

resource "null_resource" "deploy_archy_flow" {
    depends_on = [
        module.primary_queue,
        module.secondary_queue,
        module.check_queue_data_action
    ]
    provisioner "local-exec" {
        command = "archy publish --forceUnlock --file Queue-Members-Check.yml --clientId $GENESYSCLOUD_OAUTHCLIENT_ID --clientSecret $GENESYSCLOUD_OAUTHCLIENT_SECRET --location $GENESYSCLOUD_ARCHY_REGION"
    }
}

data "genesyscloud_flow" "my_flow" {
    depends_on = [null_resource.deploy_archy_flow]
    name       = "Queue Members Check"
}

data "genesyscloud_user" "user1" {
    email = "charlie.conneely@genesys.com"
}

data "genesyscloud_user" "user2" {
    email = "hollywoo+bojack.horseman@mydevspace.com"
}