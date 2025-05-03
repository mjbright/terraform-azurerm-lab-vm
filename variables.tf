
variable resource_group {
  type        = "string"
  description = "The name of the resource group in which to create the resources."
  nullable    = false
}
variable prefix {
  type        = "string"
  description = "Name resources prefixed by this value"
  nullable    = false
}
variable location {
  type        = "string"
  description = "Azure location/region where resources are to be created"
  nullable    = false
}

variable hostname {
  type        = "string"
  description = "VM name"
  nullable    = false
}
variable dns_name {
  type        = "string"
  description = "Label for the Domain Name - used to make up the FQDN."
  nullable    = false
}

variable admin_username {
  type        = "string"
  description = "administrator user name"
  nullable    = false
}
variable admin_priv_key {
  type        = "string"
  description = "administrator private key (disable password auth)"
  nullable    = false
}

variable subnet_id {
  type        = "string"
  description = "ID of subnet to attach to"
  nullable    = false
}

variable vm_size {
  type        = "string"
  description = "Specifies the size of the virtual machine."
  nullable    = false
}

# IMAGES: Can search for images using 'az vm image list' command:
variable image_publisher {
  type        = "string"
  description = "name of the publisher of the image"
  default     = "Canonical"
}
variable image_offer {
  type        = "string"
  description = "the name of the offer"
  default     = "0001-com-ubuntu-confidential-vm-focal"
}
variable image_sku {
  type        = "string"
  description = "image sku to apply"
  default     = "20_04-lts-cvm"
}
variable image_version {
  type        = "string"
  description = "version of the image"
  default     = "20.04.202306140"
}

variable tags {
  type        = "map(string)"
  description = "Tags to apply to resources"
  default     = {}
}
