
# Start symmetric ds
https://www.symmetricds.org/doc/3.15/html/tutorials.html

1. start docker-compose

docker-compose up -d

# Setup symmetric ds
```shell
   cd  symmetric-server-3.14.10/
   mkdir tmp
   # create initial schema
   bin/dbimport --engine app-000 --format XML --alter-case samples/create_app_schema.xml
   bin/dbimport --engine contract-001 --format XML --alter-case samples/create_contract_schema.xml
   bin/dbimport --engine partner-002 --format XML --alter-case samples/create_partner_schema.xml
   
   bin/symadmin --engine app-000 create-sym-tables
   bin/symadmin --engine contract-001 create-sym-tables
   bin/symadmin --engine partner-002 create-sym-tables
   
   # create data but also setup the sym tables
   bin/dbimport --engine app-000 samples/insert_sample.sql
   
   
   #start sym
   bin/sym
   
   # new terminal: sync nodes initially to get data
   bin/symadmin --engine app-000 reload-node 001
   bin/symadmin --engine app-000 reload-node 002
   
   ```

   # Run contract-service
   ```shell
   mvn spring-boot:run

   ```

# Swagger

# Start UI
nvm use 18
cd contract-ui
ng serve


