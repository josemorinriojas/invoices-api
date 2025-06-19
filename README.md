# 🚀 Invoices Rails API  App Setup Guide

Este proyecto es una aplicación **Ruby on Rails (API-only)** que utiliza:

- PostgreSQL como base de datos
- Redis como sistema de almacenamiento en caché y cola
- Sidekiq para ejecución de procesos en background
- RSpec para pruebas unitarias


## 🔧 Requisitos Previos

Asegúrate de tener instalado:

- Ruby (versión recomendada: 3.x)
- Rails (versión recomendada: 7.x)
- PostgreSQL
- Redis
- Bundler

## 📦 Instalación y Setup Inicial

### 1. Clonar el repositorio

```bash
git clone git@github.com:josemorinriojas/invoices-api.git
cd invoices-api
```

Instalar gemas
```bash
bundle install
```

### Configurar base de datos
No se requiere configuración local. La base de datos se conecta a un servidor remoto. Asegúrate de tener las variables de entorno correctas para acceder.

Agrega las siguientes variable de entorno, modifica usuarios y contraseñas de acuerdo a tu configuracion local 

.env

```bash
REDIS_URL=redis://localhost:6379/0
DEFAULT_REPORT_EMAIL='jose.morin.riojas@gmail.com'
DEFAULT_FROM_EMAIL='noreply@email.com'

DB_HOST=devtestdatabase.contalink.com
DB_USERNAME=developer
DB_NAME=testinvoices
DB_PASSWORD=UQpaA9TA

DB_TEST_HOST=localhost
DB_TEST_PORT=5432
DB_TEST_NAME=test_db
DB_TEST_USERNAME=your_username
DB_TEST_PASSWORD=your_password
```

Luego ejecuta:
```bash
rails db:create RAILS_ENV=test
rails db:migrate RAILS_ENV=test
```


### Redis y Sidekiq

####  Inicia Redis
```bash
sudo service redis-server start
```

####  Inicia Sidekiq
Para facilitar las pruebas del job, se puede ajustar la configuración del archivo config/sidekiq.yml, modificando la expresión cron para que el job se ejecute cada minuto en lugar de a las 10:00 a. m. Esto permite verificar su funcionamiento sin tener que esperar al horario programado.

```bash
bundle exec sidekiq
```
Ver actividad en: http://localhost:3000/sidekiq

### Mailcatcher
Para interceptar correos enviados en desarrollo:

```bash
mailcatcher
```
Ver correos en: http://localhost:1080

###  Ejecutar pruebas
```bash
bundle exec rspec
```

###  Levantar la app

```bash
rails s
```