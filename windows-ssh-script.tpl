add-content -path c:users/<user_name>/.ssh/config -value @'

Host ${hostname}
  HostName ${hostname}
  User ${user}
  IdentiyFile ${identityfile}
  '@
