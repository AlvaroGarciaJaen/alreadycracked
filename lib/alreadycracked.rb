require 'digest'

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
    hashes = {'fc5e038d38a57032085441e7fe7010b0' => 'helloworld',
              '6adfb183a4a2c94a2f92dab5ade762a47889a5a1' => 'helloworld',
              '936a185caaa266bb9cbe981e9e05cb78cd732b0b3280eb944412bb6f8f8f07af' => 'helloworld'
              }
    hashes[hash]
  end
end
