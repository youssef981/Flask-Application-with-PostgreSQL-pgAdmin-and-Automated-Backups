#!/bin/bash

# Directory to store the backup
BACKUP_DIR="/backups"
# Filename for the backup
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d%H%M%S).sql"

# Perform the backup
pg_dump -h $POSTGRES_HOST -U $POSTGRES_USER $POSTGRES_DB > $BACKUP_FILE

# Keep backups for 7 days (optional)
find $BACKUP_DIR -type f -mtime +7 -name '*.sql' -exec rm {} \;
