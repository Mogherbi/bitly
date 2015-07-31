require_relative '../config/environment'

a = ('a'..'z').to_a + (0..9).to_a
a = a.shuffle.join("").slice(0,7)

10.times do
  Url.create   :long_url      => Faker::Internet.url('google.com'),
               :short_url     => Faker::Internet.url('rsit.zz',"/#{a}"),
               :click_count   => Faker::Number.number(1)
                # :secret_key     => SecretKey.generate
end
