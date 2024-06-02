output "result_entry" {
  value = jsondecode(data.aws_lambda_invocation.invoke_lambda.result)["key1"]
}