resource "google_compute_instance_group" "all" {
    name = "group1"
    instances = ["${google_compute_instance.app.*.self_link}"]
    named_port {
      name = "namedport9292"
      port = "9292" 
    }
    zone = "europe-west1-d"
    }



resource "google_compute_target_http_proxy" "default" {
  name        = "test-proxy"
  description = "a description"
  url_map     = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
  name        = "url-map"
  description = "a description"
  default_service = "${google_compute_backend_service.website.self_link}"
  }


resource "google_compute_global_forwarding_rule" "default" {
  name       = "website-forwarding-rule"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80"
}


resource "google_compute_backend_service" "website" {
  name        = "my-backend"
  description = "Our company website"
  port_name   = "namedport9292"
  protocol    = "HTTP"
  timeout_sec = 2
  enable_cdn  = false

  backend {
    group = "${google_compute_instance_group.all.self_link}"
}
health_checks = ["${google_compute_health_check.default.self_link}"]
}


resource "google_compute_health_check" "default" {
  name               = "test"
  check_interval_sec = 60
  timeout_sec        = 60
  http_health_check {
  port = "9292"
     }
}

