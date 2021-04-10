class HashSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    hash = JSON.parse(hash) if hash.class == String
    (hash || {}).with_indifferent_access
  end
end
