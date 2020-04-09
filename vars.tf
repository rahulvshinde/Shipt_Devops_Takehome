# variable "AWS_ACCESS_KEY" {
#   default = "AKIAXFLN6CRF6KAZJ5OU"
# }
# variable "AWS_SECRET_KEY" {
#   default = "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"
# }
variable "AWS_REGION" {
  default = "us-west-1"
}
variable "AMIS" {
  default = {
    us-west-1 = "ami-098f55b4287a885ba"
  }
}

# variable "cidrs" {
#   default = {
#     cidr1 = aws_vpc.main.main-private-1.name
#     cidr2 = aws_vpc.main.main-private-2.name
# }
