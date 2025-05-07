class AddPaymentJobEnqueuedToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :payment_job_enqueued, :boolean
  end
end
