  
output "api_gateway_id" {
  value = aws_api_gateway_rest_api.api-gateway.id
}

output "api_gateway_arn" {
  value = aws_api_gateway_rest_api.api-gateway.arn
}