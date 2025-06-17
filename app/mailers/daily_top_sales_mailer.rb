class DailyTopSalesMailer < ApplicationMailer
	default from: ENV.fetch('DEFAULT_FROM_EMAIL', 'no-reply@example.com')

  def daily_report(email)
		return if email.blank?

    @email = email
    @top_sales = Invoice.top_sales_days(10)

    mail(to: email, subject: "¡Estos son los 10 días con más ventas!")
  end
end
