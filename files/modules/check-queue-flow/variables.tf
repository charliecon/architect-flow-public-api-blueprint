variable "did_numbers" {
    type = list(string)
    description = "The phone numbers that route to our flow (should be defined in order)"
}

variable "primary_queue_members_ids" {
    type        = list(string)
    description = "IDs of the members in the primary queue"
}

variable "secondary_queue_members_ids" {
    type        = list(string)
    description = "IDs of the members in the secondary queue"
}

