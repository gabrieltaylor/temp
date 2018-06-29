require "openssl"
require "base64"

class SmsCallbackForm
  include ActiveModel::Model

  ALLOWED_VARIANCE_SECONDS = 2

  attr_accessor :raw_body, :timestamp, :signature

  validates :raw_body, :timestamp, :signature, presence: true

  validate :timestamp_within_acceptable_variance, :signature_of_body

  private

  def signature_of_body
    signed_request = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), key, data)).strip()

    if signed_request != signature
      errors.add(:signature, "is invalid")
    end
  end

  def timestamp_within_acceptable_variance
    now = Time.now.utc.to_i
    if (now - timestamp.to_i) > ALLOWED_VARIANCE_SECONDS
      errors.add(:timestamp, "is not within #{ALLOWED_VARIANCE_SECONDS} of the current time")
    end
  end

  def data
    "#{timestamp}.#{raw_body}"
  end

  def key
    ENV["TELNYX_MESSAGING_PROFILE_SECRET"]
  end
end
