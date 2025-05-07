module Khipu
  class CreatePaymentService
    def initialize(amount:, subject:, return_url:, cancel_url:)
      @amount = amount
      @subject = subject
      @return_url = return_url
      @cancel_url = cancel_url
    end

    def call
      options = {
        headers: Khipu::ClientService.default_headers,
        body: {
          amount: @amount,
          currency: "CLP",
          subject: @subject,
          return_url: @return_url,
          cancel_url: @cancel_url
        }.to_json
      }

      Khipu::ClientService.post("/payments", options)
    end
  end
end
