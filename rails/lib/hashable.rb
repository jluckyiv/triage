module Hashable

  def digest_for(value)
    Digest::SHA1.hexdigest(value)
  end

end
