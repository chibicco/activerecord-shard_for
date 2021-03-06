require 'active_record'
require 'expeditor'
require 'activerecord/shard_for/version'
require 'activerecord/shard_for/abstract_shard_repository'
require 'activerecord/shard_for/config'
require 'activerecord/shard_for/cluster_config'
require 'activerecord/shard_for/model'
require 'activerecord/shard_for/errors'
require 'activerecord/shard_for/connection_router'
require 'activerecord/shard_for/hash_modulo_router'
require 'activerecord/shard_for/distkey_router'
require 'activerecord/shard_for/database_tasks'
require 'activerecord/shard_for/shard_repository'
require 'activerecord/shard_for/all_shards_in_parallel'
require 'activerecord/shard_for/replication_mapping'
require 'activerecord/shard_for/railtie' if defined?(Rails)
require 'activerecord/shard_for/patch'
require 'activerecord/shard_for/sti'
require 'activerecord/shard_for/sti_shard_repository'

module ActiveRecord
  module ShardFor
    class << self
      # @return [Activerecord::ShardFor::Config]
      def config
        @config ||= Config.new
      end

      # @yield [Activerecord::ShardFor::Config]
      def configure(&block)
        config.instance_eval(&block)
      end
    end
  end
end

ActiveRecord::ShardFor.configure do |config|
  config.register_connection_router(:hash_modulo, ActiveRecord::ShardFor::HashModuloRouter)
  config.register_connection_router(:distkey, ActiveRecord::ShardFor::DistkeyRouter)
end
