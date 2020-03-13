#!/usr/bin/env bash

set -x

su postgres -c "psql -v 'ON_ERROR_STOP=1' postgres </tmp/sql/10_create_admin_user.sql" && \
su postgres -c "psql -v 'ON_ERROR_STOP=1' postgres </tmp/sql/20_create_powerdns_database.sql" && \
su postgres -c "psql -v 'ON_ERROR_STOP=1' powerdns </tmp/sql/30_create_powerdns_user.sql" && \
su postgres -c "psql -v 'ON_ERROR_STOP=1' powerdns </tmp/sql/40_create_powerdns_tables.sql"