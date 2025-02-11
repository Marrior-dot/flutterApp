FROM alpine:latest
# Install SQLite
RUN apk --no-cache add sqlite
# Create a directory to store the database
WORKDIR /home/marrior/Desktop/projetos/flutterApp/myapi
# Copy your SQLite database file into the container
COPY db.sqlite3 /home/marrior/Desktop/projetos/flutterApp/myapi
# Expose the port if needed
# EXPOSE 1433
# Command to run when the container starts
CMD ["sqlite3", "/data/initial-db.sqlite"]
