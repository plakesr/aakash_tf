data "aws_vpc" "demo" {
filter {
    name = "tag:Name"
    values = ["${var.aws_name} VPC"]
  }
}

data "aws_subnet_ids" "private_A" {
  vpc_id = data.aws_vpc.demo.id
}

data "aws_subnet" "private_A" {
#  for_each = data.aws_subnet_ids.private_A.ids
##  id = each.value
 tags = {
   Name = "${var.aws_name} Private ${count.index}"
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
