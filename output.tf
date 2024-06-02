# Output the result of the Lambda invocation
output "result_entry" {
  value = jsondecode(data.aws_lambda_invocation.invoke_lambda.result)["body"]
}

output "result_fail" {
  value = jsondecode(data.aws_lambda_invocation.invoke_lambda_fail.result)["body"]
}