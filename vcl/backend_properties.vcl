backend default {
    .host = "localhost";
    .port = "80";
    .connect_timeout = 0.5s;
    .first_byte_timeout = 20s;
    .between_bytes_timeout = 5s;
    .max_connections = 50;
}
