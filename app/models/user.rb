class User < ApplicationRecord
  has_many :sns_credential, dependent: :destroy
  has_many :stamp_rallies, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :participate_stamp_rallies, through: :participants, class_name: 'StampRally', source: :stamp_rally, dependent: :destroy
  has_many :get_stamps, through: :participants, source: :stamps, dependent: :destroy

  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def own?(stamp_rally)
    stamp_rally.user_id == id
  end

  def participate(stamp_rally)
    participants.find_or_create_by(stamp_rally_id: stamp_rally.id)
  end

  def participate?(stamp_rally)
    participate_stamp_rallies.include?(stamp_rally)
  end

  def cancel_participate(stamp_rally)
    participate_stamp_rallies.destroy(stamp_rally)
  end

  def get?(stamp)
    get_stamps.include?(stamp)
  end

  def acquired_stamp_ids
    participants.joins(:participants_stamps).pluck('participants_stamps.stamp_id')
  end

  # パスワードなしで編集
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  # omuniauth使用で登録・ログイン
  class << self
    def without_sns_data(auth)
      user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token(10)
        )
        sns = SnsCredential.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user:, sns: }
    end

    def with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      if user.blank?
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          profile_image: auth.info.image,
          password: Devise.friendly_token(10)
        )
      end
      { user: }
    end

    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid:, provider:).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
      { user:, sns: }
    end
  end
end
