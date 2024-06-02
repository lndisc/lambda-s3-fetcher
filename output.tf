output "result_entry" {
  value = jsondecode(data.aws_lambda_invocation.example.result)["key1"]
}