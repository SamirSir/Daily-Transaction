class Profile < ApplicationRecord

    # ActiveSupport MessageVerifier
    # @verifier = ActiveSupport::MessageVerifier.new('s3Krit', digest: 'SHA256')
    # token = @verifier.generate("Image Input", purpose: :create_profile)
    # @verifier.verify(token, purpose: :create_profile)
    

    has_one_attached :profile_pic
    has_one_attached :cover_pic
    belongs_to :user
end
