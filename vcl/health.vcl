backend server1 {
    .host = "server1.example.com";
    .probe = {
        .url = "/healthtest";
        .timeout = 1s;
        .interval = 4s;
        .window = 5;
        .threshold = 3;
    }
}
