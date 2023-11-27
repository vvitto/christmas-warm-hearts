require 'net/https'

class LettersController < ApplicationController
  RECAPTCHA_MINIMUM_SCORE = 0.5

  def create
    @letter = Letter.new(letter_params)

    respond_to do |format|
      if verify_recaptcha?(params[:recaptcha_token], 'submit') && @letter.save
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :bad_request }
      end
    end
  end

  private

  def letter_params
    params.require(:letter).permit(:letter_text)
  end

  def verify_recaptcha?(token, recaptcha_action)
    secret_key = Rails.configuration.recaptcha[:recaptcha_secret_key]
    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    Rails.logger.info("Verify reCAPTCHA response = #{json}")

    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end
end
