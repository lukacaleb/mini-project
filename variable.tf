variable "ami" {
    default = "ami-0e5f882be1900e43b"
    type = string
}

variable "type" {
    default = "t2.micro"
    type = string
}

variable "key_pair" {
  default = "london-key-pair.pem"
}

variable "availability_zone" {
    type = map(any)
    default = {
      "a" = "eu-west-2a"
      "b" = "eu-west-2b"
    }
  
}