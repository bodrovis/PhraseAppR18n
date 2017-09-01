module Bank
  class LocaleSettings
    def initialize
      puts "Select locale's code:"

      R18n::Filters.add('gender', :gender) do |translation, config, user|
        translation.length > 1 ? translation[user.gender] : translation['base']
      end

      R18n.from_env 'bank/lib/i18n/'

      R18n.get.available_locales.each do |locale|
       puts "#{locale.title} (#{locale.code})"
      end

      change_locale_to gets.strip.downcase
    end

    private

    def change_locale_to(locale)
      locale = 'en' unless R18n.get.available_locales.map(&:code).include?(locale)
      R18n.from_env 'bank/lib/i18n/', locale
    end
  end
end