# 🛒 Challenge Khipu Payments

![Ruby](https://img.shields.io/badge/Ruby-3.2%2B-red)
![Rails](https://img.shields.io/badge/Rails-8.0%2B-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15%2B-blueviolet)

MVP con integración de pagos usando Khipu, diseñado para demostrar un flujo de compra **básico** pero completo. Un usuario puede autenticarse (usando devise gem), seleccionar productos, generar una orden de compra e iniciar el pago usando Khipu.

## 🚀 Requisitos Técnicos

- **Ruby** 3.2+
- **Rails** 8.0+
- **PostgreSQL** 15+
- **Bundler** 2.4+

## 🛠 Configuración Inicial

```
bash
git clone [repo_url]
cd [repo_name]
bundle install
rails db:create db:migrate db:seed
rails server

Al ejecutar el seed (db:seed), se crea el siguiente usuario de pruebas:

Email: user@example.com

Contraseña: password123
```

## TODO

- **Implementar webhooks de Khipu para manejar pagos confirmados incluso si el cliente no regresa al sitio.**

- **Agregar expiración automática a órdenes no pagadas**

- **Enviar correos al confirmar pago o cancelar**

- **Mejorar validaciones de datos**

- **y mucho mas xD**
