#!/bin/bash
if [ ! -f ./salsa/config/secrets.yml ]; then
  echo -e "\nGenerating a secrets.yml file"

  # Random Keys
  KEY_DEV=$(sudo docker-compose run salsa rake secret)
  KEY_TEST=$(sudo docker-compose run salsa rake secret)

  # Generate the file
  cat > ./salsa/config/secrets.yml <<EOL
development:
  secret_key_base: ${KEY_DEV}
test:
  secret_key_base: ${KEY_TEST}
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
EOL
fi
