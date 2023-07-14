variable "subscription_id" {
  default = "any"
}

variable "client_id" {
  default = "any"
}

variable "client_secret" {
  default = "any"
}

variable "tenant_id" {
  default = "any"
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}