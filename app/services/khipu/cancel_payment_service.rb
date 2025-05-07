module Khipu
  class CancelPaymentService
    def initialize(payment_id:)
      @payment_id = payment_id
    end

    def call
      options = {
        headers: Khipu::ClientService.default_headers
      }

      Khipu::ClientService.delete("/payments/#{@payment_id}", options)
    end
  end
end
