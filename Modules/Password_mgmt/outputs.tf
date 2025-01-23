output "windows_vm" {
  value = var.resource_type == "windows_vm" ? random_password.win_vm_pwd[0].result : null
  sensitive = true
}

output "linux_vm" {
  value = var.resource_type == "linux_vm" ? tls_private_key.linux_ssh_key[0].public_key_openssh : null
  sensitive = true
}