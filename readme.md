# Hele.cz wkhtmltopdf microservice

## Installation

Install and run project:

```
> npm install
> npm run-script start
```


## Usage

```
curl -X POST http://localhost:8900/compile -d '<h1>Hello world</h1>'
```

```
curl -X POST http://localhost:8900/compile -d 'https://www.google.com'
```


## Docker

Compile image

```
docker build -t wkhtmltopdf-microservice .
```

Run container

```
docker run -it --rm -p 8900:80 wkhtmltopdf-microservice
```
