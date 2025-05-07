class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: %i[checkout payment_success payment_failed show]

  def show
  end

  def create
    @products = Product.where(id: params[:product_ids])
    return redirect_to root_path if @products.empty?

    @order = current_user.orders.new
    if @order.save
      @products.each { |product| @order.order_items.create(product:, unit_price: product.price, quantity: 1) }
      redirect_to checkout_order_path(@order), status: :see_other
    else
      redirect_to root_path
    end
  end

  def checkout
    total_amount = @order.order_items.sum { |item| item.unit_price * item.quantity }
    subject = "Compra de #{@order.order_items.count} productos"
    return_url = payment_success_order_url(@order)
    cancel_url = payment_failed_order_url(@order)

    response = KhipuService.create_payment(total_amount, subject, return_url, cancel_url)
    Rails.logger.info "RESPUESTA DE KHIPU: #{response.inspect}"

    if response["payment_url"]
      @order.update(
        khipu_payment_id: response["payment_id"],
        khipu_payment_url: response["payment_url"],
        status: :pending
      )
      redirect_to @order.khipu_payment_url, allow_other_host: true, status: :see_other
    else
      @order.update(status: :failed)
      redirect_to root_path
    end
  end

  def payment_success
    @order = current_user.orders.find(params[:id])

    begin
      response = KhipuService.get_payment_status(@order.khipu_payment_id)
      if response["status"] == "done"
        @order.update(status: :paid)
        flash[:notice] = "¡Pago realizado con éxito!"
      else
        flash[:alert] = "Estamos verificando tu pago. Actualiza esta página en unos momentos."  # Si no se ha completado, mostramos un mensaje de espera
      end
      @order.update(status: :paid) if response["status"] == "done"
    rescue => e
      Rails.logger.error "Error verificando pago Khipu: #{e.message}"
    end

    redirect_to @order
  end

  def payment_failed
    @order.update(status: :failed)
    redirect_to @order
  end

  private

  def find_order
    @order = current_user.orders.find(params[:id])
  end
end
