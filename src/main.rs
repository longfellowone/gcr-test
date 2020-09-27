// docker build -t gcrtest .
// docker run -p 8080:80 gcrtest
// docker stop $(docker ps -a -q)

use actix_web::{get, App, HttpResponse, HttpServer, Responder};
use actix_cors::Cors;

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("Starting server...");

    HttpServer::new(|| {
        App::new()
            .wrap(Cors::new().finish())
            .service(hello)
    })
        .bind("0.0.0.0:8080")?
        .run()
        .await
}