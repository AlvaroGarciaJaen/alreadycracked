require 'digest'
require 'json'

class AlreadyCracked
  def compute_digest(type, plain)
    case
    when type == 'md5'
      Digest::MD5.hexdigest plain
    when type == 'sha1'
      Digest::SHA1.hexdigest plain
    when type == 'sha256'
      Digest::SHA256.hexdigest plain
    end
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
    hashes = JSON.parse File.read 't/sample.json'

    hashes[hash]
  end
end
