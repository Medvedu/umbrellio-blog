require "rom"

if Rails.env != "development" || Rails.env != "test"
  puts "Database can be seed only in development or test environment"
  exit -1
end


# ---------------------------------------------------- #


USERS_COUNT = 400
POSTS_COUNT = 600_000
RATES_COUNT = 25_000
IPS_COUNT = 75
POSTS_WITH_RATES_COUNT = 15_000


# ---------------------------------------------------- #


# @return [ROM::Container]
def rom
  @rom ||= ROM.container(:sql, ENV.fetch('database_url'),
                      username: ENV.fetch('database_username'),
                      password: ENV.fetch('database_password'),
                      pool_timeout: 2, max_connections: 2**16) \
  do |config|
    config.relation(:users) { schema(infer: true); auto_struct true }
    config.relation(:posts) { schema(infer: true); auto_struct true }
    config.relation(:rates) { schema(infer: true); auto_struct true }
  end
end

# @return [Array]
def ips_pool
  @ips_pool ||= IPS_COUNT.times.map { Faker::Internet.unique.public_ip_v4_address }
end

# @return [Array]
def authors_ids
  @authors_ids ||= rom.relations[:users].limit(USERS_COUNT).pluck(:id)
end

# @return [Array]
def posts_with_rates_ids
  @posts_ids ||= rom.relations[:posts].limit(POSTS_WITH_RATES_COUNT).pluck(:id)
end


# ---------------------------------------------------- #


puts "\n\nSeeding... Started at #{Time.now.strftime '%H:%M:%S'}.\n\n"


puts "Step 1. Creating users..."

def step_1_create_users
  ary = USERS_COUNT.times.map do
    { login: Faker::Name.name.split.join('_') }
  end # => [ {...}, {...}, {...} ]

  rom.relations[:users].multi_insert(ary)
end
step_1_create_users


puts "Step 2. Creating posts..."

def step_2_create_posts
  ary = POSTS_COUNT.times.map do
    {
      author_ip: ips_pool.sample,
      author_id: authors_ids.sample,

      title: Faker::Lorem.characters(1..30),
      body: Faker::Lorem.sentence(50)
    }
  end # => [ {...}, {...}, {...} ]

  rom.relations[:posts].multi_insert(ary)
end
step_2_create_posts


puts "Step 3. Adding rates..."

def step_3_add_rates
  ary = RATES_COUNT.times.map do
    {
      rate: rand(1..5),
      post_id: posts_with_rates_ids.sample
    }
  end # => [ {...}, {...}, {...} ]

  rom.relations[:rates].multi_insert(ary)

  ary.each do |hsh|
    post = rom.relations[:posts].by_pk(hsh[:post_id])
    rom_post = post.one

    post.command(:update).call({
      rate_sum: rom_post.rate_sum + hsh[:rate],
      rate_count: rom_post.rate_count + 1
    })
  end
end
step_3_add_rates


puts "Step 4. Prepare materialized view tables..."

def step_4_prepare_materialized_view
  rom.relations[:posts].read(<<~SQL
    REFRESH MATERIALIZED VIEW logins_per_uniq_ip;
  SQL
  ).call
end
step_4_prepare_materialized_view

puts "\nDone. Finished at #{Time.now.strftime '%H:%M:%S'}.\n\n"
