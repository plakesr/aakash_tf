/*
locals {
    default = ["${var.aws_name} PRIVATE A", "${var.aws_name} PRIVATE B"]
    }

data "aws_vpc" "demo" {
  filter {
    name   = "tag:Name"
    values = ["${var.aws_name} VPC"]
  }
}

data "aws_subnet_ids" "private_sub" {
  #count  = 1
  #id = "subnet-0c15ce44f675d6237"
  vpc_id = data.aws_vpc.demo.id
  #name   = "locals.default.${count.index}"
  #tags = {
   #Name =  "var.subnet_private.${count.index}" #"${var.aws_name} PRIVATE ${count.index}"
  #}
}

data "aws_subnet" "private_A" {
count = length(data.aws_subnet_ids.private_sub.ids)
  #for_each = data.aws_subnet_ids.private_A.ids
  id = data.aws_subnet_ids.private_sub.ids[count.index] #each.value
#tags = {
# Name = "${var.aws_name} Private ${count.index}"
}
#vpc_id = data.aws_vpc.demo.id
#filter {
#    name   = "tag:Name"
#    values = ["${var.aws_name} PRIVATE A"] # insert value here
#  }
#}

#data "aws_subnet" "private_B" {
#vpc_id = data.aws_vpc.demo.id
#filter {
#    name   = "tag:Name"
##    values = ["demo-vpc PRIVATE B"] #insert value here "^p.*11$" ["${var.aws_name}" "PRIVATE" "*"]
# }
#}

#resource "aws_db_subnet_group" "db_subnet" {
#name       = "db_subnet_group_name"
#subnet_ids = [data.aws_subnet.private_A.id, data.aws_subnet.private_B.id] #tolist(concat("${data.aws_subnet.private_A.id}", "${data.aws_subnet.private_B.id}")) 
##subnet_ids = data.aws_subnet.private_A.
#tags = {
#  Name = "db_subnet_group_name"
#  }
#}
*/




locals {
    private_subnet = [for subnet_info in data.aws_subnet.private_subnet: subnet_info.id if split(" ",subnet_info.tags.Name)[1] == "PRIVATE"]
}


data "aws_vpc" "demo" {
  filter {
    name   = "tag:Name"
    values = ["${var.aws_name} VPC"]
  }
}

data "aws_subnet_ids" "private_sub" {
  vpc_id = data.aws_vpc.demo.id
}

data "aws_subnet" "private_subnet" {
  count  = length(flatten(list(data.aws_subnet_ids.private_sub.ids)))
  id = flatten(list(data.aws_subnet_ids.private_sub.ids))[count.index]
}