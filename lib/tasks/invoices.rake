desc "Generate and send invoices"
task :invoices => :environment do
  # Find all verified payments for last month
  # Filter users that earned more than US $20
  # Generate an invoice of 5% of verified payments for them.
  # Send the invoice by email

  if ENV['MONTH'].nil? or ENV['MONTH'].nil? 
    puts 'Please specify MONTH and YEAR.'
    return 1
  end

  month = ENV['MONTH'].to_i
  year = ENV['YEAR'].to_i

  for user in User.paid_in(month, year)
    earnings = user.total_earned_in(month, year)
    puts user.login + " earned $" + earnings.to_s
    if earnings < 20 then
      puts " and is therefore not billed." 
    else
      i = Invoice.new
      i.amount = 0.05 * earnings
      i.user_id = user.id
      i.year = year
      i.month = month
      i.billed_at = 0.hours.from_now
      i.due_at = 1.month.from_now
      i.save
    end

  end

  puts "Total invoices this month: $" + Invoice.total_for(month, year).to_s

  # All invoices are generated, now let's email them:
  for i in Invoice.billed_in(month, year)
    UserMailer.deliver_new_invoice(i)
  end
  
  puts "Emails sent."
end
