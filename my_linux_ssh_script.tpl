cat < EOF > ../ssh_to_vm.sh
ssh -i ${identityfile} ${user}@${hostname}
EOF
