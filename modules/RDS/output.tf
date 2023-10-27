output "primary_rds_id" {
  value = aws_db_instance.primary_rds.id
}
output "primary_rds_identifier" {
  value = aws_db_instance.primary_rds.identifier
}
output "standby_rds_id" {
  value = aws_db_instance.standby_rds.*.id
}
output "standby_rds_identifier" {
  value = aws_db_instance.standby_rds.*.identifier
}