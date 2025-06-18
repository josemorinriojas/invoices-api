module CacheableQuery
  extend ActiveSupport::Concern

  class_methods do
    def fetch_cache(key, expires_in: 6.hours)
      cached = $redis.get(key)
      if cached.present?
        JSON.parse(cached)
      else
        result = yield
        $redis.set(key, result.to_json, ex: expires_in.to_i)
        result
      end
    end

    def cache_key_for(prefix, *parts)
      keys = parts.map { |p| p.to_i }.join(":")
      "#{prefix}:#{keys}"
    end
  end
end
