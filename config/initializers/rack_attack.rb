class Rack::Attack

    # Array of String or Regexp
    UNTHROTTLED_PATHS = [
      '/assets/'
    ].freeze
    # Compile the list above into one regex
    UNTHROTTLED_PATHS_REGEX = Regexp.union(UNTHROTTLED_PATHS.map { |path| path.is_a?(Regexp) ? path : /\A#{Regexp.escape(path)}/ })
  
    # Always allow requests from localhost
    # (blocklist & throttles are skipped)
    safelist('allow from localhost') do |req|
      # Requests are allowed if the return value is truthy
      req.ip == '127.0.0.1' || req.ip == '::1'
    end
  
    # Throttle ALL requests but those targeting the whitelisted assets
    throttle('requests/ip', limit: 300, period: 5.minutes) do |req|
      req.ip unless req.path =~ UNTHROTTLED_PATHS_REGEX
    end
  
    UNSAFE_METHODS = ['POST', 'PUT', 'PATCH', 'DELETE'].freeze
    # Throttle requests to Devise routes that must not be bruteforced. (only concerning login and signup for now)
    throttle('devise/ip', limit: 5, period: 20.seconds) do |req|
      req.ip if UNSAFE_METHODS.include?(req.request_method) && req.path.starts_with?('/sessions')
    end
    
    throttle('devise/ip', limit: 3, period: 60.seconds) do |req|
      req.ip if UNSAFE_METHODS.include?(req.request_method) && req.path.starts_with?('/users')
    end
    
    ### Custom Throttle Response ###
  
    # By default, Rack::Attack returns an HTTP 429 for throttled responses, which is just fine.
    self.throttled_response = lambda do |_env|
      [
        429,  # status
        {},   # headers
        ['Too many requests, please try again in a few seconds.'] # body
      ]
    end
  
  end
  
  # Log Rack::Attack hits!
  ActiveSupport::Notifications.subscribe(/rack_attack/) do |_name, _start, _finish, _request_id, payload|
    req = payload[:request]
    # Only log :throttle and :blocklist events
    next unless req.env['rack.attack.match_type'].in?([:throttle, :blocklist])
  
    Rails.logger.info("Rack::Attack #{req.env['rack.attack.match_type']} #{req.ip} #{req.request_method} \"#{req.fullpath}\"")
  end
  