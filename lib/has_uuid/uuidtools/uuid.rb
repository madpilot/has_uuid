# See https://github.com/jashmenn/activeuuid/blob/master/lib/activeuuid/uuid.rb
module UUIDTools
  class UUID
    alias_method :id, :raw

    # duck typing activerecord 3.1 dirty hack )
    def gsub *; self; end

    def quoted_id
      s = raw.unpack("H*")[0]
      "x'#{s}'"
    end

    def as_json(options = nil)
      hexdigest.downcase
    end

    def to_param
      hexdigest.downcase
    end

    def self.serialize(value)
      case value
      when self
        value
      when String
        parse_string value
      else
        nil
      end
    end

  private
    def self.parse_string(str)
      return nil if str.length == 0
      if str.length == 36
        parse str
      elsif str.length == 32
        parse_hexdigest str
      else
        parse_raw str
      end
    end
  end
end
