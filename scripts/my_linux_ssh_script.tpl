cat << EOF > scripts/ssh_to_vm.sh
#!/bin/bash
ssh -i ${identityfile} ${user}@${hostname}
EOF
