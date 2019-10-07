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
end
