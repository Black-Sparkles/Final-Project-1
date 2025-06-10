output "vpc_id" {
  value = aws_vpc.k8s_vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "kops_admin_public_ip" {
  value = aws_instance.kops_admin.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.kops_state_store.bucket
}

