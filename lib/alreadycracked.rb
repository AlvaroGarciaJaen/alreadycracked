require 'digest'
require 'json'

class AlreadyCracked
  def initialize
    path = File.join File.dirname(__FILE__), '../t/sample.json'
    @hashes = JSON.parse File.read path
  end

  def compute_digest(type, plain, save=false)
    case
    when type == 'md5'
      hash = Digest::MD5.hexdigest plain
    when type == 'sha1'
      hash = Digest::SHA1.hexdigest plain
    when type == 'sha256'
      hash = Digest::SHA256.hexdigest plain
    end
    if save
      @hashes[hash] = plain
    end
    hash
  end

  def get_hash_types
    ['md5', 'sha1', 'sha256']
  end

  def detect_digest(hash)
    case hash.length
    when 32
      'md5'
    when 40
      'sha1'
    when 64
      'sha256'
    end
  end

  def get_plain(hash)
    # TODO: use MongoDB
    @hashes[hash]
  end
end
