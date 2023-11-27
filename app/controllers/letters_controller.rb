require 'net/https'

class LettersController < ApplicationController
  RECAPTCHA_MINIMUM_SCORE = 0.5

  def create
    @letter = Letter.new(letter_params)

    unless verify_recaptcha?(params[:recaptcha_token], 'submit')
      render :bad_request
    end

    respond_to do |format|
      if @letter.save
        format.json { render json: {}, status: :ok }
      else
        format.js { render json: @letter.errors.full_messages, status: :bad_request }
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
    Rails.logger.info("Verufy reCAPTCHA uri = #{uri}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    Rails.logger.info("Verify reCAPTCHA response = #{json}")

    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end
end
