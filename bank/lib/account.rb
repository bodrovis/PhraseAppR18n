module Bank
  class Account
    include R18n::Helpers
    attr_reader :owner, :balance, :gender
    VALID_GENDER = %w(male female).freeze

    def initialize(owner:, balance: 0, gender:)
      @owner = owner
      @balance = balance
      @gender = check_gender_validity_for gender
    end

    def transfer_to(another_account, amount)
      puts t.transaction.started i18n.locale.strftime Time.now, '%d %B %Y %H:%M:%S'
      begin
        withdraw(amount)
        another_account.credit amount
      rescue WithdrawError => e
        puts e
      else
        puts t.account.transfer self, owner, another_account.owner, i18n.locale.format_integer(amount)
      ensure
        puts t.transaction.ended i18n.locale.strftime Time.now, '%d %B %Y %H:%M:%S'
      end
    end

    def credit(amount)
      @balance += amount
    end

    def withdraw(amount)
      raise(WithdrawError, t.errors.not_enough_money_for_withdrawal) if balance < amount
      @balance -= amount
    end

    def info
      t.account.info(owner, gender, i18n.locale.format_integer(balance))
    end

    private

    def check_gender_validity_for(gender)
      VALID_GENDER.include?(gender) ? gender : 'male'
    end
  end
end