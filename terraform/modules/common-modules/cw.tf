resource "aws_cloudwatch_log_group" "this" {
  for_each = var.cwName != null ? { create = var.cwName } : {}
  
  name              = each.value
}
