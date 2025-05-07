# app/services/khipu_service.rb
class KhipuService
  include HTTParty
  base_uri ENV.fetch("KHIPU_API_URL")

  # Constantes para los headers
  CONTENT_TYPE = "Content-Type".freeze
  API_KEY = "x-api-key".freeze

  # Llamada común para obtener las cabeceras
  def self.default_headers
    {
      CONTENT_TYPE => "application/json",
      API_KEY => ENV.fetch("KHIPU_API_KEY")
    }
  end

  # Crear un pago
  def self.create_payment(amount, subject, return_url, cancel_url)
    options = {
      headers: default_headers,
      body: {
        amount: amount,
        currency: "CLP",
        subject: subject,
        return_url: return_url,
        cancel_url: cancel_url
      }.to_json
    }

    response = post("/payments", options)
    handle_response(response)
  end

  # Obtener el estado de un pago
  def self.get_payment_status(payment_id)
    options = {
      headers: default_headers,
      timeout: 10 # timeout de 10 segundos
    }

    response = get("/payments/#{payment_id}", options)
    handle_response(response)
  end

  private

  # Manejar las respuestas y errores de las solicitudes HTTP
  def self.handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      log_error(response)
      { "error" => "Error #{response.code}", "status" => "unknown" }
    end
  end

  # Log de errores
  def self.log_error(response)
    Rails.logger.error "Khipu API Error: #{response.code} - #{response.body}"
  end
end
