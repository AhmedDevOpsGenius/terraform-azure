output "connection_string" {
  value = azurerm_sql_database.db.connection_string
}

output "database_name" {
  value = azurerm_sql_database.db.name
}

output "sql_server_fqdn" {
  value = azurerm_sql_server.server.fqdn
}

output "sql_server_location" {
  value = azurerm_sql_server.server.location
}

output "sql_server_name" {
  value = azurerm_sql_server.server.name
}

output "sql_server_version" {
  value = azurerm_sql_server.server.version
}
