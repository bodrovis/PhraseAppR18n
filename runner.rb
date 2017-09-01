require_relative 'bank/bank'

john_account = Bank::Account.new owner: 'John', balance: 20, gender: 'male'
kate_account = Bank::Account.new owner: 'Kate', balance: 15, gender: 'female'
puts john_account.info
john_account.transfer_to(kate_account, 10)

puts john_account.info
puts kate_account.info