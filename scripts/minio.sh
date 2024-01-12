#!/bin/sh

# # Start MinIO server in background
# minio server /data &

# # Wait for the MinIO server to be up and running
# while ! nc -Z localhost 9000; do
#   sleep 1
# done

# # Configure MinIO Client with endpoint, access key, and secret key
# mc alias set myminio http://localhost:9000 ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}

# # Create the bucket if it doesn't exist
# mc mb myminio/rubypolska_development_bucket

# # Keep the container running
# wait